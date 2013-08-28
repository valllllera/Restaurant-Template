//
//  UIImage+VDExtensions.m
//  VD
//
//  Created by Evgeniy Tka4enko on 01.07.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import "UIImage+VDExtensions.h"

@implementation UIImage (VDExtensions)

- (UIImage *)thumbnailWithSize:(CGSize)size
{
    CGFloat scale = self.scale;
    UIGraphicsBeginImageContextWithOptions(size, NO, scale);
    [[UIColor clearColor] set];
    UIRectFill(CGRectMake(0, 0, size.width, size.height));
    CGSize originalSize = self.size;
    CGFloat scaleFactor = MIN(size.width / originalSize.width, size.height / originalSize.height);
    CGSize targetSize = { originalSize.width * scaleFactor, originalSize.height * scaleFactor };
    CGFloat x = ((int)((size.width - targetSize.width) / 2 * scale)) / scale;
    CGFloat y = ((int)((size.height - targetSize.height) / 2 * scale)) / scale;
    [self drawInRect:CGRectMake(x, y, targetSize.width, targetSize.height)];
    UIImage *thumbnail = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return thumbnail;
}

@end
