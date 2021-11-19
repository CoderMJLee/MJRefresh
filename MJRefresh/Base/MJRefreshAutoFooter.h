//
//  MJRefreshAutoFooter.h
//  MJRefresh
//
//  Created by MJ Lee on 15/4/24.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#if __has_include(<MJRefresh/MJRefreshFooter.h>)
#import <MJRefresh/MJRefreshFooter.h>
#else
#import "MJRefreshFooter.h"
#endif

NS_ASSUME_NONNULL_BEGIN

@interface MJRefreshAutoFooter : MJRefreshFooter
/** 是否自动刷新(默认为YES) */
@property (assign, nonatomic, getter=isAutomaticallyRefresh) BOOL automaticallyRefresh;

/** 当底部控件出现多少时就自动刷新(默认为1.0，也就是底部控件完全出现时，才会自动刷新) */
@property (assign, nonatomic) CGFloat appearencePercentTriggerAutoRefresh MJRefreshDeprecated("请使用triggerAutomaticallyRefreshPercent属性");

/** 当底部控件出现多少时就自动刷新(默认为1.0，也就是底部控件完全出现时，才会自动刷新) */
@property (assign, nonatomic) CGFloat triggerAutomaticallyRefreshPercent;

/** 自动触发次数, 默认为 1, 仅在拖拽 ScrollView 时才生效,
 
 如果为 -1, 则为无限触发
 */
@property (nonatomic) NSInteger autoTriggerTimes;
@end

NS_ASSUME_NONNULL_END
