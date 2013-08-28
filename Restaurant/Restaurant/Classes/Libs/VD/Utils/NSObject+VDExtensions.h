//
//  NSObject+VDExtensions.h
//  VD
//
//  Created by Evgeniy Tka4enko on 01.07.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (VDExtensions)

- (NSString *)className;
+ (NSString *)className;

+ (NSArray *)propertyNames;
+ (NSArray *)propertyNamesWithSuperclassProperies;
+ (Class)propertyClass:(NSString *)propertyName;
+ (BOOL)isPropertyReadOnly:(NSString *)propertyName;
+ (BOOL)isHasProperty:(NSString *)propertyName;

+ (NSArray *)methodNames;
+ (BOOL)isHasMethod:(NSString *)methodName;
+ (void)exchangeImplementations:(NSString *)methodOneName with:(NSString *)methodTwoName;

@end
