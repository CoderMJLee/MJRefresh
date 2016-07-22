//
//  MJWebViewViewController.m
//  MJRefreshExample
//
//  Created by MJ Lee on 15/3/12.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "MJWebViewViewController.h"
#import "UIViewController+Example.h"
#import "MJRefresh.h"

@interface MJWebViewViewController () <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end

@implementation MJWebViewViewController
#pragma mark - 示例
- (void)example31
{
    __weak UIWebView *webView = self.webView;
    webView.delegate = self;
    
    __weak UIScrollView *scrollView = self.webView.scrollView;
    
    // 添加下拉刷新控件
    scrollView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [webView reload];
    }];
    
    // 如果是上拉刷新，就以此类推
}

#pragma mark - webViewDelegate
- (void)webViewDidFinishLoad:(nonnull UIWebView *)webView
{
    [self.webView.scrollView.mj_header endRefreshing];
}

#pragma mark - 其他
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 加载页面
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://weibo.com/exceptions"]]];
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [self performSelector:NSSelectorFromString(self.method) withObject:nil];
#pragma clang diagnostic pop
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    [self setNeedsStatusBarAppearanceUpdate];
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
