//
//  NSObject+VDExtensions.m
//  VD
//
//  Created by Evgeniy Tka4enko on 01.07.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import "NSObject+VDExtensions.h"
#import "NSString+VDExtensions.h"
#import <objc/runtime.h>

static const char *property_getTypeName(objc_property_t property)
{
	const char *attributes = property_getAttributes(property);
	char buffer[1 + strlen(attributes)];
	strcpy(buffer, attributes);
	char *state = buffer, *attribute;
	while ((attribute = strsep(&state, ",")) != NULL)
    {
		if (attribute[0] == 'T')
        {
			size_t len = strlen(attribute);
			attribute[len - 1] = '\0';
			return (const char *)[[NSData dataWithBytes:(attribute + 3) length:len - 2] bytes];
		}
	}
	return "@";
}

@implementation NSObject (VDExtensions)

- (NSString *)className
{
    return NSStringFromClass([self class]);
}

+ (NSString *)className
{
    return NSStringFromClass([self class]);
}

static NSMutableDictionary *propertiesForClassDictionary;

+ (NSArray *)propertyNames
{
    return [self propertyNamesWithSuperclassProperies:NO];
}

+ (NSArray *)propertyNamesWithSuperclassProperies
{
    return [self propertyNamesWithSuperclassProperies:YES];
}

+ (NSArray *)propertyNamesWithSuperclassProperies:(BOOL)isIncludeSuperclassProperties
{
	if (!propertiesForClassDictionary)
    {
        propertiesForClassDictionary = [[NSMutableDictionary alloc] init];
    }
    
    Class klass = [self class];
	
	NSString *className = NSStringFromClass(klass);
	NSArray *value = [propertiesForClassDictionary objectForKey:className];
	
	if (value)
    {
		return value;
	}
	
	NSMutableArray *propertyNamesArray = [NSMutableArray array];
	unsigned int propertyCount = 0;
	objc_property_t *properties = class_copyPropertyList(klass, &propertyCount);
	
	for (unsigned int i = 0; i < propertyCount; ++i)
    {
		objc_property_t property = properties[i];
		const char * name = property_getName(property);
		
		[propertyNamesArray addObject:[NSString stringWithUTF8String:name]];
	}
	free(properties);
	
	[propertiesForClassDictionary setObject:propertyNamesArray forKey:className];
    
    if(isIncludeSuperclassProperties)
    {
        NSArray* arr = [[self superclass] propertyNamesWithSuperclassProperies:isIncludeSuperclassProperties];
        [propertyNamesArray addObjectsFromArray:arr];
    }
    return propertyNamesArray;
}

static NSMutableDictionary *propertyClassByClassAndPropertyName;

+ (Class)propertyClass:(NSString *)propertyName
{
	if (!propertyClassByClassAndPropertyName)
    {
        propertyClassByClassAndPropertyName = [[NSMutableDictionary alloc] init];
    }
    
    Class klass = [self class];
	
	NSString *key = [NSString stringWithFormat:@"%@:%@", NSStringFromClass(klass), propertyName];
	NSString *value = [propertyClassByClassAndPropertyName objectForKey:key];
	
	if (value)
    {
		return NSClassFromString(value);
	}
    
    objc_property_t property = class_getProperty(klass, [propertyName UTF8String]);
    
    if(property)
    {
        NSString *className = [NSString stringWithUTF8String:property_getTypeName(property)];
        [propertyClassByClassAndPropertyName setObject:className forKey:key];
        return NSClassFromString(className);
    }
    
	return [[self superclass] propertyClass:propertyName];
}

+ (BOOL)isPropertyReadOnly:(NSString *)propertyName
{
    Class klass = [self class];
    const char * type = property_getAttributes(class_getProperty(klass, [propertyName UTF8String]));
    NSString * typeString = [NSString stringWithUTF8String:type];
    NSArray * attributes = [typeString componentsSeparatedByString:@","];
    NSString * typeAttribute = [attributes objectAtIndex:1];
    
    return [typeAttribute rangeOfString:@"R"].length > 0;
}

+ (BOOL)isHasProperty:(NSString *)propertyName
{
    return [[self propertyNames] containsString:propertyName];
}

static NSMutableDictionary *methodForClassDictionary;

+ (NSArray *)methodNames
{
    if (!methodForClassDictionary)
    {
        methodForClassDictionary = [[NSMutableDictionary alloc] init];
    }
    
    Class klass = [self class];
	
	NSString *className = NSStringFromClass(klass);
	NSArray *value = [methodForClassDictionary objectForKey:className];
	
	if (value)
    {
		return value;
	}
	
	NSMutableArray *methodNamesArray = [NSMutableArray array];
	unsigned int propertyCount = 0;
	Method *methods = class_copyMethodList(klass, &propertyCount);
	
	for (unsigned int i = 0; i < propertyCount; ++i)
    {
		Method method = methods[i];
		NSString *name = NSStringFromSelector(method_getName(method));
		
		[methodNamesArray addObject:name];
	}
	free(methods);
	
	[methodForClassDictionary setObject:methodNamesArray forKey:className];
    NSArray* arr = [[self superclass] methodNames];
	[methodNamesArray addObjectsFromArray:arr];
    return methodNamesArray;
}

+ (BOOL)isHasMethod:(NSString *)methodName
{
    return [[self methodNames] containsString:methodName];
}

+ (void)exchangeImplementations:(NSString *)methodOneName with:(NSString *)methodTwoName
{
    Class klass = [self class];
    
    Method methodOne = class_getClassMethod(klass, NSSelectorFromString(methodOneName));
    if(!methodOne)
    {
        methodOne = class_getInstanceMethod(klass, NSSelectorFromString(methodOneName));
    }
    
    Method methodTwo = class_getClassMethod(klass, NSSelectorFromString(methodTwoName));
    if(!methodTwo)
    {
        methodTwo = class_getInstanceMethod(klass, NSSelectorFromString(methodTwoName));
    }
    
    if(methodOne && methodTwo)
    {
        method_exchangeImplementations(methodOne, methodTwo);
    }
}

@end
