//
//  NSDate+VDExtensions.h
//  VD
//
//  Created by Evgeniy Tka4enko on 03.07.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (VDExtensions)

- (NSString *)stringWithFormat:(NSString *)format;

- (NSDate *)dateWithoutTime;
- (NSDate *)dateWithoutSeconds;
- (NSDate *)dateWithoutMinutesAndSeconds;

- (NSDate *)dateByAddingSeconds:(NSInteger)seconds;
- (NSDate *)dateByAddingMinutes:(NSInteger)minutes;
- (NSDate *)dateByAddingHours:(NSInteger)hours;
- (NSDate *)dateByAddingDays:(NSInteger)days;
- (NSDate *)dateByAddingMonths:(NSInteger)months;
- (NSDate *)dateByAddingYears:(NSInteger)years;

- (NSUInteger)second;
- (NSUInteger)minute;
- (NSUInteger)hour;
- (NSUInteger)day;
- (NSUInteger)month;
- (NSUInteger)year;

@end
