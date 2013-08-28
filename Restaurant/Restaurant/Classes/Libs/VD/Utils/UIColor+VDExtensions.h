//
//  UIColor+VDExtensions.h
//  VD
//
//  Created by Evgeniy Tka4enko on 01.07.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (VDExtensions)

+ (UIColor *)colorWithRGBHex:(UInt32)hex;
- (NSUInteger)RGBHex;

@end
