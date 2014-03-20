//
//  SampleViewController.m
//  ACNavBarDrawer
//
//  Created by albert on 13-7-29.
//  Copyright (c) 2013年 albert. All rights reserved.
//


#import "SampleViewController.h"

#import "ACNavBarDrawer.h"

#import "TestNextViewController.h"


@interface SampleViewController () <ACNavBarDrawerDelegate>
{
    /** 导航栏 按钮 加号 图片 */
    UIImageView *_plusIV;
    
    /** 抽屉视图 */
    ACNavBarDrawer *_drawerView;
}

@end


@implementation SampleViewController


#pragma mark - Action Methods

- (void)testNextVC:(UIButton *)button
{
    // Creat VC
    TestNextViewController *nextVC = [[TestNextViewController alloc] init];
    
    // Push
    [self.navigationController pushViewController:nextVC animated:YES];
    
}

- (void)navPlusBtnPressed:(UIButton *)sender
{
    // 如果是关，则开，反之亦然
    if (_drawerView.isOpen == NO)
    {
        [_drawerView openNavBarDrawer];
    }
    else
    {
        [_drawerView closeNavBarDrawer];
    }
    
    [self rotatePlusIV];
}

#pragma mark - Rotate _plusIV

- (void)rotatePlusIV
{
    // 旋转加号按钮
    float angle = _drawerView.isOpen ? -M_PI_4 : 0.0f;
    [UIView animateWithDuration:0.2f animations:^{
        _plusIV.transform = CGAffineTransformMakeRotation(angle);
    }];
}

#pragma mark - ACNavBarDrawerDelegate

-(void)didTapButtonAtIndex:(NSInteger)itemIndex
{
    DLog(@"按钮%d被点击", (itemIndex + 1));
    
    switch (itemIndex)
    {
        case 0:
        {
            
        }
            break;
            
        case 1:
        {
            
        }
            break;
            
        case 2:
        {
            // Creat VC
            TestNextViewController *nextVC = [[TestNextViewController alloc] init];
            
            // Modal
            nextVC.needDismissButton = YES;
            UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:nextVC];
            nc.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
            
            [self presentViewController:nc animated:YES completion:nil];
        }
            break;
            
        case 3:
        {
            
        }
            break;
            
        default:
            break;
    }
    
    // 点完按钮，旋回加号图片
    [self rotatePlusIV];
}

-(void)drawerWillClose
{
    // 抽屉视图将要关闭时，需要通过回调，旋回加号图片
    [self rotatePlusIV];
}


#pragma mark - Life Cycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"Sample";
    
    [self.view setBackgroundColor:[UIColor scrollViewTexturedBackgroundColor]];
    
    //** barButton *********************************************************************************
    CGFloat navRightBtn_w = 40.f;
    CGFloat navRightBtn_h = 30.f;
    CGFloat navRightBtn_x = App_Frame_Width - 10.f;
    CGFloat navRightBtn_y = (kTopBarHeight - navRightBtn_h) / 2.f;

    UIButton *navRightBtn = [[UIButton alloc] init];
    [navRightBtn setFrame:CGRectMake(navRightBtn_x,
                                     navRightBtn_y,
                                     navRightBtn_w,
                                     navRightBtn_h)];
    
    // 按钮背景图片
    //UIImage *navRightBtnBGImg = PNGIMAGE(@"nav_btn");
    //[navRightBtn setBackgroundImage:navRightBtnBGImg forState:UIControlStateNormal];
    
    
    //-- 按钮上的图片 --------------------------------------------------------------------------------
    CGFloat plusIV_w = 20.f;
    CGFloat plusIV_h = 20.f;
    CGFloat plusIV_x = (navRightBtn.bounds.size.width - plusIV_w) / 2.f;
    CGFloat plusIV_y = (navRightBtn.bounds.size.height - plusIV_h) / 2.f;
    
    _plusIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav_plus"]];
    [_plusIV setFrame:CGRectMake(plusIV_x,
                                 plusIV_y,
                                 plusIV_w,
                                 plusIV_h)];
    
    [navRightBtn addSubview:_plusIV];
    //---------------------------------------------------------------------------------------------;
    
    
    // 设置按钮点击时调用的方法
    [navRightBtn addTarget:self action:@selector(navPlusBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:navRightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    //*********************************************************************************************;
    
    
    //** 抽屉对象 ***********************************************************************************
    
    //-- 按钮图文数组 --------------------------------------------------------------------------------
    // 东西不多就不建数据对象或者读取 plist 了，第一个为图片名、第二个为按钮名
    // 可根据数组大小自适应，最好是 2-5 个按钮，1个很2，5个以上很丑
    NSArray *allItems = @[@[@"drawer_msg", @"按钮1"],
                          @[@"drawer_msg", @"按钮2"],
                          @[@"drawer_msg", @"弹视图"],
                          @[@"drawer_msg", @"按钮4"]];
    //---------------------------------------------------------------------------------------------;
    
    /** 初始化 */
    _drawerView = [[ACNavBarDrawer alloc] initWithView:self.view andItemInfoArray:allItems];
    _drawerView.delegate = self;
    //*********************************************************************************************;
    
    
    
    
    
    //** 测试按钮  ***********************************************************************************
    UIButton *tbtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 120, 30)];
    
    tbtn.backgroundColor = [UIColor orangeColor];
    
    [tbtn setTitle:@"testPushVC" forState:UIControlStateNormal];
    [tbtn setTitleColor:[UIColor whiteColor]
               forState:UIControlStateNormal];
    
    
    [tbtn addTarget:self
             action:@selector(testNextVC:)
   forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:tbtn];
    //*********************************************************************************************;
        
}

- (void)viewWillDisappear:(BOOL)animated
{
    // 视图将要消失时 关闭抽屉
    [_drawerView closeNavBarDrawer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
