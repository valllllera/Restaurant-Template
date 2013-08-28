//
//  VDUIImageToDataTransformer.m
//  VD
//
//  Created by Evgeniy Tka4enko on 03.07.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import "VDUIImageToDataTransformer.h"

@implementation VDUIImageToDataTransformer

+ (BOOL)allowsReverseTransformation
{
	return YES;
}

+ (Class)transformedValueClass
{
	return [NSData class];
}

- (id)transformedValue:(id)value
{
    return UIImagePNGRepresentation(value);
}

- (id)reverseTransformedValue:(id)value
{
	return [UIImage imageWithData:value];
}

@end
