//
//  NSBundle+MJRefresh.h
//  MJRefreshExample
//
//  Created by MJ Lee on 16/6/13.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSBundle (MJRefresh)
+ (nullable instancetype)mj_refreshBundle;
+ (UIImage * _Nullable)mj_arrowImage;
+ (NSString * _Nullable)mj_localizedStringForKey:(NSString *)key value:(NSString * _Nullable)value;
+ (NSString * _Nullable)mj_localizedStringForKey:(NSString *)key;
@end

NS_ASSUME_NONNULL_END
