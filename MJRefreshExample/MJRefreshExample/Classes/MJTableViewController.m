//  代码地址: https://github.com/CoderMJLee/MJRefresh
//  代码地址: http://code4app.com/ios/%E5%BF%AB%E9%80%9F%E9%9B%86%E6%88%90%E4%B8%8B%E6%8B%89%E4%B8%8A%E6%8B%89%E5%88%B7%E6%96%B0/52326ce26803fabc46000000
//  MJTableViewController.m
//  MJRefreshExample
//
//  Created by MJ Lee on 15/3/4.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "MJTableViewController.h"
#import "UIView+MJExtension.h"
#import "MJTestViewController.h"
#import "UIViewController+Example.h"
#import "MJRefresh.h"

static const CGFloat MJDuration = 2.0;
/**
 * 随机数据
 */
#define MJRandomData [NSString stringWithFormat:@"随机数据---%d", arc4random_uniform(1000000)]

@interface MJTableViewController()
/** 用来显示的假数据 */
@property (strong, nonatomic) NSMutableArray *data;
@end

@implementation MJTableViewController
#pragma mark - 示例代码
- (MJRefreshLegendHeader *)legendHeader
{
    __weak typeof(self) weakSelf = self;
    
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    MJRefreshLegendHeader *header = [MJRefreshLegendHeader legendHeaderWithRefreshingBlock:^{
        [weakSelf loadNewData];
    }];
    
    return header;
}

/**
 * UITableView + 下拉刷新 传统
 */
- (void)example01
{
    // 添加传统的下拉刷新
    self.tableView.header = [self legendHeader];
    
    // 马上进入刷新状态
    [self.tableView.header beginRefreshing];
    
    /**
     也可以这样使用
     [self.tableView.legendHeader beginRefreshing];
     
     此时self.tableView.header == self.tableView.legendHeader
     */
}

- (MJRefreshGifHeader *)gifHeader1
{
    __weak typeof(self) weakSelf = self;
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    MJRefreshGifHeader *header = [MJRefreshGifHeader gifHeaderWithRefreshingBlock:^{
        [weakSelf loadNewData];
    }];
    
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=60; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_anim__000%zd", i]];
        [idleImages addObject:image];
    }
    [header setImages:idleImages forState:MJRefreshHeaderStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
        [refreshingImages addObject:image];
    }
    [header setImages:refreshingImages forState:MJRefreshHeaderStatePulling];
    
    // 设置正在刷新状态的动画图片
    [header setImages:refreshingImages forState:MJRefreshHeaderStateRefreshing];
    // 在这个例子中，即将刷新 和 正在刷新 用的是一样的动画图片
    
    return header;
}

/**
 * UITableView + 下拉刷新 动画图片
 */
- (void)example02
{
    // 添加动画图片的下拉刷新
    self.tableView.header = [self gifHeader1];
    
    // 马上进入刷新状态
    [self.tableView.header beginRefreshing];
    
    // 此时self.tableView.header == self.tableView.gifHeader
}

/**
 * UITableView + 下拉刷新 隐藏时间
 */
- (void)example03
{
    // 添加传统的下拉刷新
    self.tableView.header = [self legendHeader];
    
    // 隐藏时间
    self.tableView.header.updatedTimeHidden = YES;
    
    // 马上进入刷新状态
    [self.tableView.header beginRefreshing];
    
    // 此时self.tableView.header == self.tableView.legendHeader
}

- (MJRefreshGifHeader *)gifHeader2
{
    __weak typeof(self) weakSelf = self;
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    MJRefreshGifHeader *header = [MJRefreshGifHeader gifHeaderWithRefreshingBlock:^{
        [weakSelf loadNewData];
    }];
    
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 0; i<=72; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"PullToRefresh_%03zd", i]];
        [idleImages addObject:image];
    }
    [header setImages:idleImages forState:MJRefreshHeaderStateIdle];
    
    // 设置正在刷新状态的动画图片
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 73; i<=140; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"PullToRefresh_%03zd", i]];
        [refreshingImages addObject:image];
    }
    [header setImages:refreshingImages forState:MJRefreshHeaderStateRefreshing];
    
    // 在这个例子中，即将刷新时没有动画图片
    return header;
}

/**
 * UITableView + 下拉刷新 隐藏状态和时间01
 */
- (void)example04
{
    // 添加动画图片的下拉刷新
    self.tableView.header = [self gifHeader2];
    
    // 隐藏时间
    self.tableView.header.updatedTimeHidden = YES;
    
    // 隐藏状态
    self.tableView.header.stateHidden = YES;
    
    // 马上进入刷新状态
    [self.tableView.header beginRefreshing];
    
    // 此时self.tableView.header == self.tableView.gifHeader
    
    // 由于动画图片是黑色的，所以故意设置tableView底色为黑色
    self.tableView.backgroundColor = [UIColor blackColor];
}

/**
 * UITableView + 下拉刷新 隐藏状态和时间02
 */
- (void)example05
{
    // 添加动画图片的下拉刷新
    self.tableView.header = [self gifHeader1];
    
    // 隐藏时间
    self.tableView.header.updatedTimeHidden = YES;
    
    // 隐藏状态
    self.tableView.header.stateHidden = YES;
    
    // 马上进入刷新状态
    [self.tableView.header beginRefreshing];
    
    // 此时self.tableView.header == self.tableView.gifHeader
}

/**
 * UITableView + 下拉刷新 自定义文字
 */
- (void)example06
{
    // 添加传统的下拉刷新
    self.tableView.header = [self legendHeader];
    
    // 设置文字
    [self.tableView.header setTitle:@"Pull down to refresh" forState:MJRefreshHeaderStateIdle];
    [self.tableView.header setTitle:@"Release to refresh" forState:MJRefreshHeaderStatePulling];
    [self.tableView.header setTitle:@"Loading ..." forState:MJRefreshHeaderStateRefreshing];
    
    // 设置字体
    self.tableView.header.font = [UIFont systemFontOfSize:15];
    
    // 设置颜色
    self.tableView.header.textColor = [UIColor redColor];
    
    // 马上进入刷新状态
    [self.tableView.header beginRefreshing];
    
    // 此时self.tableView.header == self.tableView.legendHeader
}

- (MJRefreshLegendFooter *)legendFooter
{
    __weak typeof(self) weakSelf = self;
    
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    MJRefreshLegendFooter *footer = [MJRefreshLegendFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
    
    return footer;
}

/**
 * UITableView + 上拉刷新 传统
 */
- (void)example11
{
    // 添加传统的上拉刷新
    self.tableView.footer = [self legendFooter];
}

- (MJRefreshGifFooter *)gifFooter1
{
    __weak typeof(self) weakSelf = self;

    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    MJRefreshGifFooter *footer = [MJRefreshGifFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
    
    // 设置正在刷新状态的动画图片
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
        [refreshingImages addObject:image];
    }
    footer.refreshingImages = refreshingImages;
    
    return footer;
}

/**
 * UITableView + 上拉刷新 动画图片
 */
- (void)example12
{
    // 添加动画图片的上拉刷新
    self.tableView.footer = [self gifFooter1];
    
    // 此时self.tableView.footer == self.tableView.gifFooter
}

- (MJRefreshGifFooter *)gifFooter2
{
    __weak typeof(self) weakSelf = self;
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    MJRefreshGifFooter *footer = [MJRefreshGifFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
    
    // 设置正在刷新状态的动画图片
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 73; i<=140; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"PullToRefresh_%03zd", i]];
        [refreshingImages addObject:image];
    }
    footer.refreshingImages = refreshingImages;
    
    return footer;
}

/**
 * UITableView + 上拉刷新 隐藏状态01
 */
- (void)example13
{
    // 添加动画图片的上拉刷新
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
//    [self.tableView addGifFooterWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.tableView.footer = [self gifFooter2];
    
    // 当上拉刷新控件出现50%时（出现一半），就会自动刷新。这个值默认是1.0（也就是上拉刷新100%出现时，才会自动刷新）
//    self.tableView.footer.appearencePercentTriggerAutoRefresh = 0.5;
    
    // 隐藏状态
    self.tableView.footer.stateHidden = YES;
    
    // 此时self.tableView.footer == self.tableView.gifFooter
    
    // 由于动画图片是黑色的，所以故意设置tableView底色为黑色
    self.tableView.backgroundColor = [UIColor blackColor];
}

/**
 * UITableView + 上拉刷新 隐藏状态02
 */
- (void)example14
{
    // 添加动画图片的上拉刷新
    self.tableView.footer = [self gifFooter1];
    
    // 隐藏状态
    self.tableView.footer.stateHidden = YES;
    
    // 此时self.tableView.footer == self.tableView.gifFooter
}

/**
 * UITableView + 上拉刷新 全部加载完毕
 */
- (void)example15
{
    // 添加传统的上拉刷新
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadLastData方法）
    __weak typeof(self) weakSelf = self;
    self.tableView.footer = [MJRefreshLegendFooter footerWithRefreshingBlock:^{
        [weakSelf loadLastData];
    }];
    
    // 其他
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"恢复数据加载" style:UIBarButtonItemStyleDone target:self action:@selector(recover)];
}

- (void)recover
{
    [self.tableView.footer setRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
//    [self.tableView.footer beginRefreshing];
    self.tableView.footer.state = MJRefreshFooterStateIdle;
    
    // 此时self.tableView.footer == self.tableView.legendFooter
}

/**
 * UITableView + 上拉刷新 禁止自动加载
 */
- (void)example16
{
    // 添加传统的上拉刷新
    self.tableView.footer = [self legendFooter];
    
    // 禁止自动加载
    self.tableView.footer.automaticallyRefresh = NO;
    
    // 此时self.tableView.footer == self.tableView.legendFooter
}

/**
 * UITableView + 上拉刷新 自定义文字
 */
- (void)example17
{
    // 添加传统的上拉刷新
    self.tableView.footer = [self legendFooter];
    
    // 设置文字
    [self.tableView.footer setTitle:@"Click or drag up to refresh" forState:MJRefreshFooterStateIdle];
    [self.tableView.footer setTitle:@"Loading more ..." forState:MJRefreshFooterStateRefreshing];
    [self.tableView.footer setTitle:@"No more data" forState:MJRefreshFooterStateNoMoreData];
    
    // 设置字体
    self.tableView.footer.font = [UIFont systemFontOfSize:17];
    
    // 设置颜色
    self.tableView.footer.textColor = [UIColor blueColor];
    
    // 此时self.tableView.footer == self.tableView.legendFooter
}

/**
 * UITableView + 上拉刷新 加载后隐藏
 */
- (void)example18
{
    // 添加传统的上拉刷新
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadOnceData方法）
    [self.tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(loadOnceData)];
}

#pragma mark - 数据处理相关
/**
 * 下拉刷新数据
 */
- (void)loadNewData
{
    // 1.添加假数据
    for (int i = 0; i<5; i++) {
        [self.data insertObject:MJRandomData atIndex:0];
    }
    
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MJDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.tableView reloadData];
        
        // 拿到当前的下拉刷新控件，结束刷新状态
        [self.tableView.header endRefreshing];
    });
}

/**
 * 上拉加载更多数据
 */
- (void)loadMoreData
{
    // 1.添加假数据
    for (int i = 0; i<5; i++) {
        [self.data addObject:MJRandomData];
    }
    
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MJDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.tableView reloadData];
        
        // 拿到当前的上拉刷新控件，结束刷新状态
        [self.tableView.footer endRefreshing];
    });
}

/**
 * 加载最后一份数据
 */
- (void)loadLastData
{
    // 1.添加假数据
    for (int i = 0; i<5; i++) {
        [self.data addObject:MJRandomData];
    }
    
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MJDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.tableView reloadData];
        
        // 拿到当前的上拉刷新控件，变为没有更多数据的状态
        [self.tableView.footer noticeNoMoreData];
    });
}

/**
 * 只加载一次数据
 */
- (void)loadOnceData
{
    // 1.添加假数据
    for (int i = 0; i<25; i++) {
        [self.data addObject:MJRandomData];
    }
    
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MJDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.tableView reloadData];
        
        // 隐藏当前的上拉刷新控件
        self.tableView.footer.hidden = YES;
    });
}

- (NSMutableArray *)data
{
    if (!_data) {
        self.data = [NSMutableArray array];
    }
    return _data;
}

#pragma mark - 其他
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self performSelector:NSSelectorFromString(self.method) withObject:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.textLabel.text = self.data[indexPath.row];;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MJTestViewController *test = [[MJTestViewController alloc] init];
    if (indexPath.row % 2) {
        [self.navigationController pushViewController:test animated:YES];
    } else {
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:test];
        [self presentViewController:nav animated:YES completion:nil];
    }
}

@end
