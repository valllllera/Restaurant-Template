//
//  NSMutableArray+VDExtensions.h
//  VD
//
//  Created by Evgeniy Tka4enko on 01.07.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (VDExtensions)

- (id)popFirstObject;
- (id)popObject;
- (id)popRandomObject;

- (void)moveObjectFromIndex:(NSUInteger)from toIndex:(NSUInteger)to;

@end
