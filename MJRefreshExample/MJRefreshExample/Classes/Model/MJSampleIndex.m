//
//  MJSampleIndex.m
//  快速集成下拉刷新
//
//  Created by mj on 14-1-3.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "MJSampleIndex.h"

@implementation MJSampleIndex
+ (instancetype)sampleIndexWithTitle:(NSString *)title controllerClass:(Class)controllerClass
{
    MJSampleIndex *si = [[self alloc] init];
    
    si.title = title;
    si.controllerClass = controllerClass;
    
    return si;
}
@end
