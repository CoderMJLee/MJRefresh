//
//  MJTempViewController.h
//  MJRefreshExample
//
//  Created by MJ Lee on 15/9/22.
//  Copyright © 2015年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface MJTempViewController : UIViewController

+ (instancetype)sharedInstance;

@property (assign, nonatomic) UIStatusBarStyle statusBarStyle;
@property (assign, nonatomic) BOOL statusBarHidden;

@end

NS_ASSUME_NONNULL_END
