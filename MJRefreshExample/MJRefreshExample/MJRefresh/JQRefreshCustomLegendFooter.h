//
//  JQRefreshCustomLegendFooter.h
//  MJRefreshExample
//
//  Created by mac on 15-4-16.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

// =================================================
//  自定义上拉刷新控件：
//      -> 适用于 一张图片且需要对图片进行动画效果
// ==================================================

#import "MJRefreshFooter.h"

@interface JQRefreshCustomLegendFooter : MJRefreshFooter

/** 设置刷新时的image 和 动画效果 */
-(void)setImage:(NSString *)imageName animationWithBlock:(void(^)(UIImageView *imageView))animation;
@end
