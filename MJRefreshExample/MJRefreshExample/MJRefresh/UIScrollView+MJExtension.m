//  代码地址: https://github.com/CoderMJLee/MJRefresh
//  代码地址: http://code4app.com/ios/%E5%BF%AB%E9%80%9F%E9%9B%86%E6%88%90%E4%B8%8B%E6%8B%89%E4%B8%8A%E6%8B%89%E5%88%B7%E6%96%B0/52326ce26803fabc46000000
//  UIScrollView+Extension.m
//  MJRefreshExample
//
//  Created by MJ Lee on 14-5-28.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "UIScrollView+MJExtension.h"

@implementation UIScrollView (MJExtension)
- (void)setMj_insetT:(CGFloat)mj_insetT
{
    UIEdgeInsets inset = self.contentInset;
    inset.top = mj_insetT;
    self.contentInset = inset;
}

- (CGFloat)mj_insetT
{
    return self.contentInset.top;
}

- (void)setMj_insetB:(CGFloat)mj_insetB
{
    UIEdgeInsets inset = self.contentInset;
    inset.bottom = mj_insetB;
    self.contentInset = inset;
}

- (CGFloat)mj_insetB
{
    return self.contentInset.bottom;
}

- (void)setMj_insetL:(CGFloat)mj_insetL
{
    UIEdgeInsets inset = self.contentInset;
    inset.left = mj_insetL;
    self.contentInset = inset;
}

- (CGFloat)mj_insetL
{
    return self.contentInset.left;
}

- (void)setMj_insetR:(CGFloat)mj_insetR
{
    UIEdgeInsets inset = self.contentInset;
    inset.right = mj_insetR;
    self.contentInset = inset;
}

- (CGFloat)mj_insetR
{
    return self.contentInset.right;
}

- (void)setMj_offsetX:(CGFloat)mj_offsetX
{
    CGPoint offset = self.contentOffset;
    offset.x = mj_offsetX;
    self.contentOffset = offset;
}

- (CGFloat)mj_offsetX
{
    return self.contentOffset.x;
}

- (void)setMj_offsetY:(CGFloat)mj_offsetY
{
    CGPoint offset = self.contentOffset;
    offset.y = mj_offsetY;
    self.contentOffset = offset;
}

- (CGFloat)mj_offsetY
{
    return self.contentOffset.y;
}

- (void)setMj_contentSizeW:(CGFloat)mj_contentSizeW
{
    CGSize size = self.contentSize;
    size.width = mj_contentSizeW;
    self.contentSize = size;
}

- (CGFloat)mj_contentSizeW
{
    return self.contentSize.width;
}

- (void)setMj_contentSizeH:(CGFloat)mj_contentSizeH
{
    CGSize size = self.contentSize;
    size.height = mj_contentSizeH;
    self.contentSize = size;
}

- (CGFloat)mj_contentSizeH
{
    return self.contentSize.height;
}
@end
