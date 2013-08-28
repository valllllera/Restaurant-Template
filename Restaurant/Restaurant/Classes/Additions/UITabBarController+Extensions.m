//
//  UITabBarController+Extensions.m
//  Restaurant
//
//  Created by Evgeniy Tka4enko on 01.08.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import "UITabBarController+Extensions.h"

@implementation UITabBarController (Extensions)

- (UIView *)contentView
{
    NSArray *subviews = self.view.subviews;
    if([[subviews objectAtIndex:0] isKindOfClass:[UITabBar class]])
    {
        return [subviews objectAtIndex:1];
    }
    else
    {
        return [subviews objectAtIndex:0];
    }
}

@end
