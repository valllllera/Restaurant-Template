//
//  NSNumber+VDExtensions.m
//  VD
//
//  Created by Evgeniy Tka4enko on 03.07.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import "NSNumber+VDExtensions.h"

@implementation NSNumber (VDExtensions)

+ (NSNumber *)numberWithString:(NSString *)string
{
    if([string isKindOfClass:[NSNumber class]])
    {
        return (NSNumber *)string;
    }
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    return  [formatter numberFromString:string];
}

@end
