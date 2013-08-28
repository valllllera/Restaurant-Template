//
//  NSData+VDExtensions.h
//  VD
//
//  Created by Evgeniy Tka4enko on 03.07.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (VDExtensions)

- (NSString *)MD5Hash;
- (NSString *)SHA1Hash;
- (NSString *)HMACUsingSHA1_withSecretKey:(NSData *)secretKey;

+ (id)dataWithBase64String:(NSString *)base64String;
- (NSString *)base64String;

+ (id)dataWithBase32String:(NSString *)base32String;
- (NSString *)base32String;

+ (id)dataWithBase16String:(NSString *)base16String;
- (NSString *)base16String;

@end
