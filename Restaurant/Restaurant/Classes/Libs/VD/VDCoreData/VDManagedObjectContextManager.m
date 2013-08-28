//
//  VDManagedObjectContextManager.m
//  VD
//
//  Created by Evgeniy Tka4enko on 02.07.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import "VDManagedObjectContextManager.h"
#import "VDCoreDataConsts.h"

@interface VDManagedObjectContext : NSManagedObjectContext

@property (nonatomic, weak) id observer;

@end


@implementation VDManagedObjectContext

@synthesize observer;

- (void)setObserver:(id)_observer
{
	if (_observer != self.observer)
    {
		[[NSNotificationCenter defaultCenter] removeObserver:self.observer name:NSManagedObjectContextDidSaveNotification object:self];
        
		observer = _observer;
        
		[[NSNotificationCenter defaultCenter] addObserver:self.observer
												 selector:@selector(mocDidSave:)
													 name:NSManagedObjectContextDidSaveNotification
												   object:self];
	}
}

- (void)dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self.observer name:NSManagedObjectContextDidSaveNotification object:self];
}

@end


@interface VDManagedObjectContextManager()

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContextForMainThread;
@property (nonatomic, strong) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, strong) NSString *modelName;
@property (nonatomic, strong) NSString *guid;

+ (NSMutableDictionary *)sharedInstances;
- (NSString *)storePath;
- (NSURL *)storeURL;
- (NSString *)databaseName;
- (void)mocDidSave:(NSNotification *)saveNotification;

@end

@implementation VDManagedObjectContextManager

@synthesize managedObjectContextForMainThread;
@synthesize managedObjectModel;
@synthesize persistentStoreCoordinator;
@synthesize modelName;
@synthesize guid;

#pragma mark - Singleton Methods
+ (VDManagedObjectContextManager *)sharedInstanceWithModelName:(NSString *)modelName
{
    if ([[self sharedInstances] objectForKey:modelName] == nil)
    {
        VDManagedObjectContextManager *contextManager = [[VDManagedObjectContextManager alloc] initWithModelName:modelName];
        [[self sharedInstances] setObject:contextManager forKey:modelName];
    }
    
    return [[self sharedInstances] objectForKey:modelName];
}

+ (NSMutableDictionary *)sharedInstances
{
    static dispatch_once_t once;
    static NSMutableDictionary *sharedInstances;
    dispatch_once(&once, ^{
        sharedInstances = [[NSMutableDictionary alloc] init];
    });
    return sharedInstances;
}

- (id)initWithModelName:(NSString *)_modelName
{
    if (self=[super init]) {
        self.modelName = _modelName;
    }
    return self;
}

#pragma mark -
#pragma mark Other useful stuff
// Used to flush and reset the database.
- (void)deleteStore
{
	NSFileManager *fm = [NSFileManager defaultManager];
	NSError *error;
    
	if (persistentStoreCoordinator == nil)
    {
		NSString *storePath = [self storePath];
        
		if ([fm fileExistsAtPath:storePath] && [fm isDeletableFileAtPath:storePath])
        {
			[fm removeItemAtPath:storePath error:&error];
		}
        
	}
    else
    {
		NSPersistentStoreCoordinator *storeCoordinator = [self persistentStoreCoordinator];
        
		for (NSPersistentStore *store in [storeCoordinator persistentStores])
        {
			NSURL *storeURL = store.URL;
			NSString *storePath = storeURL.path;
			[storeCoordinator removePersistentStore:store error:&error];
            
			if ([fm fileExistsAtPath:storePath] && [fm isDeletableFileAtPath:storePath])
            {
				[fm removeItemAtPath:storePath error:&error];
			}
		}
	}
    
	self.managedObjectContextForMainThread = nil;
	self.managedObjectModel = nil;
	self.persistentStoreCoordinator = nil;
	self.guid = nil;
    
	[[VDManagedObjectContextManager sharedInstances] removeObjectForKey:[self modelName]];
}

- (NSString *)guid
{
	if (guid == nil)
    {
		CFUUIDRef uuid = CFUUIDCreate(kCFAllocatorDefault);
		NSString *uuidStr = (__bridge_transfer NSString *)CFUUIDCreateString(kCFAllocatorDefault, uuid);
		CFRelease(uuid);
        
		self.guid = [uuidStr lowercaseString];
	}
	return guid;
}

- (NSUInteger)pendingChangesCount
{
	NSManagedObjectContext *moc = [self managedObjectContextForCurrentThread];
    
	NSSet *updated  = [moc updatedObjects];
	NSSet *deleted  = [moc deletedObjects];
	NSSet *inserted = [moc insertedObjects];
    
	return [updated count] + [deleted count] + [inserted count];
}

- (void)commit
{
    
 	NSManagedObjectContext *moc = [self managedObjectContextForCurrentThread];
	NSError *error = nil;
    
	if ([self pendingChangesCount] > kPostMassUpdateNotificationThreshold)
    {
		[[NSNotificationCenter defaultCenter] postNotificationName:VDWillMassUpdateNotification object:nil];
	}
    
	if ([moc hasChanges] && ![moc save:&error]) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}
}

#pragma mark - Core Data stack
- (NSManagedObjectContext *)managedObjectContextForMainThread
{
	if (managedObjectContextForMainThread == nil)
    {
		NSAssert([NSThread isMainThread], @"Must be instantiated on main thread.");
		self.managedObjectContextForMainThread = [[NSManagedObjectContext alloc] init];
		[managedObjectContextForMainThread setPersistentStoreCoordinator:[self persistentStoreCoordinator]];
		[managedObjectContextForMainThread setMergePolicy:kMergePolicy];
	}
    
	return managedObjectContextForMainThread;
}

- (NSManagedObjectContext *)managedObjectContextForCurrentThread
{
	NSThread *thread = [NSThread currentThread];
    
	if ([thread isMainThread])
    {
		return [self managedObjectContextForMainThread];
	}
    
	NSString *threadKey = [NSString stringWithFormat:@"VDManagedObjectContext_%@_%@", self.modelName, self.guid];
    
	if ([[thread threadDictionary] objectForKey:threadKey] == nil)
    {
        VDManagedObjectContext *threadContext = [[VDManagedObjectContext alloc] init];
        [threadContext setPersistentStoreCoordinator:[self persistentStoreCoordinator]];
		[threadContext setMergePolicy:kMergePolicy];
		[threadContext setObserver:self];
        
		[[thread threadDictionary] setObject:threadContext forKey:threadKey];
    }
    
	return [[thread threadDictionary] objectForKey:threadKey];
}

- (NSManagedObjectModel *)managedObjectModel
{
	if (managedObjectModel == nil)
    {
		NSString *modelPath = [[NSBundle mainBundle] pathForResource:self.modelName ofType:@"momd"];
		NSURL *modelURL = [NSURL fileURLWithPath:modelPath];
        
		self.managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
	}
    
	return managedObjectModel;
}

- (void)mocDidSave:(NSNotification *)saveNotification
{
    if ([NSThread isMainThread])
    {
		NSDictionary *userInfo = saveNotification.userInfo;
        
		NSArray *updates = [[userInfo objectForKey:@"updated"] allObjects];
		for (NSManagedObject *item in updates)
        {
			[[item objectInCurrentThreadContext] willAccessValueForKey:nil];
		}
        
		NSArray *inserted = [[userInfo objectForKey:@"inserted"] allObjects];
		for (NSManagedObject *item in inserted)
        {
			[[item objectInCurrentThreadContext] willAccessValueForKey:nil];
		}
        
        [[self managedObjectContextForMainThread] mergeChangesFromContextDidSaveNotification:saveNotification];
    }
    else
    {
        [self performSelectorOnMainThread:@selector(mocDidSave:) withObject:saveNotification waitUntilDone:NO];
    }
}

- (BOOL)doesRequireMigration
{
	if ([[NSFileManager defaultManager] fileExistsAtPath:[self storePath]])
    {
		NSError *error;
		NSDictionary *sourceMetadata = [NSPersistentStoreCoordinator metadataForPersistentStoreOfType:NSSQLiteStoreType URL:[self storeURL] error:&error];
		return ![[self managedObjectModel] isConfiguration:nil compatibleWithStoreMetadata:sourceMetadata];
	}
    else
    {
		return NO;
	}
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{   
	if (persistentStoreCoordinator == nil)
    {
		@synchronized(self)
        {
			NSString *storePath = [self storePath];
			NSFileManager *fileManager = [NSFileManager defaultManager];
            
			if (![fileManager fileExistsAtPath:storePath])
            {
				NSString *defaultStorePath = [[NSBundle mainBundle] pathForResource:[self databaseName] ofType:nil];
                
				if ([fileManager fileExistsAtPath:defaultStorePath])
                {
					[fileManager copyItemAtPath:defaultStorePath toPath:storePath error:NULL];
				}
			}
            
			NSURL *storeURL = [self storeURL];
			NSError *error = nil;
            
			self.persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
            
			NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
									 [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
									 [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
            
			if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error])
            {
				NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
				abort();
			}
		}
	}
    
	return persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory
- (NSString *)storePath
{
	return [DocumentsDirectory() stringByAppendingPathComponent:[self databaseName]];
}

- (NSURL *)storeURL
{
	return [NSURL fileURLWithPath:[self storePath]];
}

- (NSString *)databaseName
{
    return [NSString stringWithFormat:@"%@.sqlite", [self.modelName lowercaseString]];
}

@end