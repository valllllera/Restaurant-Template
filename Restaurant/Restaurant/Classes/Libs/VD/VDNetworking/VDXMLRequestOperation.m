//
//  VDXMLRequestOperation.m
//  VD
//
//  Created by Evgeniy Tka4enko on 09.07.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import "VDXMLRequestOperation.h"
#import "DDXMLElement+Dictionary.h"

static dispatch_queue_t vd_xml_request_operation_processing_queue;
static dispatch_queue_t xml_request_operation_processing_queue() {
    if (vd_xml_request_operation_processing_queue == NULL) {
        vd_xml_request_operation_processing_queue = dispatch_queue_create("com.vexadev.networking.xml-request.processing", 0);
    }
    
    return vd_xml_request_operation_processing_queue;
}

@implementation VDXMLRequestOperation

+ (instancetype)XMLRequestOperationWithRequest:(NSURLRequest *)urlRequest
                                       success:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, id XML))success
                                       failure:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id XML))failure
{
    return [[self alloc] initWithRequest:urlRequest success:success failure:failure];
}

- (instancetype)initWithRequest:(NSURLRequest *)urlRequest
                        success:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, id XML))success
                        failure:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id XML))failure
{
    self = [super initWithRequest:urlRequest];
    if(self)
    {
        [self setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            if (success) {
                dispatch_async(xml_request_operation_processing_queue(), ^{
                    id XML = [[responseObject rootElement] convertDictionary];
                    dispatch_async(dispatch_get_main_queue(), ^{
                       success(operation.request, operation.response, XML); 
                    });
                });
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            if (failure) {
                failure(operation.request, operation.response, operation.error, [[[(AFKissXMLRequestOperation *)operation responseXMLDocument] rootElement] convertDictionary]);
            }
        }];
    }
    return self;
}

@end
