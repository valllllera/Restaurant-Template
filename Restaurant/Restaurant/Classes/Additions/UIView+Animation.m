//
//  UIView+Animation.m
//  UIAnimationSamples
//
//  Created by Ray Wenderlich on 11/15/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "UIView+Animation.h"

@implementation UIView (Animation)

- (void) movingWithDuration:(float)secs option:(UIViewAnimationOptions)option
{
    [UIView animateWithDuration:secs delay:0.0 options:option
                     animations:^{
                          self.frame = CGRectMake(280,13, self.frame.size.width, self.frame.size.height);
                         self.alpha = 1;
                     }
                     completion:^(BOOL finished){
                         self.frame = CGRectMake(280,-30, self.frame.size.width, self.frame.size.height);
                         self.alpha = 0;
                     }];
}
@end
