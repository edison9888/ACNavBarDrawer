//
//  ACNavBarDrawer.m
//  ACNavBarDrawer
//
//  Created by albert on 13-7-29.
//  Copyright (c) 2013年 albert. All rights reserved.
//

#import "ACNavBarDrawer.h"

#define AppFrameWidth           [[UIScreen mainScreen] applicationFrame].size.width
#define CurrentVersion          [UIDevice currentDevice].systemVersion.floatValue

//** 常量 *******************************************************************************************
/** 抽屉视图高度 */
static CGFloat const ACNavBarDrawer_Height = 80.0f;

/** 抽屉视图透明度 */
static CGFloat const ACNavBarDrawer_Alpha = 0.8f;

/** 抽屉打开时黑色遮罩层透明度 */
static CGFloat const ACNavBarDrawer_MaskAlpha = 0.3f;

/** 抽屉视图打开及关闭动画的时长 */
static CGFloat const ACNavBarDrawer_Duration = 0.36f;
//************************************************************************************************//


@interface ACNavBarDrawer ()
{
    /** 背景遮罩 */
    UIControl               *_mask;
}

@end


@implementation ACNavBarDrawer


#pragma mark - Action Methods

- (void)itemButtonPressed:(UIButton *)button
{
    if (nil != _delegate && [_delegate respondsToSelector:@selector(didTapButtonAtIndex:)])
    {
        [self closeNavBarDrawer];
        [_delegate didTapButtonAtIndex:button.tag];
    }
}

- (void)willCloseDrawer
{
    if (nil != _delegate && [_delegate respondsToSelector:@selector(drawerWillClose)])
    {
        [_delegate drawerWillClose];
    }
}

- (void)closeActionFinished
{
    if (nil != _delegate && [_delegate respondsToSelector:@selector(drawerDidClose)])
    {
        [_delegate drawerDidClose];
    }
}

- (void)maskTapped
{
    [self closeNavBarDrawer];
    if (nil != _delegate && [_delegate respondsToSelector:@selector(didTapOnMask)])
    {
        [_delegate didTapOnMask];
    }
}


#pragma mark - Private Methods

- (void)createButtonsByCount:(NSInteger)number andItemInfoArray:(NSArray *)array
{
    // 每个格子的宽度
    CGFloat barItem_w = ([[UIScreen mainScreen] applicationFrame].size.width / number);
    
    // 每个格子的 中点
    CGFloat barItem_center_y = (ACNavBarDrawer_Height / 2.f);
    
    // button 宽高
    CGFloat btn_w = 40.f;
    CGFloat btn_h = 40.f;
    
    // label 宽高
    CGFloat lab_w = 60.f;
    CGFloat lab_h = 24.f;
    
    // 每个button的中点
    CGFloat btn_center_y = barItem_center_y - (lab_h / 2.f);
    
    // 每个lable的中点
    CGFloat lab_center_y = btn_center_y + ((btn_h + lab_h) / 2.f);
    
    for (NSInteger i = 0; i < number; i++)
    {
        //-- button -------------------------------------------------------------------------------
        UIButton *theBtn = [[UIButton alloc] init];
        [theBtn setBounds:CGRectMake(0.f,
                                     0.f,
                                     btn_w,
                                     btn_h)];
        
        CGFloat item_center_x = i * barItem_w + (barItem_w / 2.f);
        [theBtn setCenter:CGPointMake(item_center_x,
                                      btn_center_y)];
        
        theBtn.tag = i;
        
        [theBtn setBackgroundColor:[UIColor clearColor]];
        
        NSString *imgName = [((NSArray *)[array objectAtIndex:i]) objectAtIndex:0];
        [theBtn setBackgroundImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
        
        [theBtn addTarget:self action:@selector(itemButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:theBtn];
        
        //-- label -------------------------------------------------------------------------------
        UILabel *theLabel = [[UILabel alloc] init];
        [theLabel setBounds:CGRectMake(0.f,
                                       0.f,
                                       lab_w,
                                       lab_h)];
        
        [theLabel setCenter:CGPointMake(item_center_x,
                                        lab_center_y)];
        
        [theLabel setBackgroundColor:[UIColor clearColor]];
        
        [theLabel setFont:[UIFont boldSystemFontOfSize:14.f]];
        [theLabel setTextColor:[UIColor whiteColor]];
        [theLabel setTextAlignment:NSTextAlignmentCenter];
        
        NSString *labelText = [((NSArray *)[array objectAtIndex:i]) objectAtIndex:1];
        [theLabel setText:labelText];
        
        [self addSubview:theLabel];
    }
}

#pragma mark - Public Methods

- (id)initWithView:(UIView *)view andItemInfoArray:(NSArray *)array
{
    self = [super init];
    if (self)
    {
        // Initialization code
        _isOpen = NO;
        
        //-- 遮罩层 view ----------------------------------------------------------------------------
        _mask = [[UIControl alloc] initWithFrame:view.bounds];
        
        _mask.backgroundColor = [UIColor blackColor];
        _mask.alpha = 0.0f;
        [_mask addTarget:self action:@selector(maskTapped) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:_mask];
        //-----------------------------------------------------------------------------------------;
        
        self.frame = CGRectMake(0.f,
                                -ACNavBarDrawer_Height,
                                [[UIScreen mainScreen] applicationFrame].size.width,
                                ACNavBarDrawer_Height);
        
        self.backgroundColor = [UIColor blackColor];
        self.alpha = ACNavBarDrawer_Alpha;
        
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
        self.layer.shadowRadius = 0.5f;
        self.layer.shadowOpacity = 0.8f;
        self.layer.masksToBounds = NO;
        
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.bounds];
        self.layer.shadowPath = path.CGPath;        
        
        [view addSubview:self];
        
        //-- 创建按钮 -------------------------------------------------------------------------------
        [self createButtonsByCount:[array count] andItemInfoArray:array];
        
    }
    return self;
}

- (void)openNavBarDrawer
{
    [self.superview bringSubviewToFront:_mask];
    [self.superview bringSubviewToFront:self];
    
    _isOpen = YES;
    
    CGPoint centerPoint = CGPointMake((AppFrameWidth / 2), (ACNavBarDrawer_Height / 2.f));
    
    // 如果 7.0 以上系统则抽屉视图打开动画最终中点整体下移 64 pt
    if (CurrentVersion >= 7.0f)
    {
        centerPoint = CGPointMake((AppFrameWidth / 2), (ACNavBarDrawer_Height / 2.f) + 64);
    }
    
    [UIView animateWithDuration:ACNavBarDrawer_Duration animations:^{
        _mask.alpha = ACNavBarDrawer_MaskAlpha;
        self.center = centerPoint;
    }];
}

- (void)closeNavBarDrawer
{
    _isOpen = NO;
    
    [UIView animateWithDuration:ACNavBarDrawer_Duration
                     animations:^{
                         [self willCloseDrawer];
                         _mask.alpha = 0.f;
                         self.center = CGPointMake((AppFrameWidth / 2), -(ACNavBarDrawer_Height / 2.f));
                     }
                     completion:^(BOOL finished) {
                         if (finished) {
                             [self closeActionFinished];
                         }
                     }];
}


@end
