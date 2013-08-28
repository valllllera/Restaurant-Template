//
//  NSDictionary+VDExtensions.m
//  VD
//
//  Created by Evgeniy Tka4enko on 03.07.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import "NSDictionary+VDExtensions.h"

@implementation NSDictionary (VDExtensions)

- (id)objectForKey:(id)aKey defaultValue:(id)defaultValue
{
	id value = [self objectForKey:aKey];
    
	if ( (value == nil) || (value == [NSNull null]) )
    {
		return defaultValue;
	}
    
	return value;
}

@end
