//
//  MJRefreshGifHeader.h
//  MJRefreshExample
//
//  Created by MJ Lee on 15/3/4.
//  Copyright (c) 2015年 itcast. All rights reserved.
//  带有gif图片功能的下拉刷新控件

#import "MJRefreshHeader.h"

@interface MJRefreshGifHeader : MJRefreshHeader
/** 设置state状态下的动画图片images */
- (void)setImages:(NSArray *)images forState:(MJRefreshHeaderState)state;
@end
