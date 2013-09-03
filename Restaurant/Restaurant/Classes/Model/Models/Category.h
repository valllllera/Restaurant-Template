//
//  Category.h
//  Restaurant
//
//  Created by Жека on 28.08.13.
//  Copyright (c) 2013 Жека. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Product;

@interface Category : NSManagedObject

@property (nonatomic, strong) NSNumber * idx;
@property (nonatomic, copy) NSString * imageUrl;
@property (nonatomic, strong) NSNumber * ord;
@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * descr;
@property (nonatomic, strong) NSSet *products;

@end
