//
//  MJTestViewController.m
//  MJRefreshExample
//
//  Created by MJ Lee on 14-5-28.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "MJTestViewController.h"

@interface MJTestViewController ()

@end

@implementation MJTestViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"测试控制器";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStyleDone target:self action:@selector(close)];
}

- (void)close
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
