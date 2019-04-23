//
//  UIView+UIViewController.m
//  QRTProject
//
//  Created by GongHe on 2019/04/22.
//  Copyright © 2019 GongHe. All rights reserved.
//

#import "UIView+GHUIViewController.h"

@implementation UIView (GHUIViewController)

// MARK: - 通过View获取View的Controller
/**
 通过View获取View的Controller

 @return 获取Controller
 */
- (UIViewController *)viewController {
    
    //通过响应者链关系，取得此视图的下一个响应者
    UIResponder *next = self.nextResponder;
    
    do {
        
        //判断响应者对象是否是视图控制器类型
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        
        next = next.nextResponder;
        
    }while(next != nil);
    
    
    return nil;
}

@end
