//
//  VDUIColorToDataTransformer.m
//  VD
//
//  Created by Evgeniy Tka4enko on 03.07.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import "VDUIColorToDataTransformer.h"

@implementation VDUIColorToDataTransformer

+ (BOOL)allowsReverseTransformation
{
	return YES;
}

+ (Class)transformedValueClass
{
	return [NSData class];
}

- (id)transformedValue:(id)value
{
    UIColor *color = value;
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    NSString *colorAsString = [NSString stringWithFormat:@"%f,%f,%f,%f", components[0], components[1], components[2], components[3]];
    return [colorAsString dataUsingEncoding:NSUTF8StringEncoding];
}

- (id)reverseTransformedValue:(id)value
{
	NSString *colorAsString = [[NSString alloc] initWithData:value encoding:NSUTF8StringEncoding];
    NSArray *components = [colorAsString componentsSeparatedByString:@","];
    CGFloat r = [[components objectAtIndex:0] floatValue];
    CGFloat g = [[components objectAtIndex:1] floatValue];
    CGFloat b = [[components objectAtIndex:2] floatValue];
    CGFloat a = [[components objectAtIndex:3] floatValue];
    return [UIColor colorWithRed:r green:g blue:b alpha:a];
}

@end
