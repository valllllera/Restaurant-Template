//
//  VDMacroses.h
//  VD
//
//  Created by Evgeniy Tka4enko on 02.07.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

// Device dimensions
#define IS_IPAD   (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE_5 (( int )[[ UIScreen mainScreen ] bounds ].size.height - 568 == 0 )

#define IPAD_HEIGHT 1024
#define IPAD_WIDTH 768
#define IPAD_TAB_BAR_HEIGHT 84
#define IPAD_NAV_BAR_HEIGHT 44
#define IPAD_KEYBOARD_PORTRAIT_HEIGHT 264
#define IPAD_KEYBOARD_LANDSCAPE_HEIGHT 352

#define IPHONE_HEIGHT (IS_IPHONE_5 ? 568 : 480)
#define IPHONE_WIDTH 320
#define IPHONE_TAB_BAR_HEIGHT 49 // default is 50
#define IPHONE_NAV_BAR_HEIGHT 44 // default is 44
#define IPHONE_KEYBOARD_PORTRAIT_HEIGHT 216
#define IPHONE_KEYBOARD_LANDSCAPE_HEIGHT 162

#define IDEVICE_HEIGHT (IS_IPHONE ? IPHONE_HEIGHT : IPAD_HEIGHT)
#define IDEVICE_WIDTH (IS_IPHONE ? IPHONE_WIDTH : IPAD_WIDTH)
#define IDEVICE_TAB_BAR_HEIGHT (IS_IPHONE ? IPHONE_TAB_BAR_HEIGHT : IPAD_TAB_BAR_HEIGHT)
#define IDEVICE_NAV_BAR_HEIGHT (IS_IPHONE ? IPHONE_NAV_BAR_HEIGHT : IPAD_NAV_BAR_HEIGHT)
#define IDEVICE_KEYBOARD_PORTRAIT_HEIGHT (IS_IPHONE ? IPHONE_KEYBOARD_PORTRAIT_HEIGHT : IPAD_KEYBOARD_PORTRAIT_HEIGHT)
#define IDEVICE_KEYBOARD_LANDSCAPE_HEIGHT (IS_IPHONE ? IPHONE_KEYBOARD_LANDSCAPE_HEIGHT : IPAD_KEYBOARD_LANDSCAPE_HEIGHT)
#define IDEVICE_STATUS_BAR_HEIGHT 20

// App Information
#define AppName                 [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"]
#define AppVersion              [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]
#define AppDelegate(type)       ((type *)[[UIApplication sharedApplication] delegate])


// OS Information
#define IOS_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define IOS_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define IOS_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define IOS_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define IOS_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

// Device Information


// Directories
static inline NSString *CachesDirectory() {	return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]; }
static inline NSString *LibraryDirectory() { return [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0]; }
static inline NSString *DocumentsDirectory() { return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]; }

// Actions
#define OpenURL(urlString) [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]]]


// User Interface Related
#define RootViewController [[[[UIApplication sharedApplication] delegate] window] rootViewController]

#define ShowNetworkActivityIndicator()      [UIApplication sharedApplication].networkActivityIndicatorVisible = YES
#define HideNetworkActivityIndicator()      [UIApplication sharedApplication].networkActivityIndicatorVisible = NO


// Rect stuff
#define CGWidth(rect)                   rect.size.width
#define CGHeight(rect)                  rect.size.height
#define CGOriginX(rect)                 rect.origin.x
#define CGOriginY(rect)                 rect.origin.y

#define CGRectModify(rect,dx,dy,dw,dh)  CGRectMake(rect.origin.x + dx, rect.origin.y + dy, rect.size.width + dw, rect.size.height + dh)
#define CGRectScale(rect, scale)  CGRectMake(rect.origin.x * scale, rect.origin.y * scale, rect.size.width * scale, rect.size.height * scale)

#define NSLogRect(rect)                 NSLog(@"%@", NSStringFromCGRect(rect))
#define NSLogSize(size)                 NSLog(@"%@", NSStringFromCGSize(size))
#define NSLogPoint(point)               NSLog(@"%@", NSStringFromCGPoint(point))