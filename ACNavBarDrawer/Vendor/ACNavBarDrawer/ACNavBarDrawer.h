//
//  ACNavBarDrawer.h
//  ACNavBarDrawer
//
//  Created by albert on 13-7-29.
//  Copyright (c) 2013年 albert. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 抽屉视图 代理协议 */
@protocol ACNavBarDrawerDelegate <NSObject>

@required
/** 点击按钮动作 回调 */
- (void)didTapButtonAtIndex:(NSInteger)itemIndex;

@optional
/** 抽屉将要开始关闭 回调 */
- (void)drawerWillClose;

/** 抽屉完成关闭 回调 */
- (void)drawerDidClose;

/** 触摸背景遮罩动作 回调 */
- (void)didTapOnMask;

@end


@interface ACNavBarDrawer : UIView

/** 代理对象 */
@property (nonatomic, assign) id <ACNavBarDrawerDelegate> delegate;

/** 抽屉视图是否已打开 */
@property (nonatomic) BOOL isOpen;


/**
 * 实例化抽屉视图
 * @param view 需要把抽屉视图显示在哪个 UIView 上
 */
- (id)initWithView:(UIView *)view andItemInfoArray:(NSArray *)array;

/**
 * 打开抽屉
 */
- (void)openNavBarDrawer;

/**
 * 关闭抽屉
 */
- (void)closeNavBarDrawer;

@end
