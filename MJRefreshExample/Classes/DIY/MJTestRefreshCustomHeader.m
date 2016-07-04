//
//  MJTestRefreshCustomHeader.m
//  MJRefreshExample
//
//  Created by king on 16/7/4.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "MJTestRefreshCustomHeader.h"

@interface MJTestRefreshCustomHeader ()
@property (nonatomic, weak) UIImageView *refreshImageView;
@property (nonatomic, weak) UIImageView *idleImageView;
@property (nonatomic, weak) UILabel *textLable;
@end

@implementation MJTestRefreshCustomHeader

- (void)prepare {
    [super prepare];
    
    self.mj_h = 80;
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
        [refreshingImages addObject:image];
    }

    NSMutableArray *idleImages = [NSMutableArray arrayWithCapacity:31];
    for (NSUInteger i = 1; i <= 31; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"load_%zd", i]];
        [idleImages addObject:image];
    }
    
    
    UIImageView *refreshImageView = [[UIImageView alloc] init];
    refreshImageView.animationImages = refreshingImages;
    refreshImageView.animationDuration = 3 * 0.23;
    self.refreshImageView = refreshImageView;
    
    UIImageView *idleImageView = [[UIImageView alloc] init];
    idleImageView.animationImages = idleImages;
    idleImageView.animationDuration = 31 * 0.03;
    self.idleImageView = idleImageView;
    
    
    UIView *view1 = [[UIView alloc] init];
    view1.backgroundColor = [UIColor blueColor];
    [view1 addSubview:idleImageView];
    
    
    UILabel *leble = [[UILabel alloc] init];
    leble.textAlignment = NSTextAlignmentCenter;
    leble.text = @"松开即可吃包子.......";
    self.textLable = leble;
    UIView *view2 = [[UIView alloc] init];
    view2.backgroundColor = [UIColor yellowColor];
    [view2 addSubview:leble];
    
    
    UIView *view3 = [[UIView alloc] init];
    view3.backgroundColor = [UIColor redColor];
    [view3 addSubview:refreshImageView];
    
    
    self.automaticallyChangeAlpha = YES;
    [self setView:view1 forState:MJRefreshStateIdle];
    [self setView:view2 forState:MJRefreshStatePulling];
    [self setView:view3 forState:MJRefreshStateRefreshing];
}

- (void)placeSubviews {
    
    [super placeSubviews];
    
    self.refreshImageView.mj_h = 30;
    self.refreshImageView.mj_w = 30;
    self.refreshImageView.center = CGPointMake(self.mj_w * 0.5, self.mj_h * 0.5);
    
    self.idleImageView.mj_h = 40;
    self.idleImageView.mj_w = 50;
    self.idleImageView.center = CGPointMake(self.mj_w * 0.5, self.mj_h * 0.5);
    
    self.textLable.frame = self.bounds;
}

- (void)setState:(MJRefreshState)state {
    
    [super setState:state];
    
    switch (state) {
        case MJRefreshStateRefreshing:
            [self.refreshImageView startAnimating];
            [self.idleImageView stopAnimating];
            break;
          case MJRefreshStateIdle:
            [self.idleImageView startAnimating];
            break;
        default:
            [self.refreshImageView stopAnimating];
            
            break;
    }
}
@end
