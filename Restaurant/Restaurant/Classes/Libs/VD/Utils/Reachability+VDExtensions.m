//
//  Reachability+VDExtensions.m
//  VD
//
//  Created by Evgeniy Tka4enko on 01.07.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import "Reachability+VDExtensions.h"

static Reachability *__wifiShared;
static Reachability *__internetShared;

@implementation Reachability (VDExtensions)

+ (Reachability *)wifiShared
{
    if (!__wifiShared)
    {
        @synchronized(self)
        {
            if (!__wifiShared)
            {
                __wifiShared = [Reachability reachabilityForLocalWiFi];
            }
        }
    }
    
    return __wifiShared;
}

+ (Reachability *)internetShared
{
    if (!__internetShared)
    {
        @synchronized(self)
        {
            if (!__internetShared)
            {
                __internetShared = [Reachability reachabilityForInternetConnection];
            }
        }
    }
    
    return __internetShared;
}

+ (BOOL)isWiFiReachable
{
    return [[self wifiShared] isReachable];
}

+ (BOOL)isInternetReachable
{
    return [[self internetShared] isReachable];
}

@end
