//
//  JQRefreshCustomLegendFooter.m
//  MJRefreshExample
//
//  Created by mac on 15-4-16.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "JQRefreshCustomLegendFooter.h"
#import "MJRefreshConst.h"
#import "UIView+MJExtension.h"
#import "UIScrollView+MJExtension.h"
@interface JQRefreshCustomLegendFooter ()

@property (nonatomic, strong) UIImage *refreshImage;
@property (nonatomic, strong) UIImageView *refreshView;
@property (nonatomic, copy) void (^refreshAnimationBlock)(UIImageView *);
@end

@implementation JQRefreshCustomLegendFooter

-(void)setImage:(NSString *)imageName animationWithBlock:(void (^)(UIImageView *))animation{
//    _refreshImage = [UIImage imageNamed:MJRefreshSrcName(imageName)];
    _refreshImage = [UIImage imageNamed:imageName];
    _refreshView = [[UIImageView alloc] initWithImage:_refreshImage];
    [self addSubview:_refreshView ];
    _refreshAnimationBlock = animation;
}

#pragma mark - 初始化方法
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 指示器
    if (self.stateHidden) {
        self.refreshView.center = CGPointMake(self.mj_w * 0.5, self.mj_h * 0.5);
    } else {
        self.refreshView.center = CGPointMake(self.mj_w * 0.5 - 100, self.mj_h * 0.5);
    }
     self.refreshView.hidden = YES;
}

#pragma mark - 公共方法
- (void)setState:(MJRefreshFooterState)state
{
    if (self.state == state) return;
    
    switch (state) {
        case MJRefreshFooterStateIdle:
            [_refreshView.layer removeAllAnimations];
            self.refreshView.hidden = YES;

            break;
            
        case MJRefreshFooterStateRefreshing:
            [_refreshView.layer removeAllAnimations];
            self.refreshView.hidden = NO;
            if (_refreshAnimationBlock != nil) {
                _refreshAnimationBlock(self.refreshView);
            }
            break;
            
        case MJRefreshFooterStateNoMoreData:

            [_refreshView.layer removeAllAnimations];
            self.refreshView.hidden = YES;

            break;
            
        default:
            break;
    }
    
    // super里面有回调，应该在最后面调用
    [super setState:state];
}
@end
