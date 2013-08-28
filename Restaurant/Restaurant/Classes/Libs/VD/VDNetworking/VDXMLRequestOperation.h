//
//  VDXMLRequestOperation.h
//  VD
//
//  Created by Evgeniy Tka4enko on 09.07.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import "AFKissXMLRequestOperation.h"

@interface VDXMLRequestOperation : AFKissXMLRequestOperation

+ (instancetype)XMLRequestOperationWithRequest:(NSURLRequest *)urlRequest
                                       success:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, id XML))success
                                       failure:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id XML))failure;

- (instancetype)initWithRequest:(NSURLRequest *)urlRequest
                        success:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, id XML))success
                        failure:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id XML))failure;

@end
