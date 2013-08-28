//
//  VDBlockTapGestureRecognizer.m
//  VD
//
//  Created by Evgeniy Tka4enko on 02.07.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import "VDBlockTapGestureRecognizer.h"

@interface VDBlockTapGestureRecognizer ()

@property(copy, nonatomic) BasicBlock action;

@end

@implementation VDBlockTapGestureRecognizer

- (id)initWithAction:(BasicBlock)action
{
    self = [super initWithTarget:self action:@selector(tapped:)];
    if (self)
    {
        self.action = action;
        self.delegate = self;
    }
    return self;
}

- (void)tapped:(UITapGestureRecognizer *)sender
{
    
    if (self.action)
    {
        self.action();
    }
}

#pragma mark - @protocol(UIGestureRecognizerDelegate)

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return ![[touch.view class] isSubclassOfClass:[UIButton class]];
}

@end
