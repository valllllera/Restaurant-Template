//
//  NSDate+Extensions.m
//  Restaurant
//
//  Created by Evgeniy Tka4enko on 06.08.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import "NSDate+Extensions.h"

@implementation NSDate (Extensions)

- (NSString *)dateWithMonthString
{
    return [NSString stringWithFormat:@"%d %@ %d", [self day], [self monthForNumber:[self month]], [self year]];
}

- (NSString *)monthForNumber:(NSUInteger)month
{
    NSString *monthString;
    
    switch (month) {
        case 1:
            monthString = @"января";
            break;
        case 2:
            monthString = @"февраля";
            break;
        case 3:
            monthString = @"марта";
            break;
        case 4:
            monthString = @"апреля";
            break;
        case 5:
            monthString = @"мая";
            break;
        case 6:
            monthString = @"июня";
            break;
        case 7:
            monthString = @"июля";
            break;
        case 8:
            monthString = @"августа";
            break;
        case 9:
            monthString = @"сентября";
            break;
        case 10:
            monthString = @"октября";
            break;
        case 11:
            monthString = @"ноября";
            break;
        case 12:
            monthString = @"декабря";
            break;
      
            default:
            break;
    }
    
    return monthString;
}

@end
