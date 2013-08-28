//
//  Product.h
//  Restaurant
//
//  Created by Жека on 28.08.13.
//  Copyright (c) 2013 Жека. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class BasketItem, Category, PriceItem;

@interface Product : NSManagedObject

@property (nonatomic, strong) NSNumber * idx;
@property (nonatomic, copy) NSString * imageUrl;
@property (nonatomic, copy) NSString * descr;
@property (nonatomic, strong) NSNumber * ord;
@property (nonatomic, copy) NSString * title;
@property (nonatomic, strong) NSSet *announces;
@property (nonatomic, strong) NSSet *basketItems;
@property (nonatomic, strong) Category *category;
@property (nonatomic, strong) NSSet *priceItems;
@end

@interface Product (CoreDataGeneratedAccessors)

- (void)addAnnouncesObject:(NSManagedObject *)value;
- (void)removeAnnouncesObject:(NSManagedObject *)value;
- (void)addAnnounces:(NSSet *)values;
- (void)removeAnnounces:(NSSet *)values;

- (void)addBasketItemsObject:(BasketItem *)value;
- (void)removeBasketItemsObject:(BasketItem *)value;
- (void)addBasketItems:(NSSet *)values;
- (void)removeBasketItems:(NSSet *)values;

- (void)addPriceItemsObject:(PriceItem *)value;
- (void)removePriceItemsObject:(PriceItem *)value;
- (void)addPriceItems:(NSSet *)values;
- (void)removePriceItems:(NSSet *)values;

@end
