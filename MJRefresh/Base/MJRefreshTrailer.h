//
//  MJRefreshTrailer.h
//  MJRefresh
//
//  Created by kinarobin on 2020/5/3.
//  Copyright © 2020 小码哥. All rights reserved.
//

#import "MJRefreshComponent.h"

NS_ASSUME_NONNULL_BEGIN

@interface MJRefreshTrailer : MJRefreshComponent

/** 创建trailer*/
+ (instancetype)trailerWithRefreshingBlock:(MJRefreshComponentAction)refreshingBlock;
/** 创建trailer */
+ (instancetype)trailerWithRefreshingTarget:(id)target refreshingAction:(SEL)action;

/** 忽略多少scrollView的contentInset的right */
@property (assign, nonatomic) CGFloat ignoredScrollViewContentInsetRight;


@end

NS_ASSUME_NONNULL_END
