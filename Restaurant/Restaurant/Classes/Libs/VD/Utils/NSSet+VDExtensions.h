//
//  NSSet+VDExtensions.h
//  VD
//
//  Created by Evgeniy Tka4enko on 01.07.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSSet (VDExtensions)

@property(nonatomic, readonly) BOOL any;

- (NSArray *)sortedArrayByKey:(NSString *)key;
- (NSSet *)setByRemovingObject:(id)object;
- (NSString *)componentsJoinedByString:(NSString *)separator;
- (NSSet *)where:(PredicateBlock)predicate;
- (NSSet *)select:(SelectBlock)transform;
- (BOOL)any:(PredicateBlock)predicate;

@end
