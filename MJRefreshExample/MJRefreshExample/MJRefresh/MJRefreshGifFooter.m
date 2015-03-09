//  代码地址: https://github.com/CoderMJLee/MJRefresh
//  代码地址: http://code4app.com/ios/%E5%BF%AB%E9%80%9F%E9%9B%86%E6%88%90%E4%B8%8B%E6%8B%89%E4%B8%8A%E6%8B%89%E5%88%B7%E6%96%B0/52326ce26803fabc46000000
//  MJRefreshGifFooter.m
//  MJRefreshExample
//
//  Created by MJ Lee on 15/3/5.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "MJRefreshGifFooter.h"
#import "MJRefreshConst.h"
#import "UIView+MJExtension.h"
#import "UIScrollView+MJExtension.h"

@interface MJRefreshGifFooter()
/** 播放动画图片的控件 */
@property (weak, nonatomic) UIImageView *gifView;
@end

@implementation MJRefreshGifFooter
#pragma mark - 懒加载
- (UIImageView *)gifView
{
    if (!_gifView) {
        UIImageView *gifView = [[UIImageView alloc] init];
        [self addSubview:_gifView = gifView];
    }
    return _gifView;
}

#pragma mark - 初始化方法
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 指示器
    self.gifView.frame = self.bounds;
    if (self.stateHidden) {
        self.gifView.contentMode = UIViewContentModeCenter;
    } else {
        self.gifView.contentMode = UIViewContentModeRight;
        self.gifView.mj_w = self.mj_w * 0.5 - 90;
    }
}

#pragma mark - 公共方法
- (void)setState:(MJRefreshFooterState)state
{
    if (self.state == state) return;
    
    switch (state) {
        case MJRefreshFooterStateIdle:
            self.gifView.hidden = YES;
            [self.gifView stopAnimating];
            break;
            
        case MJRefreshFooterStateRefreshing:
            self.gifView.hidden = NO;
            [self.gifView startAnimating];
            break;
            
        case MJRefreshFooterStateNoMoreData:
            self.gifView.hidden = YES;
            [self.gifView stopAnimating];
            break;
            
        default:
            break;
    }
    
    // super里面有回调，应该在最后面调用
    [super setState:state];
}

- (void)setRefreshingImages:(NSArray *)refreshingImages
{
    _refreshingImages = refreshingImages;
    
    self.gifView.animationImages = refreshingImages;
    self.gifView.animationDuration = refreshingImages.count * 0.1;
    
    // 根据图片设置控件的高度
    UIImage *image = [refreshingImages firstObject];
    if (image.size.height > self.mj_h) {
        _scrollView.mj_insetB -= self.mj_h;
        self.mj_h = image.size.height;
        _scrollView.mj_insetB += self.mj_h;
    }
}
@end
