//
//  PriceItem.h
//  Restaurant
//
//  Created by Жека on 28.08.13.
//  Copyright (c) 2013 Жека. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Product;

@interface PriceItem : NSManagedObject

@property (nonatomic, strong) NSNumber * price;
@property (nonatomic, copy) NSString * title;
@property (nonatomic, strong) NSNumber * ord;
@property (nonatomic, strong) Product *product;

@end
