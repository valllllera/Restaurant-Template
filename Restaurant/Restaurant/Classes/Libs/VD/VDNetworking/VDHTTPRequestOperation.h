//
//  VDHTTPRequestOperation.h
//  VD
//
//  Created by Evgeniy Tka4enko on 09.07.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import "AFHTTPRequestOperation.h"

@interface VDHTTPRequestOperation : AFHTTPRequestOperation

+ (instancetype)HTTPRequestOperationWithRequest:(NSURLRequest *)urlRequest
                                        success:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, id responseObject))success
                                        failure:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id responseObject))failure;

- (instancetype)initWithRequest:(NSURLRequest *)urlRequest
                        success:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, id responseObject))success
                        failure:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id responseObject))failure;

@end
