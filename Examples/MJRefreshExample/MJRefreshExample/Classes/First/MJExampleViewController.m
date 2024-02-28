//  代码地址: https://github.com/CoderMJLee/MJRefresh
//  MJExampleViewController.m
//  MJRefreshExample
//
//  Created by MJ Lee on 15/3/5.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "MJExampleViewController.h"
#import "MJTableViewController.h"
#import "MJWebViewViewController.h"
#import "MJCollectionViewController.h"
#import "MJExample.h"
#import "UIViewController+Example.h"
#import "MJHorizontalCollectionViewController.h"
#import "MJRefreshExample-Swift.h"

@import MJRefresh;

static NSString *const MJExample00 = @"UITableView + 下拉刷新";
static NSString *const MJExample10 = @"UITableView + 上拉刷新";
static NSString *const MJExample20 = @"UICollectionView";
static NSString *const MJExample30 = @"UIWebView";
static NSString *const MJExample40 = @"WKWebView";

@interface MJExampleViewController()
@property (strong, nonatomic) NSArray *examples;
@end

@implementation MJExampleViewController

- (NSArray *)examples
{
    if (!_examples) {
        MJExample *exam0 = [[MJExample alloc] init];
        exam0.header = MJExample00;
        exam0.vcClasses = @[[MJTableViewController class]];
        exam0.titles = @[@"默认", @"动画图片", @"隐藏时间", @"隐藏状态和时间", @"自定义文字", @"自定义刷新控件"];
        exam0.methods = @[@"example01", @"example02", @"example03", @"example04", @"example05", @"example06"];
        
        MJExample *exam1 = [[MJExample alloc] init];
        exam1.header = MJExample10;
        exam1.vcClasses = @[[MJTableViewController class]];
        exam1.titles = @[@"默认", @"动画图片", @"隐藏刷新状态的文字", @"全部加载完毕", @"禁止自动加载", @"自定义文字", @"加载后隐藏", @"自动回弹的上拉01", @"自动回弹的上拉02", @"自定义刷新控件(自动刷新)", @"自定义刷新控件(自动回弹)"];
        exam1.methods = @[@"example11", @"example12", @"example13", @"example14", @"example15", @"example16", @"example17", @"example18", @"example19", @"example20", @"example21"];
        
        MJExample *exam2 = [[MJExample alloc] init];
        exam2.header = MJExample20;
        exam2.vcClasses = @[MJCollectionViewController.class, MJPinHeaderCollectionViewController.class, MJHorizontalCollectionViewController.class];
        exam2.titles = @[@"上下拉刷新", @"上下拉刷新-PinHeader", @"左拉刷新"];
        exam2.methods = @[@"example31", @"example31", @"example42"];
        
        MJExample *exam3 = [[MJExample alloc] init];
        exam3.header = MJExample30;
        exam3.vcClasses = @[[MJWebViewViewController class]];
        exam3.titles = @[@"下拉刷新"];
        exam3.methods = @[@"example40"];
        
        MJExample *exam4 = [[MJExample alloc] init];
        exam4.header = MJExample40;
        exam4.vcClasses = @[[MJWKWebViewController class]];
        exam4.titles = @[@"下拉刷新"];
        exam4.methods = @[@"example41"];
        
        self.examples = @[exam0, exam1, exam2, exam3, exam4];
    }
    return _examples;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    __unsafe_unretained UITableView *tableView = self.tableView;
    
    // 下拉刷新
    tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 结束刷新
            [tableView.mj_header endRefreshing];
        });
    }];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    tableView.mj_header.automaticallyChangeAlpha = YES;
    
    // 上拉刷新
    tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 结束刷新
            [tableView.mj_footer endRefreshing];
        });
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.examples.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    MJExample *exam = self.examples[section];
    return exam.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"example";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    MJExample *exam = self.examples[indexPath.section];
    cell.textLabel.text = exam.titles[indexPath.row];
    
    NSInteger classRow = indexPath.row;
    if (classRow > exam.vcClasses.count - 1) {
        classRow = exam.vcClasses.count - 1;
    }
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ - %@", exam.vcClasses[classRow], exam.methods[indexPath.row]];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    MJExample *exam = self.examples[section];
    return exam.header;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MJExample *exam = self.examples[indexPath.section];
    NSInteger classRow = indexPath.row;
    if (classRow > exam.vcClasses.count - 1) {
        classRow = exam.vcClasses.count - 1;
    }
    UIViewController *vc = [[exam.vcClasses[classRow] alloc] init];
    vc.title = exam.titles[indexPath.row];
    [vc setValue:exam.methods[indexPath.row] forKeyPath:@"method"];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
