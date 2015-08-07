//
//  MJRefreshAutoFooter.h
//  MJRefreshExample
//
//  Created by MJ Lee on 15/4/24.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "MJRefreshFooter.h"

@interface MJRefreshAutoFooter : MJRefreshFooter
/** 是否自动刷新(默认为YES) */
@property (assign, nonatomic, getter=isAutomaticallyRefresh) BOOL automaticallyRefresh;

/** 当底部控件出现多少时就自动刷新(默认为1.0，也就是底部控件完全出现时，才会自动刷新) */
@property (assign, nonatomic) CGFloat appearencePercentTriggerAutoRefresh;

/** 自动根据有无数据来显示和隐藏（有数据就显示，没有数据隐藏） */
@property (assign, nonatomic) BOOL automaticallyHidden;
@end
