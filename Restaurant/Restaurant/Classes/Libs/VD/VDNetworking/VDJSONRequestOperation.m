//
//  VDJSONRequestOperation.m
//  VD
//
//  Created by Evgeniy Tka4enko on 09.07.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import "VDJSONRequestOperation.h"

@implementation VDJSONRequestOperation

+ (instancetype)JSONRequestOperationWithRequest:(NSURLRequest *)urlRequest
                                        success:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, id JSON))success
                                        failure:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON))failure
{
    return [[self alloc] initWithRequest:urlRequest success:success failure:failure];
}

- (instancetype)initWithRequest:(NSURLRequest *)urlRequest
                        success:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, id JSON))success
                        failure:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON))failure
{
    self = [super initWithRequest:urlRequest];
    if(self)
    {
        [self setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            if (success) {
                success(operation.request, operation.response, responseObject);
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            if (failure) {
                failure(operation.request, operation.response, error, [(AFJSONRequestOperation *)operation responseJSON]);
            }
        }];
    }
    return self;
}

@end
