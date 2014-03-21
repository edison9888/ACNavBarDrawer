//
//  UINavigationItem+FixedSpaceButton.h
//  ACNavBarDrawer
//
//  Created by Albert Chu on 14-3-21.
//  Copyright (c) 2014年 albert. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationItem (FixedSpaceButton)

- (void)setLeftBarButtonWithCustomButton:(UIButton *)button;

- (void)setRightBarButtonWithCustomButton:(UIButton *)button;

@end
