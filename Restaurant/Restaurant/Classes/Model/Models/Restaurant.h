//
//  Restaurant.h
//  Restaurant
//
//  Created by Жека on 28.08.13.
//  Copyright (c) 2013 Жека. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Restaurant : NSManagedObject

@property (nonatomic, copy) NSString * address;
@property (nonatomic, strong) NSNumber * latitude;
@property (nonatomic, strong) NSNumber * longitude;
@property (nonatomic, copy) NSString * phone;
@property (nonatomic, copy) NSString * site;
@property (nonatomic, copy) NSString * descr;
@property (nonatomic, strong) NSNumber * idx;
@property (nonatomic, strong) NSArray * images;

@end
