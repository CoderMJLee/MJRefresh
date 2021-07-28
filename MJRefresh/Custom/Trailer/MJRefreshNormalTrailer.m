//
//  MJRefreshNormalTrailer.m
//  MJRefreshExample
//
//  Created by kinarobin on 2020/5/3.
//  Copyright © 2020 小码哥. All rights reserved.
//

#import "MJRefreshNormalTrailer.h"
#import "NSBundle+MJRefresh.h"

@interface MJRefreshNormalTrailer() {
    __unsafe_unretained UIImageView *_arrowView;
}
@end

@implementation MJRefreshNormalTrailer

#pragma mark - Override
- (void)placeSubviews {
    [super placeSubviews];
    
    // 箭头的 Size
    CGSize arrowSize = self.arrowView.image.size;
    
    // 状态标签是否隐藏
    BOOL stateHidden = self.stateLabel.isHidden;
    
    // 箭头的中心点
    CGPoint arrowCenter = CGPointMake(arrowSize.width * 0.5 + 5, self.mj_h * 0.5);
    CGPoint selfCenter = CGPointMake(self.mj_w * 0.5, self.mj_h * 0.5);
    
    // 如果自定义了箭头的中心点，则使用自定义的中心点
    if (!CGPointEqualToPoint(self.customArrowViewCenter, CGPointZero)) {
        arrowCenter = self.customArrowViewCenter;
    }
    
    if (self.arrowView.constraints.count == 0) {
        self.arrowView.mj_size = self.arrowView.image.size;
        
        if (stateHidden) { // 隐藏了标签，并且自定义了箭头的中心点，则使用自定义的中心点
            if (!CGPointEqualToPoint(self.customArrowViewCenter, CGPointZero)) {
                selfCenter = self.customArrowViewCenter;
            }
            self.arrowView.center = selfCenter;
            
        } else { // 没有隐藏标签
            self.arrowView.center = arrowCenter;
        }
    }
    
    self.arrowView.tintColor = self.stateLabel.textColor;
    
    if (stateHidden) {
        return;
    }
    
    if (self.stateLabel.constraints.count == 0) {
        
        CGFloat stateLabelW = ceil(self.stateLabel.font.pointSize);
        CGFloat stateCenterX = (self.mj_w + arrowSize.width) * 0.5;
        CGFloat stateCenterY = self.mj_h * 0.5;
        CGFloat stateLabelH = self.mj_h;
        
        // arrowView 使用自定义的中心点后，需要调整 stateLabel 的 height 和 centerX
        if (!CGPointEqualToPoint(self.customArrowViewCenter, CGPointZero)) {
            stateLabelH = (stateLabelH - (self.customArrowViewCenter.y * 0.5));
            stateCenterX = self.customArrowViewCenter.x + arrowSize.width;
        }
        
        BOOL arrowHidden = self.arrowView.isHidden;
        self.stateLabel.center = arrowHidden ? selfCenter : CGPointMake(stateCenterX, stateCenterY);
        self.stateLabel.mj_size = CGSizeMake(stateLabelW, stateLabelH) ;
    }
}

#pragma mark - Setter Methods
- (void)setCustomArrowViewCenter:(CGPoint)customArrowViewCenter {
    _customArrowViewCenter = customArrowViewCenter;
    [self placeSubviews];
}

- (void)setState:(MJRefreshState)state {
    MJRefreshCheckState
    // 根据状态做事情
    if (state == MJRefreshStateIdle) {
        if (oldState == MJRefreshStateRefreshing) {
            [UIView animateWithDuration:self.fastAnimationDuration animations:^{
                self.arrowView.transform = CGAffineTransformMakeRotation(M_PI);
            } completion:^(BOOL finished) {
                self.arrowView.transform = CGAffineTransformIdentity;
            }];
        } else {
            [UIView animateWithDuration:self.fastAnimationDuration animations:^{
                self.arrowView.transform = CGAffineTransformIdentity;
            }];
        }
    } else if (state == MJRefreshStatePulling) {
        [UIView animateWithDuration:self.fastAnimationDuration animations:^{
            self.arrowView.transform = CGAffineTransformMakeRotation(M_PI);
        }];
    }
}

#pragma mark - Lazy load
- (UIImageView *)arrowView {
    if (!_arrowView) {
        UIImageView *arrowView = [[UIImageView alloc] initWithImage:[NSBundle mj_trailArrowImage]];
        [self addSubview:_arrowView = arrowView];
    }
    return _arrowView;
}

@end
