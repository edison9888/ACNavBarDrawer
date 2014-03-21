//
//  ACRotateButton.m
//  ACNavBarDrawer
//
//  Created by Albert Chu on 14-3-21.
//  Copyright (c) 2014年 albert. All rights reserved.
//

#import "ACRotateButton.h"


@interface ACRotateButton ()

@property (strong, nonatomic) UIImageView *rotateIV;

@end


@implementation ACRotateButton


- (void)rotate
{
    self.isOpen = self.isOpen ? NO : YES;
    float angle = self.isOpen ? -M_PI_4 : 0.0f;
    [UIView animateWithDuration:0.2f animations:^{
        self.rotateIV.transform = CGAffineTransformMakeRotation(angle);
    }];
}

- (void)addRoatateImageView
{
    CGFloat plusIV_w = 20.f;
    CGFloat plusIV_h = 20.f;
    CGFloat plusIV_x = (self.bounds.size.width - plusIV_w) / 2.0f;
    CGFloat plusIV_y = (self.bounds.size.height - plusIV_h) / 2.0f;
    
    self.rotateIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav_plus"]];
    self.rotateIV.frame = CGRectMake(plusIV_x,
                                     plusIV_y,
                                     plusIV_w,
                                     plusIV_h);
    
    [self addSubview:self.rotateIV];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self addRoatateImageView];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
