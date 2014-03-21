//
//  UINavigationItem+FixedSpaceButton.m
//  ACNavBarDrawer
//
//  Created by Albert Chu on 14-3-21.
//  Copyright (c) 2014年 albert. All rights reserved.
//

#import "UINavigationItem+FixedSpaceButton.h"

#define CurrentVersion          [UIDevice currentDevice].systemVersion.floatValue

@implementation UINavigationItem (FixedSpaceButton)

#pragma mark - Public Methods

- (void)setLeftBarButtonWithCustomButton:(UIButton *)button
{
    [self setLeftBarButtonItems:[self makeBarButtonItemsWithCustomButton:button] animated:NO];
}

- (void)setRightBarButtonWithCustomButton:(UIButton *)button
{
    [self setRightBarButtonItems:[self makeBarButtonItemsWithCustomButton:button] animated:NO];
}

#pragma mark - Private Method

- (NSArray *)makeBarButtonItemsWithCustomButton:(UIButton *)button
{
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    if (CurrentVersion >= 7.0f)
    {
        negativeSpacer.width = -16;
    }
    else
    {
        negativeSpacer.width = -6;
    }
    return [NSArray arrayWithObjects:negativeSpacer, buttonItem, nil];
}

@end
