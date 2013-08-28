//
//  NSURLResponse+VDExtensions.m
//  VD
//
//  Created by Evgeniy Tka4enko on 01.07.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import "NSURLResponse+VDExtensions.h"

@implementation NSURLResponse (VDExtensions)

- (NSStringEncoding)encoding {
	NSStringEncoding encoding = NSUTF8StringEncoding;
    
	if ([self textEncodingName]) {
		CFStringEncoding cfStringEncoding = CFStringConvertIANACharSetNameToEncoding((CFStringRef)[self textEncodingName]);
		if (cfStringEncoding != kCFStringEncodingInvalidId) {
			encoding = CFStringConvertEncodingToNSStringEncoding(cfStringEncoding);
		}
	}
    
	return encoding;
}

@end
