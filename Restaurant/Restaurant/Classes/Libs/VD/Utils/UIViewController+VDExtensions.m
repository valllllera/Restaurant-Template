//
//  UIViewController+VDExtensions.m
//  VD
//
//  Created by Evgeniy Tka4enko on 02.07.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import "UIViewController+VDExtensions.h"

@implementation UIViewController (VDExtensions)

+ (id)loadFromNib
{
    NSString *nibName = NSStringFromClass(self);
    return [self loadFromNib:nibName];
}

+ (id)loadFromNib:(NSString *)nibName
{
    return [[self alloc] initWithNibName:nibName bundle:nil];
}

+ (id)loadFromStoryboard:(UIStoryboard *)storyboard
{
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass(self.class)];
}

@end
