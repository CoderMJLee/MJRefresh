//  代码地址: https://github.com/CoderMJLee/MJRefresh
//  代码地址: http://code4app.com/ios/%E5%BF%AB%E9%80%9F%E9%9B%86%E6%88%90%E4%B8%8B%E6%8B%89%E4%B8%8A%E6%8B%89%E5%88%B7%E6%96%B0/52326ce26803fabc46000000
//  MJRefreshFooter.m
//  MJRefreshExample
//
//  Created by MJ Lee on 15/3/5.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "MJRefreshFooter.h"

@interface MJRefreshFooter()

@end

@implementation MJRefreshFooter

#pragma mark - 构造方法
/** 创建footer */
+ (instancetype)mj_footerWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock
{
    MJRefreshFooter *cmp = [[self alloc] init];
    cmp.refreshingBlock = refreshingBlock;
    return cmp;
}

/** 创建footer */
+ (instancetype)mj_footerWithRefreshingTarget:(id)target refreshingAction:(SEL)action
{
    MJRefreshFooter *cmp = [[self alloc] init];
    [cmp mj_setRefreshingTarget:target refreshingAction:action];
    return cmp;
}

#pragma mark - 公共方法
/** 提示没有更多的数据 */
- (void)mj_endRefreshingWithNoMoreData
{
    
    self.state = MJRefreshStateNoMoreData;
}

/** 重置没有更多的数据（消除没有更多数据的状态） */
- (void)mj_resetNoMoreData
{
    self.state = MJRefreshStateIdle;
}



#pragma mark - 重写父类的方法
- (void)prepare
{
    [super prepare];
    
    // 设置自己的高度
    self.mj_h = MJRefreshFooterHeight;
    
    // 默认不会自动隐藏
    self.automaticallyHidden = NO;
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    if (newSuperview) {
        // 监听scrollView数据的变化
        if ([self.scrollView isKindOfClass:[UITableView class]] || [self.scrollView isKindOfClass:[UICollectionView class]]) {
            [self.scrollView setMj_reloadDataBlock:^(NSInteger totalDataCount) {
                if (self.isAutomaticallyHidden) {
                    self.hidden = (totalDataCount == 0);
                }
            }];
        }
    }
}



#pragma mark - 过期方法
+ (instancetype)footerWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock
{
    return [self mj_footerWithRefreshingBlock:refreshingBlock];
}


+ (instancetype)footerWithRefreshingTarget:(id)target refreshingAction:(SEL)action
{
    return [self mj_footerWithRefreshingTarget:target refreshingAction:action];
    
}

- (void)endRefreshingWithNoMoreData
{
    [self mj_endRefreshingWithNoMoreData];
}

- (void)noticeNoMoreData
{
    [self mj_endRefreshingWithNoMoreData];
}

- (void)resetNoMoreData
{
    [self mj_resetNoMoreData];
    
}
@end
