//  代码地址: https://github.com/CoderMJLee/MJRefresh
//  代码地址: http://code4app.com/ios/%E5%BF%AB%E9%80%9F%E9%9B%86%E6%88%90%E4%B8%8B%E6%8B%89%E4%B8%8A%E6%8B%89%E5%88%B7%E6%96%B0/52326ce26803fabc46000000
//  MJRefreshFooter.h
//  MJRefreshExample
//
//  Created by MJ Lee on 15/3/5.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "MJRefreshComponent.h"

typedef enum {
    MJRefreshFooterStateIdle = 1, // 普通闲置状态
    MJRefreshFooterStateRefreshing, // 正在刷新中的状态
    MJRefreshFooterStateNoMoreData // 所有数据加载完毕，没有更多的数据了
} MJRefreshFooterState;

@interface MJRefreshFooter : MJRefreshComponent
/** 提示没有更多的数据 */
- (void)noticeNoMoreData;

/** 刷新控件的状态(交给子类重写) */
@property (assign, nonatomic) MJRefreshFooterState state;

/** 是否隐藏状态标签 */
@property (assign, nonatomic, getter=isStateHidden) BOOL stateHidden;

/**
 * 设置state状态下的状态文字内容title
 */
- (void)setTitle:(NSString *)title forState:(MJRefreshFooterState)state;

/** 是否自动刷新(默认为YES) */
@property (assign, nonatomic, getter=isAutomaticallyRefresh) BOOL automaticallyRefresh;

/** 当底部控件出现多少时就自动刷新(默认为1.0，也就是底部控件完全出现时，才会自动刷新) */
@property (assign, nonatomic) CGFloat appearencePercentTriggerAutoRefresh;
@end
