//
//  VDSingleton.m
//  VD
//
//  Created by Evgeniy Tka4enko on 01.07.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import "VDSingleton.h"

@implementation VDSingleton

#pragma mark - Singleton

static id sharedInstance = nil;

+ (instancetype)sharedInstance
{
    @synchronized(self)
    {
        if(!sharedInstance)
        {
            sharedInstance = [[self alloc] init];
        }
    }
    return sharedInstance;
}

@end
