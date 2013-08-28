//
//  BasketItem.h
//  Restaurant
//
//  Created by Жека on 28.08.13.
//  Copyright (c) 2013 Жека. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Product;

@interface BasketItem : NSManagedObject

@property (nonatomic, strong) NSNumber * count;
@property (nonatomic, strong) NSDate * created;
@property (nonatomic, strong) NSNumber * priceType;
@property (nonatomic, strong) Product *product;

@end
