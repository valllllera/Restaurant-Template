//
//  Annotation.h
//  Restaurant
//
//  Created by Evgeniy Tka4enko on 30.07.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface Annotation : NSObject <MKAnnotation>

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy, readonly) NSString *title;

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate
               withTitle:(NSString *)title;

@end
