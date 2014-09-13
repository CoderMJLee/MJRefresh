//
//  MJTableViewController.m
//  快速集成下拉刷新
//
//  Created by mj on 14-1-3.
//  Copyright (c) 2014年 itcast. All rights reserved.
//
/*
 具体用法：查看MJRefresh.h
 */
#import "MJTableViewController.h"
#import "MJTestViewController.h"
#import "MJRefresh.h"

NSString *const MJTableViewCellIdentifier = @"Cell";

/**
 *  随机数据
 */
#define MJRandomData [NSString stringWithFormat:@"随机数据---%d", arc4random_uniform(1000000)]

@interface MJTableViewController ()
/**
 *  存放假数据
 */
@property (strong, nonatomic) NSMutableArray *fakeData;
@end

@implementation MJTableViewController
#pragma mark - 初始化
/**
 *  数据的懒加载
 */
- (NSMutableArray *)fakeData
{
    if (!_fakeData) {
        self.fakeData = [NSMutableArray array];
        
        for (int i = 0; i<5; i++) {
            [self.fakeData addObject:MJRandomData];
        }
    }
    return _fakeData;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1.注册cell
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:MJTableViewCellIdentifier];
    
    // 2.集成刷新控件
    [self setupRefresh];
}

/**
 为了保证内部不泄露，在dealloc中释放占用的内存
 */
- (void)dealloc
{
    NSLog(@"MJTableViewController--dealloc---");
}



/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
#warning 自动刷新(一进入程序就下拉刷新)
    [self.tableView headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    self.tableView.headerPullToRefreshText = @"下拉可以刷新了";
    self.tableView.headerReleaseToRefreshText = @"松开马上刷新了";
    self.tableView.headerRefreshingText = @"MJ哥正在帮你刷新中,不客气";
    
    self.tableView.footerPullToRefreshText = @"上拉可以加载更多数据了";
    self.tableView.footerReleaseToRefreshText = @"松开马上加载更多数据了";
    self.tableView.footerRefreshingText = @"MJ哥正在帮你加载中,不客气";
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    // 1.添加假数据
    for (int i = 0; i<5; i++) {
        [self.fakeData insertObject:MJRandomData atIndex:0];
    }
    
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.tableView reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.tableView headerEndRefreshing];
    });
}

- (void)footerRereshing
{
    // 1.添加假数据
    for (int i = 0; i<5; i++) {
        [self.fakeData addObject:MJRandomData];
    }
    
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.tableView reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.tableView footerEndRefreshing];
    });
}

#pragma mark - Table view data source
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 5;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.fakeData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MJTableViewCellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = self.fakeData[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MJTestViewController *test = [[MJTestViewController alloc] init];
    [self.navigationController pushViewController:test animated:YES];
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    return @"test";
//}
@end
