//
//  UIView+VDExtensions.m
//  VD
//
//  Created by Evgeniy Tka4enko on 02.07.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import "UIView+VDExtensions.h"
#import <objc/runtime.h>
#import <QuartzCore/QuartzCore.h>
#import "VDUtils.h"

static CGFloat const kAnimationDuration = 0.4f;
static NSInteger const kLoaderTag = 27;

@implementation UIView (VDExtensions)

#pragma mark - Xib

+ (id)loadFromNib
{
    return [self loadFromNibWithOwner:nil];
}

+ (id)loadFromNib:(NSString *)nibName
{
    return [self loadFromNib:nibName withOwner:nil];
}

+ (id)loadFromNibWithOwner:(id)owner
{
    return [self loadFromNib:NSStringFromClass(self) withOwner:owner];
}

+ (id)loadFromNib:(NSString *)nibName withOwner:(id)owner
{
    return [[NSBundle mainBundle] loadNibNamed:nibName
                                         owner:owner
                                       options:nil][0];
}

#pragma mark - Coordinates

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setY:(CGFloat)y
{
    CGRect newFrame = self.frame;
    newFrame.origin.y = y;
    self.frame = newFrame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setX:(CGFloat)x
{
    CGRect newFrame = self.frame;
    newFrame.origin.x = x;
    self.frame = newFrame;
}

- (CGFloat)width
{
    return self.size.width;
}

- (void)setWidth:(CGFloat)width
{
    CGRect newFrame = self.frame;
    newFrame.size.width = width;
    self.frame = newFrame;
}

- (CGFloat)height
{
    return self.size.height;
}

- (void)setHeight:(CGFloat)height
{
    CGRect newFrame = self.frame;
    newFrame.size.height = height;
    self.frame = newFrame;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect newFrame = self.frame;
    newFrame.origin = origin;
    self.frame = newFrame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setSize:(CGSize)size
{
    CGRect newFrame = self.frame;
    newFrame.size = size;
    self.frame = newFrame;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX
{
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY
{
    self.center = CGPointMake(self.center.x, centerY);
}

#pragma mark - Other Helpers

- (void)removeAllSubviews
{
    for (UIView *view in self.subviews)
    {
        [view removeFromSuperview];
    }
}

- (void)addTapAction:(BasicBlock)action
{
    self.userInteractionEnabled = YES;
    VDBlockTapGestureRecognizer *b = [[VDBlockTapGestureRecognizer alloc] initWithAction:action];
    [self addGestureRecognizer:b];
}

- (void)hide:(BOOL)animated
{
    [self hide:animated completion:nil];
}

- (void)show:(BOOL)animated
{
    [self show:animated completion:nil];
}

- (void)hide:(BOOL)animated completion:(void(^)())completionBlock
{
    if(self.hidden)
    {
        if(completionBlock)
        {
            completionBlock();
        }
        
        return;
    }
    if(animated)
    {
        [UIView animateWithDuration:kAnimationDuration delay:0.0f options:UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionAllowUserInteraction animations:^{
            self.alpha = 0.0f;
        } completion:^(BOOL finished) {
            if(finished)
            {
                self.hidden = YES;
                self.alpha = 1.0f;
                
                if(completionBlock)
                {
                    completionBlock();
                }
            }
        }];
    }
    else
    {
        self.hidden = YES;
        
        if(completionBlock)
        {
            completionBlock();
        }
    }
}

- (void)show:(BOOL)animated completion:(void(^)())completionBlock
{
    if(animated)
    {
        if(self.hidden)
        {
            self.alpha = 0.0f;
            self.hidden = NO;
        }
        
        [UIView animateWithDuration:kAnimationDuration delay:0.0f options:UIViewAnimationOptionAllowUserInteraction animations:^{
            self.alpha = 1.0f;
        } completion:^(BOOL finished) {
            
            if(completionBlock && finished)
            {
                completionBlock();
            }
            
        }];
    }
    else
    {
        if(self.hidden)
        {
            self.hidden = NO;
        }
        self.alpha = 1.0f;
        
        if(completionBlock)
        {
            completionBlock();
        }
    }
}

- (void)showLoader:(BOOL)animated
{
    [self showLoader:animated withStyle:UIActivityIndicatorViewStyleWhite];
}

- (void)hideLoader:(BOOL)animated
{
    UIView *view = [self loader];
    
    [view hide:animated];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, kAnimationDuration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [view removeFromSuperview];
    });
    
    [self show:animated];
}

- (void)showGrayLoader:(BOOL)animated
{
    [self showLoader:animated withStyle:UIActivityIndicatorViewStyleGray];
}

- (void)hideGrayLoader:(BOOL)animated
{
    [self hideLoader:animated];
}

- (void)showLargeLoader:(BOOL)animated
{
    [self showLoader:animated withStyle:UIActivityIndicatorViewStyleWhiteLarge];
}

- (void)hideLargeLoader:(BOOL)animated
{
    [self hideLoader:animated];
}

- (void)showLoader:(BOOL)animated withStyle:(UIActivityIndicatorViewStyle)style
{
    if(![self loader])
    {
        [self hide:animated];
        
        UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:style];
        [activityView startAnimating];
        activityView.frame = CGRectMake(self.frame.origin.x + (self.frame.size.width - 40) / 2, self.frame.origin.y + (self.frame.size.height - 40) / 2, 40, 40);
        activityView.tag = [self tagForLoader];
        activityView.hidden = YES;
        [self.superview addSubview:activityView];
        
        [activityView show:animated];
    }
}

- (UIActivityIndicatorView *)loader
{
    UIActivityIndicatorView *view = (UIActivityIndicatorView *)[self.superview viewWithTag:[self tagForLoader]];
    if([view isKindOfClass:[UIActivityIndicatorView class]])
    {
        return view;
    }
    return nil;
}

- (NSInteger)tagForLoader
{
    static NSInteger tag = -1;
    
    if(tag == -1)
    {
        tag = (kLoaderTag | (int)self) % INT_MAX;
    }
    
    return tag;
}

#pragma mark - Animations

- (void)pulse
{
    
    self.transform = CGAffineTransformMakeScale(0.6, 0.6);
    
	[UIView animateWithDuration: 0.2
					 animations: ^{
						 self.transform = CGAffineTransformMakeScale(1.1, 1.1);
					 }
					 completion: ^(BOOL __finished){
						 [UIView animateWithDuration:1.0/15.0
										  animations: ^{
											  self.transform = CGAffineTransformMakeScale(0.9, 0.9);
										  }
										  completion: ^(BOOL _finished){
											  [UIView animateWithDuration:1.0/7.5
															   animations: ^{
																   self.transform = CGAffineTransformIdentity;
															   }];
										  }];
					 }];
}

- (void)shake
{
    
    CGFloat t = 2.0;
    CGAffineTransform translateRight  = CGAffineTransformTranslate(CGAffineTransformIdentity, t, 0.0);
    CGAffineTransform translateLeft = CGAffineTransformTranslate(CGAffineTransformIdentity, -t, 0.0);
    
    self.transform = translateLeft;
    
    [UIView animateWithDuration:0.07 delay:0.0 options:UIViewAnimationOptionAutoreverse|UIViewAnimationOptionRepeat animations:^{
        [UIView setAnimationRepeatCount:2.0];
        self.transform = translateRight;
    } completion:^(BOOL finished) {
        if (finished) {
            [UIView animateWithDuration:0.05 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                self.transform = CGAffineTransformIdentity;
            } completion:nil];
        }
    }];
}

@end
