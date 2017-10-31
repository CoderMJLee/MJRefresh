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
            CGFloat arrowCenterX = self.mj_w * 0.25;

            CGFloat arrowCenterY = (self.mj_h -self.scrollView.mj_insetT) * 0.5;
            CGPoint arrowCenter = CGPointMake(arrowCenterX, arrowCenterY);
            
            // 箭头
            if (self.arrowView.constraints.count == 0) {
                self.arrowView.mj_size = self.arrowView.image.size;
                self.arrowView.center = arrowCenter;
            }
            
            self.stateLabel.center=arrowCenter;
            self.stateLabel.mj_x = self.arrowView.mj_w;
        }
            break;
        case MJRefreshDirectionVertical:
        default:
        {
            // 箭头的中心点
            CGFloat arrowCenterX = self.mj_w * 0.5;
            if (!self.stateLabel.hidden) {
                arrowCenterX -= self.labelLeftInset + self.stateLabel.mj_textWith * 0.5;
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
                    self.arrowView.transform = CGAffineTransformMakeRotation(0.000001 + M_PI/2.);;
                    break;
                case MJRefreshDirectionVertical:
                default:
                    self.arrowView.transform = CGAffineTransformMakeRotation(0.000001 - M_PI);
                    break;
            }
            [UIView animateWithDuration:MJRefreshSlowAnimationDuration animations:^{
                self.loadingView.alpha = 0.0;
            } completion:^(BOOL finished) {
                self.loadingView.alpha = 1.0;
                [self.loadingView stopAnimating];
                
                self.arrowView.hidden = NO;
            }];
        } else {
            self.arrowView.hidden = NO;
            [self.loadingView stopAnimating];
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
        }
    } else if (state == MJRefreshStatePulling) {
        self.arrowView.hidden = NO;
        [self.loadingView stopAnimating];
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
    } else if (state == MJRefreshStateRefreshing) {
        self.arrowView.hidden = YES;
        [self.loadingView startAnimating];
    } else if (state == MJRefreshStateNoMoreData) {
        self.arrowView.hidden = YES;
        [self.loadingView stopAnimating];
    }
}

@end
