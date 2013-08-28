//
//  VDBlockTapGestureRecognizer.h
//  VD
//
//  Created by Evgeniy Tka4enko on 02.07.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VDBlockTapGestureRecognizer : UITapGestureRecognizer <UIGestureRecognizerDelegate>

- (id)initWithAction:(BasicBlock)action;

@end
