//
//  UIScrollView+Extension.m
//  MJRefreshExample
//
//  Created by MJ Lee on 14-5-28.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "UIScrollView+MJExtension.h"

@implementation UIScrollView (MJExtension)
- (void)setMj_contentInsetTop:(CGFloat)mj_contentInsetTop
{
    UIEdgeInsets inset = self.contentInset;
    inset.top = mj_contentInsetTop;
    self.contentInset = inset;
}

- (CGFloat)mj_contentInsetTop
{
    return self.contentInset.top;
}

- (void)setMj_contentInsetBottom:(CGFloat)mj_contentInsetBottom
{
    UIEdgeInsets inset = self.contentInset;
    inset.bottom = mj_contentInsetBottom;
    self.contentInset = inset;
}

- (CGFloat)mj_contentInsetBottom
{
    return self.contentInset.bottom;
}

- (void)setMj_contentInsetLeft:(CGFloat)mj_contentInsetLeft
{
    UIEdgeInsets inset = self.contentInset;
    inset.left = mj_contentInsetLeft;
    self.contentInset = inset;
}

- (CGFloat)mj_contentInsetLeft
{
    return self.contentInset.left;
}

- (void)setMj_contentInsetRight:(CGFloat)mj_contentInsetRight
{
    UIEdgeInsets inset = self.contentInset;
    inset.right = mj_contentInsetRight;
    self.contentInset = inset;
}

- (CGFloat)mj_contentInsetRight
{
    return self.contentInset.right;
}

- (void)setMj_contentOffsetX:(CGFloat)mj_contentOffsetX
{
    CGPoint offset = self.contentOffset;
    offset.x = mj_contentOffsetX;
    self.contentOffset = offset;
}

- (CGFloat)mj_contentOffsetX
{
    return self.contentOffset.x;
}

- (void)setMj_contentOffsetY:(CGFloat)mj_contentOffsetY
{
    CGPoint offset = self.contentOffset;
    offset.y = mj_contentOffsetY;
    self.contentOffset = offset;
}

- (CGFloat)mj_contentOffsetY
{
    return self.contentOffset.y;
}

- (void)setMj_contentSizeWidth:(CGFloat)mj_contentSizeWidth
{
    CGSize size = self.contentSize;
    size.width = mj_contentSizeWidth;
    self.contentSize = size;
}

- (CGFloat)mj_contentSizeWidth
{
    return self.contentSize.width;
}

- (void)setMj_contentSizeHeight:(CGFloat)mj_contentSizeHeight
{
    CGSize size = self.contentSize;
    size.height = mj_contentSizeHeight;
    self.contentSize = size;
}

- (CGFloat)mj_contentSizeHeight
{
    return self.contentSize.height;
}
@end
