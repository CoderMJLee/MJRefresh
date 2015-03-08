//  代码地址: https://github.com/CoderMJLee/MJRefresh
//  代码地址: http://code4app.com/ios/%E5%BF%AB%E9%80%9F%E9%9B%86%E6%88%90%E4%B8%8B%E6%8B%89%E4%B8%8A%E6%8B%89%E5%88%B7%E6%96%B0/52326ce26803fabc46000000
//  MJRefreshHeader.h
//  MJRefreshExample
//
//  Created by MJ Lee on 15/3/4.
//  Copyright (c) 2015年 itcast. All rights reserved.
//  下拉刷新控件:负责监控用户下拉的状态

#import "MJRefreshComponent.h"

// 下拉刷新控件的状态
typedef enum {
    /** 普通闲置状态 */
    MJRefreshHeaderStateIdle = 1,
    /** 松开就可以进行刷新的状态 */
    MJRefreshHeaderStatePulling,
    /** 正在刷新中的状态 */
    MJRefreshHeaderStateRefreshing,
} MJRefreshHeaderState;

@interface MJRefreshHeader : MJRefreshComponent
/** 利用这个key来保存上次的刷新时间（不同界面的刷新控件应该用不同的dateKey，以区分不同界面的刷新时间） */
@property (copy, nonatomic) NSString *dateKey;

/** 利用这个block来决定显示的更新时间 */
@property (copy, nonatomic) NSString *(^updatedTimeTitle)(NSDate *updatedTime);

/**
 * 设置state状态下的状态文字内容title(别直接拿stateLabel修改文字)
 */
- (void)setTitle:(NSString *)title forState:(MJRefreshHeaderState)state;
/** 刷新控件的状态 */
@property (assign, nonatomic) MJRefreshHeaderState state;

#pragma mark - 文字控件的可见性处理
/** 是否隐藏状态标签 */
@property (assign, nonatomic, getter=isStateHidden) BOOL stateHidden;
/** 是否隐藏刷新时间标签 */
@property (assign, nonatomic, getter=isUpdatedTimeHidden) BOOL updatedTimeHidden;

#pragma mark - 交给子类重写
/** 下拉的百分比(交给子类重写) */
@property (assign, nonatomic) CGFloat pullingPercent;
@end
