//
//  MJSingleViewController.m
//  MJRefreshExample
//
//  Created by MJ Lee on 15/6/13.
//  Copyright © 2015年 小码哥. All rights reserved.
//

#import "MJSingleViewController.h"
#import "MJTestViewController.h"
#import "MJRefresh.h"

@interface MJSingleViewController ()
@property (assign, nonatomic) int count;
@end

@implementation MJSingleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.count = 10;
    
    __weak typeof(self) weakSelf = self;
    __weak UITableView *tableView = self.tableView;
    
    tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            weakSelf.count += 2;
            [tableView reloadData];
            [tableView.header endRefreshing];
        });
    }];
    tableView.header.autoChangeAlpha = YES;
    
    tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            weakSelf.count += 5;
            [tableView reloadData];
            [tableView.footer endRefreshing];
        });
    }];
    tableView.footer.autoChangeAlpha = YES;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    if (indexPath.row % 2 && self.navigationController) {
        cell.textLabel.text = @"push";
    } else {
        cell.textLabel.text = @"modal";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MJTestViewController *test = [[MJTestViewController alloc] init];
    if (indexPath.row % 2 && self.navigationController) {
        test.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:test animated:YES];
    } else {
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:test];
        [self presentViewController:nav animated:YES completion:nil];
    }
}
@end
