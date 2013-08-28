//
//  NSMutableString+VDExtensions.h
//  VD
//
//  Created by Evgeniy Tka4enko on 01.07.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableString (VDExtensions)

- (void)replaceOccurrencesOfString:(NSString *)pattern withString:(NSString *)replaceStr;

@end
