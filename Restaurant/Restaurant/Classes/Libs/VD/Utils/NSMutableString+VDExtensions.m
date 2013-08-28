//
//  NSMutableString+VDExtensions.m
//  VD
//
//  Created by Evgeniy Tka4enko on 01.07.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import "NSMutableString+VDExtensions.h"

@implementation NSMutableString (VDExtensions)

- (void)replaceOccurrencesOfString:(NSString *)pattern withString:(NSString *)replaceStr
{
    [self replaceOccurrencesOfString:pattern withString:replaceStr options:0 range:NSMakeRange(0, self.length)];
}

@end
