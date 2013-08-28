//
//  AppSettings.m
//  Restaurant
//
//  Created by Evgeniy Tka4enko on 31.07.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import "AppSettings.h"

@implementation AppSettings

static AppSettings *sharedInstance = nil;

+ (AppSettings *)sharedInstance
{
    @synchronized(self)
    {
        if(!sharedInstance)
        {
            sharedInstance = [[AppSettings alloc] init];
        }
    }
    return sharedInstance;
}

@end
