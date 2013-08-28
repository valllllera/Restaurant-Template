//
//  NSManagedObject+VDCoreData.h
//  VD
//
//  Created by Evgeniy Tka4enko on 03.07.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import <CoreData/CoreData.h>

typedef enum
{
    VDAggregateMax,
	VDAggregateMin,
	VDAggregateAverage,
	VDAggregateSum
} VDAggregate;

@class VDManagedObjectContextManager;

@interface NSManagedObject (VDCoreData)

+ (NSString *)entityName;
+ (NSString *)modelName;

+ (NSEntityDescription *)entityDescription;
+ (void)deleteStore;
+ (void)commit;
+ (id)newEntity;
+ (id)newOrExistingEntityWithPredicate:(NSPredicate *)predicate;

+ (id)fetchObject;
+ (id)fetchObjectWithPredicate:(NSPredicate *)predicate;
+ (id)fetchObjectWithPredicate:(NSPredicate *)predicate sortDescriptor:(NSSortDescriptor *)descriptor;

+ (NSArray *)fetchAllObjects;
+ (NSArray *)fetchObjectsWithPredicate:(NSPredicate *)predicate;
+ (NSArray *)fetchObjectsWithPredicate:(NSPredicate *)predicate sortDescriptor:(NSSortDescriptor *)descriptor;
+ (NSArray *)fetchObjectsWithPredicate:(NSPredicate *)predicate sortDescriptor:(NSSortDescriptor *)descriptor withLimit:(NSNumber *)limit;
+ (NSArray *)fetchObjectsWithPredicate:(NSPredicate *)predicate sortDescriptor:(NSSortDescriptor *)descriptor withLimit:(NSNumber *)limit withOffset:(NSNumber *)offset;

+ (NSUInteger)count;
+ (NSUInteger)countWithPredicate:(NSPredicate *)predicate;

+ (NSArray *)distinctValuesWithAttribute:(NSString *)attribute predicate:(NSPredicate *)predicate;
+ (NSAttributeType)attributeTypeWithKey:(NSString *)key;
+ (id)aggregateWithType:(VDAggregate)aggregate key:(NSString *)key predicate:(NSPredicate *)predicate defaultValue:(id)defaultValue;

+ (void)deleteAll;
+ (NSUInteger)deleteWithPredicate:(NSPredicate *)predicate;
+ (NSManagedObjectContext *)managedObjectContext __deprecated;
+ (NSManagedObjectContext *)managedObjectContextForCurrentThread;
+ (VDManagedObjectContextManager *)managedObjectContextManager;
+ (BOOL)doesRequireMigration;

- (void)delete;
- (id)clone;
- (id)objectInCurrentThreadContext;

@end
