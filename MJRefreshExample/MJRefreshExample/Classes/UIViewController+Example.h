//
//  UIViewController+Example.h
//  MJRefreshExample
//
//  Created by MJ Lee on 15/3/12.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MJPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

@interface UIViewController (Example)
@property (copy, nonatomic) NSString *method;
@end
