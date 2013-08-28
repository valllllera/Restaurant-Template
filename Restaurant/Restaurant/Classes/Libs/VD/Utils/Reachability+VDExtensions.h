//
//  Reachability+VDExtensions.h
//  VD
//
//  Created by Evgeniy Tka4enko on 01.07.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import "Reachability.h"

@interface Reachability (VDExtensions)

+ (BOOL)isWiFiReachable;
+ (BOOL)isInternetReachable;

@end
