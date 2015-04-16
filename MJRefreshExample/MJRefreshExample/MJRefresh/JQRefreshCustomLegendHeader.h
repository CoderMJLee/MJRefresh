//
//  MJRefreshCustomLegendHeader.h
//  MJRefreshExample
//
//  Created by mac on 15-4-16.
//  Copyright (c) 2015年 itcast. All rights reserved.
//


// =================================================
//  自定义下拉刷新控件：
//      -> 适用于 在不同状态下 一张图片且需要对图片进行动画效果
// ==================================================
#import "MJRefreshHeader.h"

@interface JQRefreshCustomLegendHeader : MJRefreshHeader

typedef NS_ENUM(NSInteger, JQRefreshHeaderState) {
    /** 普通闲置状态 */
    JQRefreshHeaderStateIdle = 1,
    /** 正在刷新中的状态 */
    JQRefreshHeaderStateRefreshing,
    /** 松开就可以进行刷新的状态 */
    JQRefreshHeaderStatePulling
};

/** 设置state状态下的动画图片image */
-(void)setImage:(NSString *)imageName forState:(JQRefreshHeaderState)state;

/** 设置state状态下的动画图片image 在state状态下 图片的动画效果  */
-(void)setImage:(NSString *)imageName forState:(JQRefreshHeaderState)state animationWithBlock:(void(^)(UIImageView *imageView))animation;
@end
