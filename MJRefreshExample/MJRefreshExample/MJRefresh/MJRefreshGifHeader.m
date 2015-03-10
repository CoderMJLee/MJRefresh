//  代码地址: https://github.com/CoderMJLee/MJRefresh
//  代码地址: http://code4app.com/ios/%E5%BF%AB%E9%80%9F%E9%9B%86%E6%88%90%E4%B8%8B%E6%8B%89%E4%B8%8A%E6%8B%89%E5%88%B7%E6%96%B0/52326ce26803fabc46000000
//  MJRefreshGifHeader.m
//  MJRefreshExample
//
//  Created by MJ Lee on 15/3/4.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "MJRefreshGifHeader.h"
#import "MJRefreshConst.h"
#import "UIView+MJExtension.h"

@interface MJRefreshGifHeader()
/** 所有状态对应的动画图片 */
@property (strong, nonatomic) NSMutableDictionary *stateImages;

/** 播放动画图片的控件 */
@property (weak, nonatomic) UIImageView *gifView;
@end

@implementation MJRefreshGifHeader
#pragma mark - 懒加载
- (NSMutableDictionary *)stateImages
{
    if (!_stateImages) {
        self.stateImages = [NSMutableDictionary dictionary];
    }
    return _stateImages;
}

- (UIImageView *)gifView
{
    if (!_gifView) {
        UIImageView *gifView = [[UIImageView alloc] init];
        [self addSubview:_gifView = gifView];
    }
    return _gifView;
}

#pragma mark - 初始化
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.gifView.frame = self.bounds;
    if (self.stateHidden && self.updatedTimeHidden) {
        self.gifView.contentMode = UIViewContentModeCenter;
    } else {
        self.gifView.contentMode = UIViewContentModeRight;
        self.gifView.mj_w = self.mj_w * 0.5 - 90;
    }
}

#pragma mark - 公共方法
#pragma mark 设置状态
- (void)setState:(MJRefreshHeaderState)state
{
    if (self.state == state) return;
    
    // 旧状态
    MJRefreshHeaderState oldState = self.state;
    
    NSArray *images = self.stateImages[@(state)];
    if (images.count != 0) {
        switch (state) {
            case MJRefreshHeaderStateIdle: {
                if (oldState == MJRefreshHeaderStateRefreshing) {
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MJRefreshSlowAnimationDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        self.pullingPercent = 0.0;
                    });
                } else {
                    self.pullingPercent = self.pullingPercent;
                }
                break;
            }
                
            case MJRefreshHeaderStatePulling:
            case MJRefreshHeaderStateRefreshing: {
                [self.gifView stopAnimating];
                if (images.count == 1) { // 单张图片
                    self.gifView.image = [images lastObject];
                } else { // 多张图片
                    self.gifView.animationImages = images;
                    self.gifView.animationDuration = images.count * 0.1;
                    [self.gifView startAnimating];
                }
                break;
            }
                
            default:
                break;
        }
    }
    
    // super里面有回调，应该在最后面调用
    [super setState:state];
}

- (void)setPullingPercent:(CGFloat)pullingPercent
{
    [super setPullingPercent:pullingPercent];
    
    NSArray *images = self.stateImages[@(self.state)];
    switch (self.state) {
        case MJRefreshHeaderStateIdle: {
            [self.gifView stopAnimating];
            NSUInteger index =  images.count * self.pullingPercent;
            if (index >= images.count) index = images.count - 1;
            self.gifView.image = images[index];
            break;
        }
        default:
            break;
    }
}

- (void)setImages:(NSArray *)images forState:(MJRefreshHeaderState)state
{
    if (images == nil) return;
    
    self.stateImages[@(state)] = images;
    
    // 根据图片设置控件的高度
    UIImage *image = [images firstObject];
    if (image.size.height > self.mj_h) {
        self.mj_h = image.size.height;
    }
}
@end
