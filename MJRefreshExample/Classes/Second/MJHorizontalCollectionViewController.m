//  代码地址: https://github.com/CoderMJLee/MJRefresh
//  MJHorizontalCollectionViewController.m
//  MJRefreshExample
//
//  Created by MJ Lee on 15/3/6.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "MJHorizontalCollectionViewController.h"
#import "MJTestViewController.h"
#import "UIViewController+Example.h"
#import "MJRefresh.h"

/**
 * 随机色
 */
#define MJRandomColor [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1]

@interface MJHorizontalCollectionViewController()
/** 存放假数据 */
@property (strong, nonatomic) NSMutableArray *colors;
@end

@implementation MJHorizontalCollectionViewController
#pragma mark - 示例
#pragma mark UICollectionView 左拉刷新

- (void)example42 {
    __weak __typeof(self) weakSelf = self;
    
    // 左拉刷新
    self.collectionView.mj_trailer = [MJRefreshNormalTrailer trailerWithRefreshingBlock:^{
        MJTestViewController *test = [[MJTestViewController alloc] init];
        [weakSelf.navigationController pushViewController:test animated:YES];
        [weakSelf.collectionView.mj_trailer endRefreshing];
    }];
}

#pragma mark - 数据相关
- (NSMutableArray *)colors {
    if (!_colors) {
        self.colors = [NSMutableArray array];
        for (int i = 0; i < 5; i++) {
            [self.colors addObject:MJRandomColor];
        }
    }
    return _colors;
}

#pragma mark - 其他

/**
 *  初始化
 */
- (instancetype)init {
    // UICollectionViewFlowLayout的初始化（与刷新控件无关）
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(UIScreen.mainScreen.bounds.size.width, 200);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    return [self initWithCollectionViewLayout:layout];
}

static NSString *const MJCollectionViewCellIdentifier = @"color";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.collectionView.frame = CGRectMake(0, 150, UIScreen.mainScreen.bounds.size.width, 200);
    self.collectionView.pagingEnabled = YES;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    MJPerformSelectorLeakWarning([self performSelector:NSSelectorFromString(self.method) withObject:nil];);
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:MJCollectionViewCellIdentifier];
}

#pragma mark - collection数据源代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.colors.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MJCollectionViewCellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = self.colors[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    MJTestViewController *test = [[MJTestViewController alloc] init];
    if (indexPath.row % 2) {
        [self.navigationController pushViewController:test animated:YES];
    } else {
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:test];
        [self presentViewController:nav animated:YES completion:nil];
    }
}
@end
