//  代码地址: https://github.com/CoderMJLee/MJRefresh
//  MJNavigationController.m
//  MJRefreshExample
//
//  Created by MJ Lee on 15/3/5.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "MJNavigationController.h"

@implementation MJNavigationController

#pragma mark 一个类只会调用一次
+ (void)initialize
{
    // 1.取出设置主题的对象
    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[MJNavigationController.class]];
    
    // 2.设置导航栏的背景图片
    [navBar setBackgroundImage:[UIImage imageNamed:@"NavBar64"] forBarMetrics:UIBarMetricsDefault];
    
    // 3.标题
    [navBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
}
@end
