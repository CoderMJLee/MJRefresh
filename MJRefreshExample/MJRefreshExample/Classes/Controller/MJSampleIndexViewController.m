//
//  MJSampleIndexViewController.m
//  快速集成下拉刷新
//
//  Created by mj on 14-1-3.
//  Copyright (c) 2014年 itcast. All rights reserved.
//
/*
 具体用法：查看MJRefresh.h
 */
#import "MJSampleIndexViewController.h"
#import "MJSampleIndex.h"
#import "MJTableViewController.h"
#import "MJCollectionViewController.h"

NSString *const MJSampleIndexCellIdentifier = @"Cell";

@interface MJSampleIndexViewController ()
{
    NSArray *_sampleIndexs;
}
@end

@implementation MJSampleIndexViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"快速集成下拉刷新";
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:nil action:nil];
    
    // 1.注册cell
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:MJSampleIndexCellIdentifier];
    
    // 2.初始化数据
    MJSampleIndex *si1 = [MJSampleIndex sampleIndexWithTitle:@"tableView刷新演示" controllerClass:[MJTableViewController class]];
    MJSampleIndex *si2 = [MJSampleIndex sampleIndexWithTitle:@"collectionView刷新演示" controllerClass:[MJCollectionViewController class]];
    _sampleIndexs = @[si1, si2];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _sampleIndexs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MJSampleIndexCellIdentifier forIndexPath:indexPath];
    
    // 1.取出模型
    MJSampleIndex *si = _sampleIndexs[indexPath.row];
    
    // 2.赋值
    cell.textLabel.text = si.title;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.取出模型
    MJSampleIndex *si = _sampleIndexs[indexPath.row];
    
    // 2.创建控制器
    UIViewController *vc = [[si.controllerClass alloc] init];
    vc.title = si.title;

    // 3.跳转
    [self.navigationController pushViewController:vc animated:YES];
}

@end
