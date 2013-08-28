//
//  AppSettings.h
//  Restaurant
//
//  Created by Evgeniy Tka4enko on 31.07.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import <Foundation/Foundation.h>

#define AppSettingsShared [AppSettings sharedInstance]

typedef enum
{
    ContentTypePizza = 1,
    ContentTypeSushi
} ContentType;

@interface AppSettings : NSObject

@property (assign, nonatomic) ContentType contentType;

+ (AppSettings *)sharedInstance;

@end

#define kCellDeselectAnimationDuration 0.5
#define kServApiBaseUrl @"http://pizza33.zeema.org.ua/"
#define kServBaseUrl (AppSettingsShared.contentType == ContentTypePizza ? @"http://pizza33.zeema.org.ua/" : @"http://sushi33.zeema.org.ua/")

#define kServApiDataPath @"/mobile/apple/main.php"
#define kServApiOrderKey @"asdliuawe98312SADF023nmcsdSAsocheeMQpfD334d"
#define kServApiOrderPath @"/import_data.php"

#define kFacebookAppUrl @"fb://profile/144200265729583"
#define kFacebookBrowserUrl @"https://www.facebook.com/Pizzeria33"