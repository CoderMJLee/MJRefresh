//  代码地址: https://github.com/CoderMJLee/MJRefresh
//  AppDelegate.m
//  MJRefreshExample
//
//  Created by MJ Lee on 15/3/4.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "AppDelegate.h"
#import "MJExampleWindow.h"

@interface AppDelegate ()
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self setupNavigationBarAppearance];
    
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [MJExampleWindow show];
    });
}

- (void)setupNavigationBarAppearance {
    // 1.取出设置主题的对象
    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[UINavigationController.class]];
    
    // 2.设置导航栏的背景图片
    UIImage *backgroundImage = [UIImage imageNamed:@"NavBar64"];
    NSDictionary *titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    if (@available(iOS 13.0, *)) {
        UINavigationBarAppearance *appearance = [UINavigationBarAppearance new];
        appearance.backgroundImage = backgroundImage;
        appearance.backgroundImageContentMode = UIViewContentModeScaleToFill;
        appearance.titleTextAttributes = titleTextAttributes;
        
        navBar.scrollEdgeAppearance = appearance;
        navBar.standardAppearance = appearance;
    } else {
        [[UINavigationBar appearance] setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
        // 3.标题
        [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    }
}

@end
