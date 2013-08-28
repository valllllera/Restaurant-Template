//
//  NSString+VDExtensions.m
//  VD
//
//  Created by Evgeniy Tka4enko on 01.07.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import "NSString+VDExtensions.h"
#import <CommonCrypto/CommonCrypto.h>
#import <CommonCrypto/CommonHMAC.h>

static NSDictionary *__translitDictionary;

@implementation NSString (VDExtensions)

- (BOOL)containsString:(NSString *)string
{
    return [self rangeOfString:string].location != NSNotFound;
}

- (BOOL)startsWith:(NSString *)string
{
    return [self rangeOfString:string].location == 0;
}

- (BOOL)endsWith:(NSString *)string
{
    return [self rangeOfString:string options:NSBackwardsSearch].location + string.length == self.length;
}

- (NSString *)stringByTrimming
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSRange)fullRange
{
    return NSMakeRange(0, self.length);
}

- (NSString *)stringBySimpleStrippingTags
{
    NSMutableString *ms = [NSMutableString stringWithCapacity:[self length]];
    
    NSScanner *scanner = [NSScanner scannerWithString:self];
    [scanner setCharactersToBeSkipped:nil];
    NSString *s = nil;
    while (![scanner isAtEnd])
    {
        [scanner scanUpToString:@"<" intoString:&s];
        if (s != nil)
            [ms appendString:s];
        [scanner scanUpToString:@">" intoString:NULL];
        if (![scanner isAtEnd])
            [scanner setScanLocation:[scanner scanLocation]+1];
        s = nil;
    }
    
    return ms;
}

- (NSString *)stringByTranslit
{
    if (!__translitDictionary)
    {
        __translitDictionary = @{@"А": @"A",
                                 @"Б": @"B",
                                 @"В": @"V",
                                 @"Г": @"G",
                                 @"Д": @"D",
                                 @"Е": @"E",
                                 @"Ё": @"Yo",
                                 @"Ж": @"Zh",
                                 @"З": @"Z",
                                 @"И": @"I",
                                 @"Й": @"J",
                                 @"К": @"K",
                                 @"Л": @"L",
                                 @"М": @"M",
                                 @"Н": @"N",
                                 @"О": @"O",
                                 @"П": @"P",
                                 @"Р": @"R",
                                 @"С": @"S",
                                 @"Т": @"T",
                                 @"У": @"U",
                                 @"Ф": @"F",
                                 @"Х": @"H",
                                 @"Ц": @"C",
                                 @"Ч": @"Ch",
                                 @"Ш": @"Sh",
                                 @"Щ": @"Sch",
                                 @"Ь": @"'",
                                 @"Ъ": @"\"",
                                 @"Э": @"E",
                                 @"Ю": @"Yu",
                                 @"Я": @"Ya",
                                 @"а": @"a",
                                 @"б": @"b",
                                 @"в": @"v",
                                 @"г": @"g",
                                 @"д": @"d",
                                 @"е": @"e",
                                 @"ё": @"yo",
                                 @"ж": @"zh",
                                 @"з": @"z",
                                 @"и": @"i",
                                 @"й": @"j",
                                 @"к": @"k",
                                 @"л": @"l",
                                 @"м": @"m",
                                 @"н": @"n",
                                 @"о": @"o",
                                 @"п": @"p",
                                 @"р": @"r",
                                 @"с": @"s",
                                 @"т": @"t",
                                 @"у": @"u",
                                 @"ф": @"f",
                                 @"х": @"h",
                                 @"ц": @"c",
                                 @"ч": @"ch",
                                 @"ш": @"sh",
                                 @"щ": @"sch",
                                 @"ь": @"'",
                                 @"ъ": @"\"",
                                 @"э": @"e",
                                 @"ю": @"yu",
                                 @"я": @"ya"};
        
    }
    
    NSMutableString *result = [self mutableCopy];
    for (NSString *key in __translitDictionary)
    {
        NSString *value = __translitDictionary[key];
        [result replaceOccurrencesOfString:key withString:value options:0 range:NSMakeRange(0, result.length)];
    }
    return result;
}

- (NSInteger)indexOfCharacter:(unichar)ch
{
    return [self indexOfCharacter:ch fromIndex:0];
}

- (NSInteger)indexOfCharacter:(unichar)ch fromIndex:(NSInteger)index
{
    NSInteger length = [self length];
    for (NSInteger ix = index; ix < length; ++ix)
    {
        if ([self characterAtIndex:ix] == ch)
        {
            return ix;
        }
    }
    return NSNotFound;
}

- (BOOL)isEmail
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:self];
}

- (NSString *)stringByReplacingNotNumbers
{
    NSMutableString *strippedString = [NSMutableString stringWithCapacity:self.length];
    
    NSScanner *scanner = [NSScanner scannerWithString:self];
    NSCharacterSet *numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    
    while ([scanner isAtEnd] == NO)
    {
        NSString *buffer;
        if ([scanner scanCharactersFromSet:numbers intoString:&buffer])
        {
            [strippedString appendString:buffer];
            
        }
        else
        {
            [scanner setScanLocation:([scanner scanLocation] + 1)];
        }
    }
    
    return strippedString;
}

#pragma mark - if string url

- (NSString *)baseURL
{
    NSURL *url = [NSURL URLWithString:self];
    
    return [NSString stringWithFormat:@"%@://%@/", [url scheme], [url host]];
}

- (NSString *)hostURL
{
    NSURL *url = [NSURL URLWithString:self];
    
    return [url host];
}

- (NSString *)pathURL
{
    NSURL *url = [NSURL URLWithString:self];
    
    NSMutableString *resultString = [NSMutableString string];
    
    NSString *path = [url path];
    if([path length])
    {
        [resultString appendString:path];
    }
    
    NSString *params = [url parameterString];
    if([params length])
    {
        [resultString appendString:params];
    }
    
    NSString *query = [url query];
    if([query length])
    {
        [resultString appendString:query];
    }
    
    return resultString;
}

- (NSString *)fullURLWithPath:(NSString *)path
{
    NSString *baseUrl = [self baseURL];
    path = [path stringByTrimming];
    
    if([path rangeOfString:@"/"].location == 0)
    {
        path = [path substringFromIndex:1];
    }
    
    return [baseUrl stringByAppendingString:path];
}

- (NSString *)MD5Hash
{
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    
    CFRetain((__bridge CFTypeRef)(self));
    CC_MD5([self UTF8String], [self length], digest);
    CFRelease((__bridge CFTypeRef)(self));
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
    {
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return output;
}

- (NSString *)SHA1Hash
{
    unsigned char digest[CC_SHA1_DIGEST_LENGTH];
    
    CFRetain((__bridge CFTypeRef)(self));
    CC_SHA1([self UTF8String], [self length], digest);
    CFRelease((__bridge CFTypeRef)(self));
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
    {
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return output;
}

- (NSString *)HMACUsingSHA1_withSecretKey:(NSString *)secretKey
{
    unsigned char digest[CC_SHA1_DIGEST_LENGTH];
    
    CFRetain((__bridge CFTypeRef)(self)); CFRetain((__bridge CFTypeRef)(secretKey));
    
    CCHmac(kCCHmacAlgSHA1, [secretKey UTF8String], [secretKey length], [self UTF8String], [self length], &digest);
    
    CFRelease((__bridge CFTypeRef)(self));
    CFRelease((__bridge CFTypeRef)(secretKey));
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
    {
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return output;
}

@end
