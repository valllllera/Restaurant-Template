//
//  VDHTTPRequestOperation.m
//  VD
//
//  Created by Evgeniy Tka4enko on 09.07.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import "VDHTTPRequestOperation.h"

@implementation VDHTTPRequestOperation

+ (instancetype)HTTPRequestOperationWithRequest:(NSURLRequest *)urlRequest
                                        success:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, id responseObject))success
                                        failure:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id responseObject))failure
{
    return [[self alloc] initWithRequest:urlRequest success:success failure:failure];
}

- (instancetype)initWithRequest:(NSURLRequest *)urlRequest
                        success:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, id responseObject))success
                        failure:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id responseObject))failure
{
    self = [super initWithRequest:urlRequest];
    if(self)
    {
        [self setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            if(success)
            {
                success(operation.request, operation.response, responseObject);
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            if(failure)
            {
                failure(operation.request, operation.response, error, operation.responseData);
            }
            
        }];
    }
    return self;
}

@end
