//
//  MJTempViewController.m
//  MJRefreshExample
//
//  Created by MJ Lee on 15/9/22.
//  Copyright © 2015年 小码哥. All rights reserved.
//

#import "MJTempViewController.h"

@interface MJTempViewController ()

@end

@implementation MJTempViewController
#pragma mark - 单例
static id instance_;

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance_ = [[self alloc] init];
    });
    return instance_;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance_ = [super allocWithZone:zone];
    });
    return instance_;
}

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.statusBarStyle = UIStatusBarStyleLightContent;
    
    self.view.backgroundColor = [UIColor clearColor];
    
    UISegmentedControl *control = [[UISegmentedControl alloc] initWithItems:@[@"示例1", @"示例2", @"示例3"]];
    control.tintColor = [UIColor orangeColor];
    control.frame = self.view.bounds;
    control.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    control.selectedSegmentIndex = 0;
    [control addTarget:self action:@selector(contorlSelect:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:control];
}

- (void)contorlSelect:(UISegmentedControl *)control
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    keyWindow.rootViewController = [keyWindow.rootViewController.storyboard instantiateViewControllerWithIdentifier:[NSString stringWithFormat:@"%zd", control.selectedSegmentIndex]];
    
    if (control.selectedSegmentIndex == 0) {
        self.statusBarStyle = UIStatusBarStyleLightContent;
        self.statusBarHidden = NO;
    } else if (control.selectedSegmentIndex == 1) {
        self.statusBarHidden = YES;
    } else if (control.selectedSegmentIndex == 2) {
        self.statusBarStyle = UIStatusBarStyleDefault;
        self.statusBarHidden = NO;
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return self.statusBarStyle;
}

- (BOOL)prefersStatusBarHidden
{
    return self.statusBarHidden;
}

- (void)setStatusBarHidden:(BOOL)statusBarHidden
{
    _statusBarHidden = statusBarHidden;
    
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)setStatusBarStyle:(UIStatusBarStyle)statusBarStyle
{
    _statusBarStyle = statusBarStyle;
    
    [self setNeedsStatusBarAppearanceUpdate];
}

@end
