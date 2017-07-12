//
//  MJExampleWindow.m
//  MJRefreshExample
//
//  Created by MJ Lee on 15/8/17.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "MJExampleWindow.h"
#import "MJTempViewController.h"

@implementation MJExampleWindow

static UIWindow *window_;
+ (void)show
{
    window_ = [[UIWindow alloc] init];
    CGFloat width = 150;
    CGFloat x = [UIScreen mainScreen].bounds.size.width - width - 10;
    window_.frame = CGRectMake(x, 0, width, 25);
    window_.windowLevel = UIWindowLevelAlert;
    window_.hidden = NO;
    window_.alpha = 0.5;
    window_.rootViewController = [[MJTempViewController alloc] init];
    window_.backgroundColor = [UIColor clearColor];

    // 解决 iOS 8 rootViewController.view.frame 为 UIScreen.current.bounds 的问题
    // 本行代码在 MJTempViewController 的 viewWillAppear 之后，viewDidAppear 之前调用，所以比在 viewDidAppear 调用好。
    window_.rootViewController.view.frame = window_.bounds;
}
@end
