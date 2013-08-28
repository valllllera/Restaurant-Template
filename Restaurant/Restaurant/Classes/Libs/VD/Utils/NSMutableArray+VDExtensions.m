//
//  NSMutableArray+VDExtensions.m
//  VD
//
//  Created by Evgeniy Tka4enko on 01.07.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import "NSMutableArray+VDExtensions.h"

@implementation NSMutableArray (VDExtensions)

- (id)popObject
{
    if (self.count == 0)
        return nil;
    
    NSInteger lastIndex = self.count - 1;
    id result = self[lastIndex];
    [self removeObjectAtIndex:lastIndex];
    return result;
}

- (id)popFirstObject
{
    if (self.count == 0)
        return nil;
    
    id result = self[0];
    [self removeObjectAtIndex:0];
    return result;
}

- (id)popRandomObject
{
    NSInteger index = arc4random() % self.count;
    id element = self[index];
    [self removeObjectAtIndex:index];
    return element;
}

- (void)moveObjectFromIndex:(NSUInteger)from toIndex:(NSUInteger)to
{
    if (to == from)
        return;
    
    id objectToMove = [self objectAtIndex:from];
    [self removeObjectAtIndex:from];
    if (to >= [self count])
    {
        [self addObject:objectToMove];
    }
    else
    {
        [self insertObject:objectToMove atIndex:to];
    }
}

@end
