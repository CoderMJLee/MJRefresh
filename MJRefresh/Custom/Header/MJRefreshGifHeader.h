//
//  MJRefreshGifHeader.h
//  MJRefreshExample
//
//  Created by MJ Lee on 15/4/24.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "MJRefreshStateHeader.h"

@interface MJRefreshGifHeader : MJRefreshStateHeader
@property (weak, nonatomic, readonly) UIImageView *gifView;

/** 设置state状态下的动画图片images 动画持续时间duration*/
- (void)mj_setImages:(NSArray *)images duration:(NSTimeInterval)duration forState:(MJRefreshState)state;
- (void)mj_setImages:(NSArray *)images forState:(MJRefreshState)state;

#pragma mark - 过期方法
- (void)setImages:(NSArray *)images duration:(NSTimeInterval)duration forState:(MJRefreshState)state MJRefreshDeprecated("使用mj_setImages:duration:forState:");
- (void)setImages:(NSArray *)images forState:(MJRefreshState)state MJRefreshDeprecated("使用mj_setImages:forState:");
@end
