//
//  NSManagedObject+VDCoreData.m
//  VD
//
//  Created by Evgeniy Tka4enko on 03.07.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import "NSManagedObject+VDCoreData.h"
#import "VDManagedObjectContextManager.h"

@implementation NSManagedObject (VDCoreData)

+ (NSString *)entityName
{
    return NSStringFromClass([self class]);
}

+ (NSString *)modelName
{
    NSString *modelName;
    
    NSString *bundleRoot = [[NSBundle mainBundle] bundlePath];
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *dirContents = [fm contentsOfDirectoryAtPath:bundleRoot error:nil];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self ENDSWITH '.momd'"];
    NSArray *onlyModels = [dirContents filteredArrayUsingPredicate:predicate];
    
    if([onlyModels count] > 0)
    {
        modelName = [onlyModels objectAtIndex:0];
        modelName = [modelName stringByReplacingOccurrencesOfString:@".momd" withString:@""];
    }
    
	if (modelName)
    {
		return modelName;
	}
    
    NSLog(@"You must implement a modelName class method in your entity subclass and add .xcdatamodeld file.  Aborting.");
	abort();
}

+ (void)deleteStore
{
	[[self managedObjectContextManager] deleteStore];
}

+ (NSEntityDescription *)entityDescription
{
	return [NSEntityDescription entityForName:[self entityName] inManagedObjectContext:[self managedObjectContextForCurrentThread]];
}

+ (void)commit
{
	[[self managedObjectContextManager] commit];
}

+ (id)newEntity
{
	return [NSEntityDescription insertNewObjectForEntityForName:[self entityName] inManagedObjectContext:[self managedObjectContextForCurrentThread]];
}

+ (id)newOrExistingEntityWithPredicate:(NSPredicate *)predicate
{
    id existing = [self fetchObjectWithPredicate:predicate];
    return existing ? existing : [self newEntity];
}

+ (id)fetchObject
{
    return [self fetchObjectWithPredicate:nil];
}

+ (id)fetchObjectWithPredicate:(NSPredicate *)predicate
{
	NSArray *results = [self fetchObjectsWithPredicate:predicate];
    
	if ([results count] > 0)
    {
		return [results objectAtIndex:0];
	}
    
	return nil;
}

+ (id)fetchObjectWithPredicate:(NSPredicate *)predicate sortDescriptor:(NSSortDescriptor *)descriptor
{
	NSArray *results = [self fetchObjectsWithPredicate:predicate sortDescriptor:descriptor];
    
	if ([results count] > 0)
    {
		return [results objectAtIndex:0];
	}
    
	return nil;
}

+ (NSArray *)fetchAllObjects
{
	return [self fetchObjectsWithPredicate:nil];
}

+ (NSArray *)fetchObjectsWithPredicate:(NSPredicate *)predicate
{
	return [self fetchObjectsWithPredicate:predicate sortDescriptor:nil];
}

+ (NSArray *)fetchObjectsWithPredicate:(NSPredicate *)predicate sortDescriptor:(NSSortDescriptor *)descriptor
{
	return [self fetchObjectsWithPredicate:predicate sortDescriptor:descriptor withLimit:0];
}

+ (NSArray *)fetchObjectsWithPredicate:(NSPredicate *)predicate sortDescriptor:(NSSortDescriptor *)descriptor withLimit:(NSNumber *)limit
{
	NSFetchRequest *fetch = [[NSFetchRequest alloc] init];
    
	[fetch setEntity:[self entityDescription]];
    
	if (predicate)
    {
		[fetch setPredicate:predicate];
	}
    
	if (descriptor)
    {
		[fetch setSortDescriptors:[NSArray arrayWithObject:descriptor]];
	}
    
	if (limit)
    {
		[fetch setFetchLimit:[limit integerValue]];
	}
    
	[fetch setIncludesPendingChanges:YES];
    
	return [[self managedObjectContextForCurrentThread] executeFetchRequest:fetch error:nil];
}

+ (NSArray *)fetchObjectsWithPredicate:(NSPredicate *)predicate sortDescriptor:(NSSortDescriptor *)descriptor withLimit:(NSNumber *)limit withOffset:(NSNumber *)offset
{
	NSFetchRequest *fetch = [[NSFetchRequest alloc] init];
    
	[fetch setEntity:[self entityDescription]];
    
	if (predicate)
    {
		[fetch setPredicate:predicate];
	}
    
	if (descriptor)
    {
		[fetch setSortDescriptors:[NSArray arrayWithObject:descriptor]];
	}
    
	if (limit)
    {
		[fetch setFetchLimit:[limit integerValue]];
	}
    
    if (offset)
    {
		[fetch setFetchOffset:[offset integerValue]];
	}
    
	[fetch setIncludesPendingChanges:YES];
    
	return [[self managedObjectContextForCurrentThread] executeFetchRequest:fetch error:nil];
}

+ (NSUInteger)count
{
	return [self countWithPredicate:nil];
}

+ (NSUInteger)countWithPredicate:(NSPredicate *)predicate
{
	NSFetchRequest *fetch = [[NSFetchRequest alloc] init];
    
	[fetch setEntity:[self entityDescription]];
    
	if (predicate)
    {
		[fetch setPredicate:predicate];
	}
    
	return [[self managedObjectContextForCurrentThread] countForFetchRequest:fetch error:nil];
}

+ (NSArray *)distinctValuesWithAttribute:(NSString *)attribute predicate:(NSPredicate *)predicate
{
	NSArray *items = [self fetchObjectsWithPredicate:predicate];
	NSString *keyPath = [@"@distinctUnionOfObjects." stringByAppendingString:attribute];
	return [[items valueForKeyPath:keyPath] sortedArrayUsingSelector:@selector(compare:)];
}

+ (NSString*)aggregateToString:(VDAggregate)aggregate
{
    switch(aggregate)
    {
        case VDAggregateMax:
            return @"max:";
        case VDAggregateMin:
            return @"min:";
		case VDAggregateAverage:
            return @"average:";
		case VDAggregateSum:
			return @"sum:";
        default:
            [NSException raise:NSGenericException format:@"Unexpected FormatType."];
    }
}

+ (NSAttributeType)attributeTypeWithKey:(NSString *)key
{
	NSEntityDescription *entityDescription = [self entityDescription];
	NSDictionary *properties = [entityDescription propertiesByName];
	NSAttributeDescription *attribute = [properties objectForKey:key];
	return [attribute attributeType];
}

+ (id)aggregateWithType:(VDAggregate)aggregate key:(NSString *)key predicate:(NSPredicate *)predicate defaultValue:(id)defaultValue
{
	NSFetchRequest *fetch = [[NSFetchRequest alloc] init];
    
	if (predicate)
    {
		[fetch setPredicate:predicate];
	}
    
	NSString *aggregateString = [self aggregateToString:aggregate];
	NSAttributeType attributeType = [self attributeTypeWithKey:key];
    
	NSEntityDescription *entity = [self entityDescription];
	[fetch setEntity:entity];
	[fetch setResultType:NSDictionaryResultType];
    
	NSExpression *keyPathExpression = [NSExpression expressionForKeyPath:key];
	NSExpression *expression = [NSExpression expressionForFunction:aggregateString arguments:[NSArray arrayWithObject:keyPathExpression]];
    
	NSExpressionDescription *expressionDescription = [[NSExpressionDescription alloc] init];
	[expressionDescription setName:key];
	[expressionDescription setExpression:expression];
	[expressionDescription setExpressionResultType:attributeType];
    
	[fetch setPropertiesToFetch:[NSArray arrayWithObject:expressionDescription]];
    
	NSError *error;
	NSArray *objects = [[self managedObjectContextForCurrentThread] executeFetchRequest:fetch error:&error];
    
	id returnValue = nil;
    
	if ((objects != nil) && ([objects count] > 0) ) {
		returnValue = [[objects lastObject] valueForKey:key];
	}
    
	if (returnValue == nil) {
		returnValue = defaultValue;
	}
    
	return returnValue;
}

+ (void)deleteAll
{
    [self deleteWithPredicate:nil];
}

+ (NSUInteger)deleteWithPredicate:(NSPredicate *)predicate
{
    NSArray *itemsToDelete = [self fetchObjectsWithPredicate:predicate];
    [itemsToDelete makeObjectsPerformSelector:@selector(delete)];
    return [itemsToDelete count];
}

+ (NSManagedObjectContext *)managedObjectContext
{
    return [self managedObjectContextForCurrentThread];
}

+ (NSManagedObjectContext *)managedObjectContextForCurrentThread
{
	return [[self managedObjectContextManager] managedObjectContextForCurrentThread];
}

+ (VDManagedObjectContextManager *)managedObjectContextManager
{
    return [VDManagedObjectContextManager sharedInstanceWithModelName:[self modelName]];
}

+ (BOOL)doesRequireMigration
{
	return [[self managedObjectContextManager] doesRequireMigration];
}

- (void)delete
{
	[[self managedObjectContext] deleteObject:self];
}

- (id)clone
{
	NSEntityDescription *entityDescription = [self entity];
	NSString *entityName = [entityDescription name];
	NSManagedObject *cloned = [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:[self managedObjectContext]];
    
    for (NSString *attr in [entityDescription attributesByName])
    {
        [cloned setValue:[self valueForKey:attr] forKey:attr];
    }
    
    return cloned;
}

- (id)objectInCurrentThreadContext
{
	NSManagedObjectContext *currentMoc = [[self class] performSelector:@selector(managedObjectContextForCurrentThread)];
	return [currentMoc objectWithID:self.objectID];
}

@end
