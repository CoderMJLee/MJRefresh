//  代码地址: https://github.com/CoderMJLee/MJRefresh
//  UIScrollView+Extension.m
//  MJRefresh
//
//  Created by MJ Lee on 14-5-28.
//  Copyright (c) 2014年 小码哥. All rights reserved.
//

#import "UIScrollView+MJExtension.h"
#import <objc/runtime.h>

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunguarded-availability-new"

@implementation UIScrollView (MJExtension)

static BOOL respondsToAdjustedContentInset_;

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        respondsToAdjustedContentInset_ = [self instancesRespondToSelector:@selector(adjustedContentInset)];
    });
}

- (UIEdgeInsets)mj_inset
{
#ifdef __IPHONE_11_0
    if (respondsToAdjustedContentInset_) {
        return self.adjustedContentInset;
    }
#endif
    return self.contentInset;
}

- (void)setMj_insetT:(CGFloat)mj_insetT
{
    UIEdgeInsets inset = self.contentInset;
    inset.top = mj_insetT;
#ifdef __IPHONE_11_0
    if (respondsToAdjustedContentInset_) {
        inset.top -= (self.adjustedContentInset.top - self.contentInset.top);
    }
#endif
    self.contentInset = inset;
}

- (CGFloat)mj_insetT
{
    return self.mj_inset.top;
}

- (void)setMj_insetB:(CGFloat)mj_insetB
{
    UIEdgeInsets inset = self.contentInset;
    inset.bottom = mj_insetB;
#ifdef __IPHONE_11_0
    if (respondsToAdjustedContentInset_) {
        inset.bottom -= (self.adjustedContentInset.bottom - self.contentInset.bottom);
    }
#endif
    self.contentInset = inset;
}

- (CGFloat)mj_insetB
{
    return self.mj_inset.bottom;
}

- (void)setMj_insetL:(CGFloat)mj_insetL
{
    UIEdgeInsets inset = self.contentInset;
    inset.left = mj_insetL;
#ifdef __IPHONE_11_0
    if (respondsToAdjustedContentInset_) {
        inset.left -= (self.adjustedContentInset.left - self.contentInset.left);
    }
#endif
    self.contentInset = inset;
}

- (CGFloat)mj_insetL
{
    return self.mj_inset.left;
}

- (void)setMj_insetR:(CGFloat)mj_insetR
{
    UIEdgeInsets inset = self.contentInset;
    inset.right = mj_insetR;
#ifdef __IPHONE_11_0
    if (respondsToAdjustedContentInset_) {
        inset.right -= (self.adjustedContentInset.right - self.contentInset.right);
    }
#endif
    self.contentInset = inset;
}

- (CGFloat)mj_insetR
{
    return self.mj_inset.right;
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

- (void)setMj_contentW:(CGFloat)mj_contentW
{
    CGSize size = self.contentSize;
    size.width = mj_contentW;
    self.contentSize = size;
}

- (CGFloat)mj_contentW
{
    return self.contentSize.width;
}

- (void)setMj_contentH:(CGFloat)mj_contentH
{
    CGSize size = self.contentSize;
    size.height = mj_contentH;
    self.contentSize = size;
}

- (CGFloat)mj_contentH
{
    return self.contentSize.height;
}

/** Ma.).Mi ✎
 *  每次 scrollview 滑动的方向
 */
- (ScrollDirection)mj_scrollDirection {
  NSInteger distance = self.mj_scrollDistance;
  /** Ma.).Mi ✎
   *  如果是 UITableView
   */
  if ([self.delegate respondsToSelector:@selector(tableView:numberOfRowsInSection:)] || [self.delegate respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
	return distance > 0 ? Bottom : (distance != 0 ? Top : None);
  } else {
	if (self.mj_offsetX > self.mj_offsetY) {
	  return distance > 0 ? Right : (distance != 0 ? Left : None);
	} else {
	  return distance > 0 ? Bottom : (distance != 0 ? Top : None);
	}
  }
}

/** Ma.).Mi ✎
 *  每次 scrollview 滑动的距离
 */
- (NSInteger)mj_scrollDistance {
  if (self.mj_offsetY > 0) {
	/** Ma.).Mi ✎
	 *  如果是 UITableView
	 */
	if ([self.delegate respondsToSelector:@selector(tableView:numberOfRowsInSection:)] || [self.delegate respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
	  return ABS(self.mj_offsetY) - ABS(self.mj_previousOffsetY)  + self._setPreviousOffsetY;
	} else {
	  if (self.mj_offsetX > self.mj_offsetY) {
		return ABS(self.mj_offsetX) - ABS(self.mj_previousOffsetX) + self._setPreviousOffsetX;
	  } else {
		return ABS(self.mj_offsetY) - ABS(self.mj_previousOffsetY) + self._setPreviousOffsetY;
	  }
	}
  } else if (self.mj_offsetY < 0) {
	return self.mj_offsetY;
  } else {
	return 0;
  }
}

/** Ma.).Mi ✎
 *  previous contentOffset.y
 */
- (CGFloat)mj_previousOffsetY {
  id value = objc_getAssociatedObject(self, _cmd);
  if (value) {
	CGFloat value_float = ((NSNumber *)value).floatValue;
	return value_float;
  } else {
	objc_setAssociatedObject(self, _cmd, [NSNumber numberWithFloat:self.mj_offsetY], OBJC_ASSOCIATION_RETAIN);
  }
  
  return 0;
}

/** Ma.).Mi ✎
 *  previous contentOffset.x
 */
- (CGFloat)mj_previousOffsetX {
  id value = objc_getAssociatedObject(self, _cmd);
  if (value) {
	CGFloat value_float = ((NSNumber *)value).floatValue;
	return value_float;
  } else {
	objc_setAssociatedObject(self, _cmd, [NSNumber numberWithFloat:self.mj_offsetX], OBJC_ASSOCIATION_RETAIN);
  }
  
  return 0;
}

#pragma mark #Ma.).Mi# - private method
- (int)_setPreviousOffsetX {
  objc_setAssociatedObject(self, @selector(mj_previousOffsetX), [NSNumber numberWithFloat:self.mj_offsetX], OBJC_ASSOCIATION_RETAIN);
  return 0;
}

- (int)_setPreviousOffsetY {
  objc_setAssociatedObject(self, @selector(mj_previousOffsetY), [NSNumber numberWithFloat:self.mj_offsetY], OBJC_ASSOCIATION_RETAIN);
  return 0;
}

@end
#pragma clang diagnostic pop
