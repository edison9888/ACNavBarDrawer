//
//  TestNestViewController.m
//  ACNavBarDrawer
//
//  Created by albert on 13-7-30.
//  Copyright (c) 2013年 albert. All rights reserved.
//

#import "TestNextViewController.h"

@interface TestNextViewController ()

@end


@implementation TestNextViewController

- (void)dismissButtonPressed:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

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
    
    self.title = @"EmptyView";
    
    self.view.backgroundColor = RGBCOLOR(232, 242, 250);
    
    if (self.needDismissButton) {
        //** 左关闭按钮 **********************************************************************
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithTitle:@"关闭"
                                                                    style:UIBarButtonItemStyleDone
                                                                   target:self
                                                                   action:@selector(dismissButtonPressed:)];
        self.navigationItem.leftBarButtonItem = leftItem;
        //*************************************************************************************
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
