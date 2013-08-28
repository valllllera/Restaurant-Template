//
//  UIViewController+Extensions.m
//  Restaurant
//
//  Created by Evgeniy Tka4enko on 06.08.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import "UIViewController+Extensions.h"
#import "AppDelegate.h"

@implementation UIViewController (Extensions)

- (void)createChangeContentButton
{
    NSString *title = @"Пицца";
    if(AppSettingsShared.contentType == ContentTypePizza)
    {
        title = @"Суши";
    }
    
    UIButton *changeContentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [changeContentButton setTitleColor:[UIColor colorWithRed:0.376 green:0.208 blue:0.220 alpha:1.000] forState:UIControlStateNormal];
    [changeContentButton setTitle:title forState:UIControlStateNormal];
    [changeContentButton setBackgroundImage:[[UIImage imageNamed:@"right_button_navigation.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)] forState:UIControlStateNormal];
    changeContentButton.frame = CGRectMake(0, 0, 80, 25);
    [changeContentButton addTarget:self action:@selector(changeContentButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    changeContentButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:10];
    
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithCustomView:changeContentButton];
    self.navigationItem.rightBarButtonItem = button;
}



#pragma mark - Actions

- (void)changeContentButtonPressed:(id)sender
{
    if(AppSettingsShared.contentType == ContentTypePizza)
    {
        [AppDelegate(AppDelegate) showContentViewControllerWithContentType:ContentTypeSushi withselectedIndex:self.tabBarController.selectedIndex];
    }
    else
    {
        [AppDelegate(AppDelegate) showContentViewControllerWithContentType:ContentTypePizza withselectedIndex:self.tabBarController.selectedIndex];
    }
}

@end
