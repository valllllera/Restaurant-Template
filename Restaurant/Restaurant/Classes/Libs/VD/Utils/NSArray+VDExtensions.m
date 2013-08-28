//
//  NSArray+VDExtensions.m
//  VD
//
//  Created by Evgeniy Tka4enko on 01.07.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import "NSArray+VDExtensions.h"

@implementation NSArray (VDExtensions)

- (id)firstObject
{
    if (self.count == 0)
    {
        return nil;
    }
    return self[0];
}

- (id)randomObject
{
    if (self.count == 0)
    {
        return nil;
    }
    
    NSInteger index = arc4random() % self.count;
    return self[index];
}

- (NSArray *)arrayByRemovingObject:(id)object
{
    NSMutableArray *copy = self.mutableCopy;
    [copy removeObject:object];
    return copy;
}

- (NSArray *)arrayByAddingObjectsFromSet:(NSSet *)set
{
    NSMutableArray *newArray = [NSMutableArray arrayWithArray:self];
    for (id object in set)
    {
        [newArray addObject:object];
    }
    return newArray;
}

- (NSArray *)shuffled
{
	NSMutableArray *tmpArray = [NSMutableArray arrayWithCapacity:[self count]];
    
	for (id anObject in self)
	{
		NSUInteger randomPos = arc4random() % ([tmpArray count] + 1);
		[tmpArray insertObject:anObject atIndex:randomPos];
	}
    
	return tmpArray;
}

- (NSArray *)reversed
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:[self count]];
    NSEnumerator *enumerator = [self reverseObjectEnumerator];
    for (id element in enumerator)
    {
        [array addObject:element];
    }
    return array;
}

- (NSArray *)sortedArrayByKey:(NSString *)key
{
    NSSortDescriptor *s = [[NSSortDescriptor alloc] initWithKey:key ascending:YES];
    return [self sortedArrayUsingDescriptors:@[s]];
}

- (BOOL)containsString:(NSString *)string
{
    if([string isKindOfClass:[NSString class]])
    {
        for(NSString *value in self)
        {
            if([value isKindOfClass:[NSString class]])
            {
                if([value isEqualToString:string])
                {
                    return YES;
                }
            }
        }
    }
    return NO;
}

- (BOOL)containsNumber:(NSNumber *)number
{
    if([number isKindOfClass:[NSNumber class]])
    {
        for(NSNumber *value in self)
        {
            if([value isKindOfClass:[NSNumber class]])
            {
                if([value isEqualToNumber:number])
                {
                    return YES;
                }
            }
        }
    }
    return NO;
}

- (NSArray *)pluck:(NSString *)key
{
	NSMutableArray *items = [NSMutableArray array];
    
	for (id item in self)
    {
		[items addObject:[item valueForKey:key]];
	}
    
	return items;
}

- (id)objectAtIndex:(NSUInteger)index defaultValue:(id)defaultValue
{
    if (index < [self count])
    {
        return [self objectAtIndex:index];
    }
    
    return defaultValue;
}

- (NSUInteger)countOfObjectsEqualTo:(id)object
{
    NSUInteger result = 0;
    for (id obj in self)
    {
        if ([obj isEqual:object])
        {
            result++;
        }
    }
    return result;
}

- (NSUInteger)countOfObjectsNotEqualTo:(id)object
{
    return [self count] - [self countOfObjectsEqualTo:object];
}

#pragma mark - LINQ

- (BOOL)any
{
    return self.count > 0;
}

- (NSArray *)where:(PredicateBlock)predicate
{
    NSMutableArray *result = [NSMutableArray array];
    for (id obj in self)
    {
        if (predicate(obj))
        {
            [result addObject:obj];
        }
    }
    
    return result;
}

- (NSArray *)select:(SelectBlock)transform
{
    NSMutableArray *result = [NSMutableArray array];
    for (id obj in self)
    {
        [result addObject:transform(obj)];
    }
    
    return result;
}

- (BOOL)any:(PredicateBlock)predicate
{
    for (id obj in self)
    {
        if (predicate(obj))
        {
            return YES;
        }
    }
    
    return NO;
}

- (void)each:(EnumerateBlock)action
{
    for (id obj in self)
    {
        action(obj);
    }
}

- (NSDictionary *)dictionaryWithKeyBlock:(SelectBlock)keyBlock
{
    return [self dictionaryWithKeyBlock:keyBlock valueBlock:^id(id element) {
        return element;
    }];
}

- (NSDictionary *)dictionaryWithKeyBlock:(SelectBlock)keyBlock valueBlock:(SelectBlock)valueBlock
{
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    for (id obj in self)
    {
        id key = keyBlock(obj);
        id value = valueBlock(obj);
        result[key] = value;
    }
    return result;
}

@end
