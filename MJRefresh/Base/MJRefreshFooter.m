//  代码地址: https://github.com/CoderMJLee/MJRefresh
//  MJRefreshFooter.m
//  MJRefresh
//
//  Created by MJ Lee on 15/3/5.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "MJRefreshFooter.h"
#import "UIScrollView+MJRefresh.h"
#import "UIView+MJExtension.h"

@interface MJRefreshFooter()

@end

@implementation MJRefreshFooter
#pragma mark - 构造方法
+ (instancetype)footerWithRefreshingBlock:(MJRefreshComponentAction)refreshingBlock
{
    MJRefreshFooter *cmp = [[self alloc] init];
    cmp.refreshingBlock = refreshingBlock;
    return cmp;
}
+ (instancetype)footerWithRefreshingTarget:(id)target refreshingAction:(SEL)action
{
    MJRefreshFooter *cmp = [[self alloc] init];
    [cmp setRefreshingTarget:target refreshingAction:action];
    return cmp;
}

#pragma mark - 重写父类的方法
- (void)prepare
{
    [super prepare];
    
    // 设置自己的高度
    self.mj_h = MJRefreshFooterHeight;
    
    // 默认不会自动隐藏
//    self.automaticallyHidden = NO;
}

#pragma mark . 链式语法部分 .

- (instancetype)linkTo:(UIScrollView *)scrollView {
    scrollView.mj_footer = self;
    return self;
}

#pragma mark - 公共方法
- (void)endRefreshingWithNoMoreData
{
    MJRefreshDispatchAsyncOnMainQueue(self.state = MJRefreshStateNoMoreData;)
}

- (void)noticeNoMoreData
{
    [self endRefreshingWithNoMoreData];
}

- (void)resetNoMoreData
{
    MJRefreshDispatchAsyncOnMainQueue(self.state = MJRefreshStateIdle;)
}

- (void)setAutomaticallyHidden:(BOOL)automaticallyHidden
{
    _automaticallyHidden = automaticallyHidden;
}
@end
