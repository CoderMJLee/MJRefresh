//
//  MJWKWebViewController.m
//  MJRefreshExample
//
//  Created by Frank on 2019/10/29.
//  Copyright © 2019 小码哥. All rights reserved.
//

#import "MJWKWebViewController.h"
#import "UIViewController+Example.h"
#import "MJChiBaoZiHeader.h"
#import "MJRefresh.h"

@import WebKit;

@interface MJWKWebViewController ()<WKNavigationDelegate>
@property (strong, nonatomic) WKWebView *webView;

@end

@implementation MJWKWebViewController

#pragma mark - 示例
- (void)example41 {
    __weak WKWebView *webView = self.webView;
    webView.navigationDelegate = self;
    
    __weak UIScrollView *scrollView = self.webView.scrollView;
    
    // 添加下拉刷新控件
    scrollView.mj_header= [MJChiBaoZiHeader headerWithRefreshingBlock:^{
        [webView reload];
    }];
    
    // 如果是上拉刷新，就以此类推
    [scrollView.mj_header beginRefreshing];
}

#pragma mark - webViewDelegate
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [self.webView.scrollView.mj_header endRefreshing];
}

#pragma mark - 其他
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webView = [[WKWebView alloc] initWithFrame:self.view.frame];
    self.webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.webView];
    
    CGSize size = self.view.frame.size;
    
    UILabel *warningLabel = [[UILabel alloc] initWithFrame:CGRectMake(size.width - 210, size.height - 120, 200, 50)];
    warningLabel.text = @"注意，这不是原生界面，是个网页：http://weibo.com/excepptions";
    warningLabel.adjustsFontSizeToFitWidth = YES;
    warningLabel.textColor = UIColor.blackColor;
    warningLabel.backgroundColor = [UIColor.lightGrayColor colorWithAlphaComponent:0.3];
    warningLabel.numberOfLines = 0;
    warningLabel.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    [self.view addSubview:warningLabel];
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(size.width - 210, size.height - 60, 200, 50)];
    [backButton setTitle:@"回到上一页" forState:UIControlStateNormal];
    [backButton setBackgroundColor:UIColor.redColor];
    backButton.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    [self.view addSubview:backButton];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
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
