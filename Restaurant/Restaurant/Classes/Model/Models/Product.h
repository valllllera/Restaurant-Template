//
//  Product.h
//  Restaurant
//
//  Created by Evgeniy Tka4enko on 03.09.13.
//  Copyright (c) 2013 Жека. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class BasketItem, Category, PriceItem;

@interface Product : NSManagedObject

@property (nonatomic, copy) NSString * descr;
@property (nonatomic, strong) NSNumber * idx;
@property (nonatomic, copy) NSString * imageUrl;
@property (nonatomic, strong) NSNumber * ord;
@property (nonatomic, copy) NSString * title;
@property (nonatomic, strong) NSSet *basketItems;
@property (nonatomic, strong) Category *category;
@property (nonatomic, strong) NSSet *priceItems;

@end
