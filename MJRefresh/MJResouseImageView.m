//
//  MJResouseImageView.m
//  MJRefreshExample
//
//  Created by Admin on 16/1/29.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "MJResouseImageView.h"

@implementation MJResouseImageView

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    UIBezierPath *path = [UIBezierPath bezierPath];
    [[UIColor colorWithRed:103/255.0 green:103/255.0 blue:103/255.0 alpha:1] set];
    path.lineWidth = 1.5;
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineCapRound;
    [path moveToPoint:CGPointMake(1, 23)];
    [path addLineToPoint:CGPointMake(7.5, 30)];
    [path addLineToPoint:CGPointMake(14, 23)];
    [path addLineToPoint:CGPointMake(7.5, 30)];
    [path addLineToPoint:CGPointMake(7.5, 7)];
    [path stroke];

}


@end
