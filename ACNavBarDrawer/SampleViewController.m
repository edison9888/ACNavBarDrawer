//
//  SampleViewController.m
//  ACNavBarDrawer
//
//  Created by albert on 13-7-29.
//  Copyright (c) 2013年 albert. All rights reserved.
//

#import "SampleViewController.h"
#import "TestNextViewController.h"

#import "ACNavBarDrawer.h"
#import "ACRotateButton.h"

@interface SampleViewController () <ACNavBarDrawerDelegate>

@property (strong, nonatomic) ACNavBarDrawer *drawerView;
@property (strong, nonatomic) ACRotateButton *rotateButton;

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
    // 旋转按钮图片
    [self.rotateButton rotate];
    
    // 抽屉如果是关，则开，反之亦然
    if (_drawerView.isOpen)
    {
        [_drawerView closeNavBarDrawer];
    }
    else
    {
        [_drawerView openNavBarDrawer];
    }
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
}

-(void)drawerWillClose
{
    // 抽屉视图将要关闭时，看按钮是否处于打开状态，如果是则说明不是通过点击按钮来完成的关闭抽屉动作，故需要复原。
    if (self.rotateButton.isOpen)
    {
        [self.rotateButton rotate];
    }
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
    
    self.view.backgroundColor = C_BG;
    
    //** 导航栏按钮 **********************************************************************************
    // 自定义旋转式按钮
    self.rotateButton = [[ACRotateButton alloc] initWithFrame:CGRectMake(0.0,
                                                                         0.0,
                                                                         52.0f,
                                                                         44.0f)];
    
    // 设置按钮点击时调用的方法
    [self.rotateButton addTarget:self action:@selector(navPlusBtnPressed:) forControlEvents:UIControlEventTouchUpInside];

    // 用修正距离的类别方法设置为导航栏按钮
    [self.navigationItem setRightBarButtonWithCustomButton:self.rotateButton];
    //*********************************************************************************************;
    
    
    //** 抽屉视图 ***********************************************************************************
    // 东西不多就不建数据对象或者读取 plist 了，第一个为图片名、第二个为按钮名
    // 可根据数组大小自适应，最好是 2-5 个按钮，1个很2，5个以上很丑
    NSArray *allItems = @[@[@"drawer_msg", @"按钮1"],
                          @[@"drawer_msg", @"按钮2"],
                          @[@"drawer_msg", @"弹视图"],
                          @[@"drawer_msg", @"按钮4"]];
    
    // 初始化
    _drawerView = [[ACNavBarDrawer alloc] initWithView:self.view andItemInfoArray:allItems];
    _drawerView.delegate = self;
    //*********************************************************************************************;
    
    
    //** 测试按钮  **********************************************************************************
    UIButton *tbtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 120, 40)];
    tbtn.backgroundColor = [UIColor orangeColor];
    [tbtn setTitle:@"testPushVC" forState:UIControlStateNormal];
    [tbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [tbtn addTarget:self action:@selector(testNextVC:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:tbtn];
    //*********************************************************************************************;
        
}

- (void)viewWillDisappear:(BOOL)animated
{
    // 视图将要消失时，如果抽屉是打开的则关闭抽屉
    if (_drawerView.isOpen)
    {
        [_drawerView closeNavBarDrawer];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
