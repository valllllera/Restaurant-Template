//
//  Annotation.m
//  Restaurant
//
//  Created by Evgeniy Tka4enko on 30.07.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import "Annotation.h"

@implementation Annotation

#pragma mark - Initialization

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate
               withTitle:(NSString *)title
{
    self = [super init];
    if(self)
    {
        _coordinate = coordinate;
        _title = title;
    }
    return self;
}

@end
