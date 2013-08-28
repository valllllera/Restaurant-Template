//
//  NSDate+VDExtensions.m
//  VD
//
//  Created by Evgeniy Tka4enko on 03.07.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import "NSDate+VDExtensions.h"

@implementation NSDate (VDExtensions)

- (NSString *)stringWithFormat:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    NSString *s = [formatter stringFromDate:self];
    return s;
}

- (NSDate *)dateWithoutTime
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:self];
    return [[NSCalendar currentCalendar] dateFromComponents:components];
}

- (NSDate *)dateWithoutSeconds
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit fromDate:self];
    return [[NSCalendar currentCalendar] dateFromComponents:components];
}

- (NSDate *)dateWithoutMinutesAndSeconds
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit fromDate:self];
    return [[NSCalendar currentCalendar] dateFromComponents:components];
}

- (NSDate *)dateByAddingSeconds:(NSInteger)seconds
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setSecond:seconds];
    
    NSDate *returnDate = [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:0];
    
    return returnDate;
}

- (NSDate *)dateByAddingMinutes:(NSInteger)minutes
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setMinute:minutes];
    
    NSDate *returnDate = [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:0];
    
    return returnDate;
}

- (NSDate *)dateByAddingHours:(NSInteger)hours
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setHour:hours];
    
    NSDate *returnDate = [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:0];
    
    return returnDate;
}

- (NSDate *)dateByAddingDays:(NSInteger)days
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:days];
    
    NSDate *returnDate = [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:0];
    
    return returnDate;
}

- (NSDate *)dateByAddingMonths:(NSInteger)months
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setMonth:months];
    
    NSDate *returnDate = [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:0];
    
    return returnDate;
}

- (NSDate *)dateByAddingYears:(NSInteger)years
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setYear:years];
    
    NSDate *returnDate = [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:0];
    
    return returnDate;
}

- (NSUInteger)second
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSSecondCalendarUnit fromDate:self];
    
    NSUInteger second = components.second;
    
    return second;
}

- (NSUInteger)minute
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSMinuteCalendarUnit fromDate:self];
    
    NSUInteger minute = components.minute;
    
    return minute;
}

- (NSUInteger)hour
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSHourCalendarUnit fromDate:self];
    
    NSUInteger hour = components.hour;
    
    return hour;
}

- (NSUInteger)day
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit fromDate:self];
    
    NSUInteger day = components.day;
    
    return day;
}

- (NSUInteger)month
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSMonthCalendarUnit fromDate:self];
    
    NSUInteger month = components.month;
    
    return month;
}

- (NSUInteger)year
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSYearCalendarUnit fromDate:self];
    
    NSUInteger year = components.year;
    
    return year;
}

@end
