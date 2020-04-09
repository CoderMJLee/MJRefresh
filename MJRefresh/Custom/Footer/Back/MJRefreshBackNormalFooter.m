//
//  MJRefreshBackNormalFooter.m
//  MJRefreshExample
//
//  Created by MJ Lee on 15/4/24.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "MJRefreshBackNormalFooter.h"
#import "NSBundle+MJRefresh.h"

@interface MJRefreshBackNormalFooter()
{
    __unsafe_unretained UIImageView *_arrowView;
}
@property (weak, nonatomic) UIActivityIndicatorView *loadingView;
@end

@implementation MJRefreshBackNormalFooter
#pragma mark - 懒加载子控件
- (UIImageView *)arrowView
{
    if (!_arrowView) {
        UIImageView *arrowView = [[UIImageView alloc] initWithImage:[NSBundle mj_arrowImage]];
        [self addSubview:_arrowView = arrowView];
    }
    return _arrowView;
}


- (UIActivityIndicatorView *)loadingView
{
    if (!_loadingView) {
        UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:_activityIndicatorViewStyle];
        loadingView.hidesWhenStopped = YES;
        [self addSubview:_loadingView = loadingView];
    }
    return _loadingView;
}

- (void)setActivityIndicatorViewStyle:(UIActivityIndicatorViewStyle)activityIndicatorViewStyle
{
    _activityIndicatorViewStyle = activityIndicatorViewStyle;
    
    [self.loadingView removeFromSuperview];
    self.loadingView = nil;
    [self setNeedsLayout];
}
#pragma mark - 重写父类的方法
- (void)prepare
{
    [super prepare];
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED > 130000
    if (@available(iOS 13.0, *)) {
        _activityIndicatorViewStyle = UIActivityIndicatorViewStyleMedium;
        return;
    }
#endif
        
    _activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
}

- (void)placeSubviews
{
    [super placeSubviews];
    
    // 箭头的中心点
    CGFloat arrowCenterX = self.mj_w * 0.5;
    if (!self.stateLabel.hidden) {
        arrowCenterX -= self.labelLeftInset + self.stateLabel.mj_textWidth * 0.5;
    }
    CGFloat arrowCenterY = self.mj_h * 0.5;
    CGPoint arrowCenter = CGPointMake(arrowCenterX, arrowCenterY);
    
    // 箭头
    if (self.arrowView.constraints.count == 0) {
        self.arrowView.mj_size = self.arrowView.image.size;
        self.arrowView.center = arrowCenter;
    }
    
    // 圈圈
    if (self.loadingView.constraints.count == 0) {
        self.loadingView.center = arrowCenter;
    }
    
    self.arrowView.tintColor = self.stateLabel.textColor;
}

- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState
    
    // 根据状态做事情
    if (state == MJRefreshStateIdle) {
        if (oldState == MJRefreshStateRefreshing) {
            self.arrowView.transform = CGAffineTransformMakeRotation(0.000001 - M_PI);
            [UIView animateWithDuration:MJRefreshSlowAnimationDuration animations:^{
                self.loadingView.alpha = 0.0;
            } completion:^(BOOL finished) {
                // 防止动画结束后，状态已经不是MJRefreshStateIdle
                if (self.state != MJRefreshStateIdle) return;
                
                self.loadingView.alpha = 1.0;
                [self.loadingView stopAnimating];
                
                self.arrowView.hidden = NO;
            }];
        } else {
            self.arrowView.hidden = NO;
            [self.loadingView stopAnimating];
            [UIView animateWithDuration:MJRefreshFastAnimationDuration animations:^{
                self.arrowView.transform = CGAffineTransformMakeRotation(0.000001 - M_PI);
            }];
        }
    } else if (state == MJRefreshStatePulling) {
        self.arrowView.hidden = NO;
        [self.loadingView stopAnimating];
        [UIView animateWithDuration:MJRefreshFastAnimationDuration animations:^{
            self.arrowView.transform = CGAffineTransformIdentity;
        }];
    } else if (state == MJRefreshStateRefreshing) {
        self.arrowView.hidden = YES;
        [self.loadingView startAnimating];
    } else if (state == MJRefreshStateNoMoreData) {
        self.arrowView.hidden = YES;
        [self.loadingView stopAnimating];
    }
}

@end
