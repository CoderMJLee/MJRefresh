//
//  MJExampleViewController.m
//  MJRefreshExample
//
//  Created by MJ Lee on 15/3/5.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "MJExampleViewController.h"
#import "MJTableViewController.h"
#import "MJCollectionViewController.h"
#import "MJExample.h"

static NSString *const MJExample00 = @"UITableView + 下拉刷新";
static NSString *const MJExample10 = @"UITableView + 上拉刷新";
static NSString *const MJExample20 = @"UICollectionView";

@interface MJExampleViewController()
@property (strong, nonatomic) NSArray *examples;
@end

@implementation MJExampleViewController

- (NSArray *)examples
{
    if (!_examples) {
        MJExample *exam0 = [[MJExample alloc] init];
        exam0.header = MJExample00;
        exam0.titles = @[@"传统", @"动画图片", @"隐藏时间", @"隐藏状态和时间01", @"隐藏状态和时间02", @"自定义文字"];
        exam0.methods = @[@"example01", @"example02", @"example03", @"example04", @"example05", @"example06"];
        
        MJExample *exam1 = [[MJExample alloc] init];
        exam1.header = MJExample10;
        exam1.titles = @[@"传统(尝试向上拽)", @"动画图片", @"隐藏状态01", @"隐藏状态02", @"全部加载完毕", @"禁止自动加载", @"自定义文字", @"加载后隐藏"];
        exam1.methods = @[@"example11", @"example12", @"example13", @"example14", @"example15", @"example16", @"example17", @"example18"];
        
        MJExample *exam2 = [[MJExample alloc] init];
        exam2.header = MJExample20;
        exam2.titles = @[@"上下拉刷新"];
        exam2.methods = @[@"example21"];
        
        self.examples = @[exam0, exam1, exam2];
    }
    return _examples;
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
    
    if ([exam.header isEqualToString:MJExample20]) { // UICollectionView
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ - %@", [MJCollectionViewController class], exam.methods[indexPath.row]];
    } else { // UITableView
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ - %@", [MJTableViewController class], exam.methods[indexPath.row]];
    }
    
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
    if ([exam.header isEqualToString:MJExample20]) { // UICollectionView
        MJCollectionViewController *collectVc = [[MJCollectionViewController alloc] init];
        collectVc.title = exam.titles[indexPath.row];
        collectVc.method = exam.methods[indexPath.row];
        [self.navigationController pushViewController:collectVc animated:YES];
    } else { // UITableView
        MJTableViewController *tableVc = [[MJTableViewController alloc] init];
        tableVc.title = exam.titles[indexPath.row];
        tableVc.method = exam.methods[indexPath.row];
        [self.navigationController pushViewController:tableVc animated:YES];
    }
}

@end
