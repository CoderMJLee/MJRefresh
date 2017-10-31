//
//  MJRefreshAutoGifFooter.m
//  MJRefreshExample
//
//  Created by MJ Lee on 15/4/24.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "MJRefreshAutoGifFooter.h"

@interface MJRefreshAutoGifFooter()
{
    __unsafe_unretained UIImageView *_gifView;
}
/** 所有状态对应的动画图片 */
@property (strong, nonatomic) NSMutableDictionary *stateImages;
/** 所有状态对应的动画时间 */
@property (strong, nonatomic) NSMutableDictionary *stateDurations;
@end

@implementation MJRefreshAutoGifFooter
#pragma mark - 懒加载
- (UIImageView *)gifView
{
    if (!_gifView) {
        UIImageView *gifView = [[UIImageView alloc] init];
        [self addSubview:_gifView = gifView];
    }
    return _gifView;
}

- (NSMutableDictionary *)stateImages
{
    if (!_stateImages) {
        self.stateImages = [NSMutableDictionary dictionary];
    }
    return _stateImages;
}

- (NSMutableDictionary *)stateDurations
{
    if (!_stateDurations) {
        self.stateDurations = [NSMutableDictionary dictionary];
    }
    return _stateDurations;
}

#pragma mark - 公共方法
- (void)setImages:(NSArray *)images duration:(NSTimeInterval)duration forState:(MJRefreshState)state
{
    if (images == nil) return;
    
    self.stateImages[@(state)] = images;
    self.stateDurations[@(state)] = @(duration);
    
    /* 根据图片设置控件的高度 */
    UIImage *image = [images firstObject];
    if (image.size.height > self.mj_h) {
        self.mj_h = image.size.height;
    }
}

- (void)setImages:(NSArray *)images forState:(MJRefreshState)state
{
    [self setImages:images duration:images.count * 0.1 forState:state];
}

#pragma mark - 实现父类的方法
- (void)prepare
{
    [super prepare];
    
    // 初始化间距
    self.labelLeftInset = 20;
}

- (void)placeSubviews
{
    [super placeSubviews];
    
    if (self.gifView.constraints.count) return;
    
    switch (self.scrollView.mj_refreshDirection) {
        case MJRefreshDirectionHorizontal:
            self.gifView.frame = self.bounds;
            if (self.isRefreshingTitleHidden) {
                //修正gif不居中
                self.gifView.center=CGPointMake(self.gifView.center.x, (self.mj_h-self.scrollView.mj_insetT)/2.);
                self.stateLabel.center=self.gifView.center;

                self.gifView.contentMode = UIViewContentModeCenter;
            } else {
                self.gifView.contentMode = UIViewContentModeBottom;
                
                CGSize textSize=[self.stateLabel.text
                                 boundingRectWithSize:self.stateLabel.mj_size
                                 options:NSStringDrawingUsesLineFragmentOrigin
                                 attributes:@{NSFontAttributeName:self.stateLabel.font}
                                 context:nil].size;
                self.gifView.mj_h=(self.mj_h-textSize.height)/2.;
            }
            break;
        case MJRefreshDirectionVertical:
        default:
            self.gifView.frame = self.bounds;
            if (self.isRefreshingTitleHidden) {
                self.gifView.contentMode = UIViewContentModeCenter;
            } else {
                self.gifView.contentMode = UIViewContentModeRight;
                self.gifView.mj_w = self.mj_w * 0.5 - self.labelLeftInset - self.stateLabel.mj_textWith * 0.5;
            }
            break;
    }
}

- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState
    
    // 根据状态做事情
    if (state == MJRefreshStateRefreshing) {
        NSArray *images = self.stateImages[@(state)];
        if (images.count == 0) return;
        [self.gifView stopAnimating];
        
        self.gifView.hidden = NO;
        if (images.count == 1) { // 单张图片
            self.gifView.image = [images lastObject];
        } else { // 多张图片
            self.gifView.animationImages = images;
            self.gifView.animationDuration = [self.stateDurations[@(state)] doubleValue];
            [self.gifView startAnimating];
        }
    } else if (state == MJRefreshStateNoMoreData || state == MJRefreshStateIdle) {
        [self.gifView stopAnimating];
        self.gifView.hidden = YES;
    }
}
@end

