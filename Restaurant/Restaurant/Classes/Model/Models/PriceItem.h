//
//  PriceItem.h
//  Restaurant
//
//  Created by Evgeniy Tka4enko on 03.09.13.
//  Copyright (c) 2013 Жека. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class BasketItem, Product;

@interface PriceItem : NSManagedObject

@property (nonatomic, strong) NSNumber * ord;
@property (nonatomic, strong) NSNumber * price;
@property (nonatomic, copy) NSString * title;
@property (nonatomic, strong) Product *product;
@property (nonatomic, strong) NSSet *basketItems;

@end