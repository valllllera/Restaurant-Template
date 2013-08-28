//
//  NSArray+VDExtensions.h
//  VD
//
//  Created by Evgeniy Tka4enko on 01.07.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef BOOL(^PredicateBlock)(id element);
typedef id(^SelectBlock)(id element);
typedef void(^EnumerateBlock)(id element);

@interface NSArray (VDExtensions)

@property(nonatomic, readonly, unsafe_unretained) id firstObject;
@property(nonatomic, readonly, unsafe_unretained) id randomObject;

- (NSArray *)sortedArrayByKey:(NSString *)key;
- (NSArray *)arrayByRemovingObject:(id)object;
- (NSArray *)shuffled;
- (NSArray *)reversed;
- (BOOL)containsString:(NSString *)string;
- (BOOL)containsNumber:(NSNumber *)number;
- (NSArray *)pluck:(NSString *)key;
- (id)objectAtIndex:(NSUInteger)index defaultValue:(id)defaultValue;
- (NSUInteger)countOfObjectsEqualTo:(id)object;
- (NSUInteger)countOfObjectsNotEqualTo:(id)object;

@property(nonatomic, readonly) BOOL any;

- (NSArray *)where:(PredicateBlock)predicate;
- (NSArray *)select:(SelectBlock)transform;
- (BOOL)any:(PredicateBlock)predicate;
- (void)each:(EnumerateBlock)action;

- (NSDictionary *)dictionaryWithKeyBlock:(SelectBlock)keyBlock;
- (NSDictionary *)dictionaryWithKeyBlock:(SelectBlock)keyBlock valueBlock:(SelectBlock)valueBlock;

@end
