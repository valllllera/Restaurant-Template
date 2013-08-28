//
//  NSSet+VDExtensions.m
//  VD
//
//  Created by Evgeniy Tka4enko on 01.07.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import "NSSet+VDExtensions.h"

@implementation NSSet (VDExtensions)

#pragma mark - LINQ

- (BOOL)any
{
    return self.count > 0;
}

- (NSArray *)sortedArrayByKey:(NSString *)key
{
    NSSortDescriptor *s = [[NSSortDescriptor alloc] initWithKey:key ascending:YES];
    return [self sortedArrayUsingDescriptors:@[s]];
}

- (NSSet *)setByRemovingObject:(id)object
{
    NSMutableSet *copy = self.mutableCopy;
    [copy removeObject:object];
    return copy;
}

- (NSString *)componentsJoinedByString:(NSString *)separator
{
    return [[self allObjects] componentsJoinedByString:separator];
}

- (NSSet *)where:(PredicateBlock)predicate
{
    NSMutableSet *result = [NSMutableSet set];
    for (id obj in self)
    {
        if (predicate(obj))
            [result addObject:obj];
    }
    
    return result;
}

- (NSSet *)select:(SelectBlock)transform
{
    NSMutableSet *result = [NSMutableArray array];
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
            return YES;
    }
    
    return NO;
}

@end
