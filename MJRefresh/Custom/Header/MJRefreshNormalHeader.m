//
//  MJRefreshNormalHeader.m
//  MJRefreshExample
//
//  Created by MJ Lee on 15/4/24.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "MJRefreshNormalHeader.h"
#import "NSBundle+MJRefresh.h"

@interface MJRefreshNormalHeader()
{
    __unsafe_unretained UIImageView *_arrowView;
}
@property (weak, nonatomic) UIActivityIndicatorView *loadingView;
@end

@implementation MJRefreshNormalHeader
#pragma mark - 懒加载子控件
- (UIImageView *)arrowView
{
    if (!_arrowView) {
        UIImageView *arrowView = [[UIImageView alloc] initWithImage:[NSBundle mj_arrowImage]];
        arrowView.contentMode=UIViewContentModeCenter;
        [self addSubview:_arrowView = arrowView];
    }
    return _arrowView;
}

- (UIActivityIndicatorView *)loadingView
{
    if (!_loadingView) {
        UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:self.activityIndicatorViewStyle];
        loadingView.hidesWhenStopped = YES;
        [self addSubview:_loadingView = loadingView];
    }
    return _loadingView;
}

#pragma mark - 公共方法
- (void)setActivityIndicatorViewStyle:(UIActivityIndicatorViewStyle)activityIndicatorViewStyle
{
    _activityIndicatorViewStyle = activityIndicatorViewStyle;
    
    self.loadingView = nil;
    [self setNeedsLayout];
}

#pragma mark - 重写父类的方法
- (void)prepare
{
    [super prepare];
    
    self.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
}

- (void)placeSubviews
{
    [super placeSubviews];
    switch (self.scrollView.mj_refreshDirection) {
        case MJRefreshDirectionHorizontal:
        {
            // 箭头的中心点
            CGFloat arrowCenterX = self.mj_w * 0.75;
            CGFloat arrowCenterY = (self.mj_h -self.scrollView.mj_insetT)* 0.5;
            CGPoint arrowCenter = CGPointMake(arrowCenterX, arrowCenterY);
            
            // 箭头
            if (self.arrowView.constraints.count == 0) {
                self.arrowView.mj_size = self.arrowView.image.size;
                self.arrowView.center = arrowCenter;
            }
            self.stateLabel.center=CGPointMake(self.mj_w * 0.25, self.stateLabel.center.y-self.scrollView.mj_insetT/2.);
        }
            break;
        case MJRefreshDirectionVertical:
        default:
        {
            // 箭头的中心点
            CGFloat arrowCenterX = self.mj_w * 0.5;
            if (!self.stateLabel.hidden) {
                CGFloat stateWidth = self.stateLabel.mj_textWith;
                CGFloat timeWidth = 0.0;
                if (!self.lastUpdatedTimeLabel.hidden) {
                    timeWidth = self.lastUpdatedTimeLabel.mj_textWith;
                }
                CGFloat textWidth = MAX(stateWidth, timeWidth);
                arrowCenterX -= textWidth / 2 + self.labelLeftInset;
            }
            CGFloat arrowCenterY = self.mj_h * 0.5;
            CGPoint arrowCenter = CGPointMake(arrowCenterX, arrowCenterY);
            
            // 箭头
            if (self.arrowView.constraints.count == 0) {
                self.arrowView.mj_size = self.arrowView.image.size;
                self.arrowView.center = arrowCenter;
            }
        }
            break;
    }
    // 圈圈
    if (self.loadingView.constraints.count == 0) {
        self.loadingView.center = self.arrowView.center;
    }
    
    self.arrowView.tintColor = self.stateLabel.textColor;

}

- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState
    
    // 根据状态做事情
    if (state == MJRefreshStateIdle) {
        if (oldState == MJRefreshStateRefreshing) {
            switch (self.scrollView.mj_refreshDirection) {
                case MJRefreshDirectionHorizontal:
                    self.arrowView.transform = CGAffineTransformMakeRotation(0.000001 - M_PI/2.);;
                    break;
                case MJRefreshDirectionVertical:
                default:
                    self.arrowView.transform = CGAffineTransformIdentity;
                    break;
            }
            
            [UIView animateWithDuration:MJRefreshSlowAnimationDuration animations:^{
                self.loadingView.alpha = 0.0;
            } completion:^(BOOL finished) {
                // 如果执行完动画发现不是idle状态，就直接返回，进入其他状态
                if (self.state != MJRefreshStateIdle) return;
                
                self.loadingView.alpha = 1.0;
                [self.loadingView stopAnimating];
                self.arrowView.hidden = NO;
            }];
        } else {
            [self.loadingView stopAnimating];
            self.arrowView.hidden = NO;
            [UIView animateWithDuration:MJRefreshFastAnimationDuration animations:^{
                switch (self.scrollView.mj_refreshDirection) {
                    case MJRefreshDirectionHorizontal:
                        self.arrowView.transform = CGAffineTransformMakeRotation(0.000001 - M_PI/2.);;
                        break;
                    case MJRefreshDirectionVertical:
                    default:
                        self.arrowView.transform = CGAffineTransformIdentity;
                        break;
                }
            }];
        }
    } else if (state == MJRefreshStatePulling) {
        [self.loadingView stopAnimating];
        self.arrowView.hidden = NO;
        [UIView animateWithDuration:MJRefreshFastAnimationDuration animations:^{
            switch (self.scrollView.mj_refreshDirection) {
                case MJRefreshDirectionHorizontal:
                    self.arrowView.transform = CGAffineTransformMakeRotation(0.000001 + M_PI/2.);;
                    break;
                case MJRefreshDirectionVertical:
                default:
                    self.arrowView.transform = CGAffineTransformMakeRotation(0.000001 - M_PI);
                    break;
            }
        }];
    } else if (state == MJRefreshStateRefreshing) {
        self.loadingView.alpha = 1.0; // 防止refreshing -> idle的动画完毕动作没有被执行
        [self.loadingView startAnimating];
        self.arrowView.hidden = YES;
    }
}
@end
