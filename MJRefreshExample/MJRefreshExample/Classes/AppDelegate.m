//  代码地址: https://github.com/CoderMJLee/MJRefresh
//  代码地址: http://code4app.com/ios/%E5%BF%AB%E9%80%9F%E9%9B%86%E6%88%90%E4%B8%8B%E6%8B%89%E4%B8%8A%E6%8B%89%E5%88%B7%E6%96%B0/52326ce26803fabc46000000
//  AppDelegate.m
//  MJRefreshExample
//
//  Created by MJ Lee on 15/3/4.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()
//@property (strong, nonatomic) UIWindow *alert;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    UIWindow *alert = [[UIWindow alloc] init];
//    CGFloat width = 150;
//    CGFloat x = [UIScreen mainScreen].bounds.size.width - width - 10;
//    alert.frame = CGRectMake(x, 0, width, 25);
//    alert.windowLevel = UIWindowLevelAlert;
//    alert.hidden = NO;
//    alert.alpha = 0.5;
//    UISegmentedControl *control = [[UISegmentedControl alloc] initWithItems:@[@"示例1", @"示例2", @"示例3"]];
//    control.tintColor = [UIColor orangeColor];
//    control.frame = alert.bounds;
//    control.selectedSegmentIndex = 0;
//    [control addTarget:self action:@selector(contorlSelect:) forControlEvents:UIControlEventValueChanged];
//    [alert addSubview:control];
//    self.alert = alert;
    return YES;
}

//- (void)contorlSelect:(UISegmentedControl *)control
//{
//    self.window.rootViewController = [self.window.rootViewController.storyboard instantiateViewControllerWithIdentifier:[NSString stringWithFormat:@"%zd", control.selectedSegmentIndex]];
//}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
