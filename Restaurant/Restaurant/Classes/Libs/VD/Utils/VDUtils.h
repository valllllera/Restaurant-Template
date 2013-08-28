//
//  VDUtils.h
//  VD
//
//  Created by Evgeniy Tka4enko on 01.07.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

typedef void(^BasicBlock)(void);
typedef void(^StringBlock)(NSString *str);
typedef void(^NumberBlock)(NSNumber *num);
typedef void(^ArrayBlock)(NSArray *arr);
typedef void(^DictionaryBlock)(NSDictionary *dict);
typedef void(^SetBlock)(NSSet *set);
typedef void(^ErrorBlock)(NSError *error);

#import "NSString+VDExtensions.h"
#import "NSURLResponse+VDExtensions.h"
#import "NSObject+VDExtensions.h"
#import "NSArray+VDExtensions.h"
#import "NSMutableArray+VDExtensions.h"
#import "NSMutableString+VDExtensions.h"
#import "NSMutableArray+VDExtensions.h"
#import "NSSet+VDExtensions.h"
#import "Reachability+VDExtensions.h"
#import "UIImage+VDExtensions.h"
#import "UIColor+VDExtensions.h"
#import "UIView+VDExtensions.h"
#import "NSManagedObject+VDExtensions.h"
#import "NSDictionary+VDExtensions.h"
#import "NSDate+VDExtensions.h"
#import "NSNumber+VDExtensions.h"
#import "NSData+VDExtensions.h"

#import "VDBlockTapGestureRecognizer.h"