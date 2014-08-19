//
//  UIScrollView+Extension.h
//  MJRefreshExample
//
//  Created by MJ Lee on 14-5-28.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (MJExtension)
@property (assign, nonatomic) CGFloat mj_contentInsetTop;
@property (assign, nonatomic) CGFloat mj_contentInsetBottom;
@property (assign, nonatomic) CGFloat mj_contentInsetLeft;
@property (assign, nonatomic) CGFloat mj_contentInsetRight;

@property (assign, nonatomic) CGFloat mj_contentOffsetX;
@property (assign, nonatomic) CGFloat mj_contentOffsetY;

@property (assign, nonatomic) CGFloat mj_contentSizeWidth;
@property (assign, nonatomic) CGFloat mj_contentSizeHeight;
@end
