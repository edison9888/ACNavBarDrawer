//
//  ACRotateButton.h
//  ACNavBarDrawer
//
//  Created by Albert Chu on 14-3-21.
//  Copyright (c) 2014年 albert. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ACRotateButton : UIButton

@property (nonatomic) BOOL isOpen;

/**
 *  旋转图片
 */
- (void)rotate;

@end
