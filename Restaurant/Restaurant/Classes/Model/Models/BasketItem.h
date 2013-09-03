//
//  BasketItem.h
//  Restaurant
//
//  Created by Evgeniy Tka4enko on 03.09.13.
//  Copyright (c) 2013 Жека. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class PriceItem, Product;

@interface BasketItem : NSManagedObject

@property (nonatomic, strong) NSNumber * count;
@property (nonatomic, strong) NSDate * created;
@property (nonatomic, strong) Product *product;
@property (nonatomic, strong) PriceItem *priceItem;

@end
