//
//  MJRefreshCustomLegendHeader.m
//  MJRefreshExample
//
//  Created by mac on 15-4-16.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "JQRefreshCustomLegendHeader.h"
#import "MJRefreshConst.h"
#import "UIView+MJExtension.h"
@interface JQRefreshCustomLegendHeader()

@property (nonatomic, strong) UIImage *idle;
@property (nonatomic, strong) UIImage *refreshing;
@property (nonatomic, strong) UIImage *pulling;

@property (nonatomic, strong) UIImageView *idleView;
@property (nonatomic, strong) UIImageView *refreshingView;
@property (nonatomic, strong) UIImageView *pullingView;

@property (nonatomic, strong) CAAnimation *idleViewAnimation;
@property (nonatomic, strong) CAAnimation *refreshingViewAnimation;
@property (nonatomic, strong) CAAnimation *pullingViewAnimation;

@property (nonatomic, copy) void(^idleViewAnimationBlock)(UIImageView *imageView);
@property (nonatomic, copy) void(^refreshingViewAnimationBlock)(UIImageView *imageView);
@property (nonatomic, strong) void(^pullingViewAnimationBlock)(UIImageView *imageView) ;
@end

@implementation JQRefreshCustomLegendHeader

#pragma mark - 根据状态 设置图片 和 动画效果
-(void)setImage:(NSString *)imageName forState:(JQRefreshHeaderState)state animationWithBlock:(void(^)(UIImageView *imageView))animation{

    switch (state) {
        case JQRefreshHeaderStateIdle:
        {
            _idle = [UIImage imageNamed:MJRefreshSrcName(imageName)];
            _idleView = [[UIImageView alloc] initWithImage:_idle];
            _idleViewAnimationBlock = animation;
        }
            break;
        case JQRefreshHeaderStateRefreshing:
        {
            _refreshing = [UIImage imageNamed:MJRefreshSrcName(imageName)];
            _refreshingView = [[UIImageView alloc] initWithImage:_refreshing];
            [self addSubview:_refreshingView ];
            _refreshingViewAnimationBlock = animation;
        }
            break;
            
            
        case JQRefreshHeaderStatePulling:
        {
            _pulling = [UIImage imageNamed:MJRefreshSrcName(imageName)];
            _pullingView = [[UIImageView alloc] initWithImage:_pulling];
            [self addSubview:_pullingView ];
            _pullingViewAnimationBlock = animation;
        }
            break;
            
        default:
            break;
    }


}

#pragma mark - 根据状态 设置图片
-(void)setImage:(NSString *)imageName forState:(JQRefreshHeaderState)state {

    switch (state) {
        case JQRefreshHeaderStateIdle:
        {
            self.state = MJRefreshHeaderStateIdle;
            _idle = [UIImage imageNamed:MJRefreshSrcName(imageName)];
            _idleView = [[UIImageView alloc] initWithImage:_idle];
            [self addSubview:_idleView];
        }
            break;
        case JQRefreshHeaderStateRefreshing:
        {
            self.state = JQRefreshHeaderStateRefreshing;
            _refreshing = [UIImage imageNamed:MJRefreshSrcName(imageName)];
            _refreshingView = [[UIImageView alloc] initWithImage:_refreshing];
            [self addSubview:_refreshingView ];
        }
            break;
        case JQRefreshHeaderStatePulling:
        {
            self.state = MJRefreshHeaderStatePulling;
            _pulling = [UIImage imageNamed:MJRefreshSrcName(imageName)];
            _pullingView = [[UIImageView alloc] initWithImage:_pulling];
            [self addSubview:_pullingView ];
        }
            break;
        default:
            break;
    }
}

#pragma mark - 初始化
- (void)layoutSubviews
{
    [super layoutSubviews];

    
    // 限制状态图片
    CGFloat idleX = (self.stateHidden && self.updatedTimeHidden) ? self.mj_w * 0.5 : (self.mj_w * 0.5 - 100);
    self.idleView.center = CGPointMake(idleX, self.mj_h * 0.5);
    
    // 正在刷新状态图片
    self.refreshingView.center = self.idleView.center;
    
    // 下拉状态
    self.pullingView.center = self.idleView.center;
}

#pragma mark - 公共方法
#pragma mark 设置状态
- (void)setState:(MJRefreshHeaderState)state
{
    if (self.state == state) return;
    
    // 旧状态
    MJRefreshHeaderState oldState = self.state;
    
    switch (state) {
        case MJRefreshHeaderStateIdle: {

            // 隐藏
            self.refreshingView.alpha = 0.0;
            self.pullingView.alpha = 0.0;
            
            if (oldState == MJRefreshHeaderStateRefreshing) {

                // 清空动画
                [self.idleView.layer removeAllAnimations] ;
                [self.refreshingView.layer removeAllAnimations] ;
                [self.pullingView.layer removeAllAnimations] ;
                [UIView animateWithDuration:MJRefreshSlowAnimationDuration animations:^{
   
                    // 隐藏
                    self.idleView.alpha = 0.0;
                    
                } completion:^(BOOL finished) {
              
                    self.idleView.alpha = 1.0;
                   
                    
                }];
            } else {
                [UIView animateWithDuration:MJRefreshFastAnimationDuration animations:^{
                
                    [self.idleView.layer removeAllAnimations];
                    
                    // 显示空闲图片
                    self.idleView.alpha = 1.0;
                    
                    if (_idleViewAnimationBlock) {
                        _idleViewAnimationBlock(self.idleView);
                    }
                }];
            }
            
            break;
        }
            
        case MJRefreshHeaderStatePulling: {
            [UIView animateWithDuration:MJRefreshFastAnimationDuration animations:^{
                
                // 显示下拉图片
                self.idleView.alpha = 0.0;
                self.refreshingView.alpha = 0.0;
                self.pullingView.alpha = 1.0;
                
                [self.idleView.layer removeAllAnimations];
                
                if (_pullingViewAnimationBlock !=nil) {
                    _pullingViewAnimationBlock(self.pullingView);
                }
                
            }];
            break;
        }
            
        case MJRefreshHeaderStateRefreshing: {
            // --

            [self.idleView.layer removeAllAnimations];
            
            // 显示刷新图片
            self.refreshingView.alpha = 1.0;
            self.idleView.alpha = 0.0;
            self.pullingView.alpha = 0.0;
        
            if (_refreshingViewAnimationBlock !=nil) {
                _refreshingViewAnimationBlock(self.refreshingView);
            }
            
            
            break;
        }
            
        default:
            break;
    }
    
    // super里面有回调，应该在最后面调用
    [super setState:state];
}

@end
