//
//  UIView+VDExtensions.h
//  VD
//
//  Created by Evgeniy Tka4enko on 02.07.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (VDExtensions)

@property(nonatomic) CGFloat x;
@property(nonatomic) CGFloat y;

@property(nonatomic) CGFloat centerX;
@property(nonatomic) CGFloat centerY;

@property(nonatomic) CGFloat width;
@property(nonatomic) CGFloat height;

@property(nonatomic) CGPoint origin;
@property(nonatomic) CGSize size;

+ (id)loadFromNib;
+ (id)loadFromNib:(NSString *)nibName;
+ (id)loadFromNibWithOwner:(id)owner;
+ (id)loadFromNib:(NSString *)nibName withOwner:(id)owner;

- (void)hide:(BOOL)animated;
- (void)show:(BOOL)animated;

- (void)hide:(BOOL)animated completion:(void(^)())completionBlock;
- (void)show:(BOOL)animated completion:(void(^)())completionBlock;

- (void)showLoader:(BOOL)animated;
- (void)hideLoader:(BOOL)animated;

- (void)showGrayLoader:(BOOL)animated;
- (void)hideGrayLoader:(BOOL)animated;

- (void)showLargeLoader:(BOOL)animated;
- (void)hideLargeLoader:(BOOL)animated;

- (void)pulse;
- (void)shake;

@end
