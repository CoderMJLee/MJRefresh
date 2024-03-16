//  代码地址: https://github.com/CoderMJLee/MJRefresh
//  UIScrollView+Extension.h
//  MJRefresh
//
//  Created by MJ Lee on 14-5-28.
//  Copyright (c) 2014年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (MJExtension)
@property (readonly, nonatomic) UIEdgeInsets mj_inset;

@property (assign, nonatomic) CGFloat mj_insetT;
@property (assign, nonatomic) CGFloat mj_insetB;
@property (assign, nonatomic) CGFloat mj_insetL;
@property (assign, nonatomic) CGFloat mj_insetR;

@property (assign, nonatomic) CGFloat mj_offsetX;
@property (assign, nonatomic) CGFloat mj_offsetY;

@property (assign, nonatomic) CGFloat mj_contentW;
@property (assign, nonatomic) CGFloat mj_contentH;

/** Ma.).Mi ✎
 * 	首页tabbar滚动隐藏新策略
 *	@1. 根据滚动距离判断
 *	@2. 根据滚动方向判断
 *  ps: 希望能加入到扩展当中，不用再维护previousOffsetY临时变量。😊
 */
typedef NS_ENUM(NSInteger, ScrollDirection) {
  None = 0, Top, Left, Bottom, Right
};
@property (nonatomic, assign, readonly) NSInteger mj_scrollDistance;
@property (nonatomic, assign, readonly) ScrollDirection mj_scrollDirection;

@end

NS_ASSUME_NONNULL_END
