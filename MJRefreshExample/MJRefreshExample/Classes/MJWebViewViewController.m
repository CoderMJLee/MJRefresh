//
//  MJWebViewViewController.m
//  MJRefreshExample
//
//  Created by MJ Lee on 15/3/12.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "MJWebViewViewController.h"
#import "UIViewController+Example.h"
#import "MJRefresh.h"

@interface MJWebViewViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end

@implementation MJWebViewViewController
#pragma mark - 示例
- (void)example31
{
    __weak UIScrollView *scrollView = self.webView.scrollView;
    
    // 添加下拉刷新控件
    [scrollView addLegendHeaderWithRefreshingBlock:^{
        MJLog(@"进入下拉刷新");
        
        // 模仿2秒后刷新成功
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 结束刷新
            [scrollView.header endRefreshing];
            MJLog(@"结束刷新");
        });
    }];
    
    // 如果是上拉刷新，就以此类推
}

#pragma mark - 其他
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 加载页面
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://weibo.com/exceptions"]]];
    
    [self performSelector:NSSelectorFromString(self.method) withObject:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (IBAction)back {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
