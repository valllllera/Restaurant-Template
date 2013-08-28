//
//  UIColor+VDExtensions.m
//  VD
//
//  Created by Evgeniy Tka4enko on 01.07.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import "UIColor+VDExtensions.h"

@implementation UIColor (VDExtensions)

+ (UIColor *)colorWithRGBHex:(UInt32)hex
{
	int r = (hex >> 16) & 0xFF;
	int g = (hex >> 8) & 0xFF;
	int b = (hex) & 0xFF;
	
	return [UIColor colorWithRed:r / 255.0f
						   green:g / 255.0f
							blue:b / 255.0f
						   alpha:1.0f];
}

- (NSUInteger)RGBHex
{
    CGFloat red, green, blue, alpha;
    [self getRed:&red green:&green blue:&blue alpha:&alpha];
    NSInteger ired, igreen, iblue;
    ired = roundf(red * 255);
    igreen = roundf(green * 255);
    iblue = roundf(blue * 255);
    NSUInteger result = (ired << 16) | (igreen << 8) | iblue;
    return result;
}

@end
