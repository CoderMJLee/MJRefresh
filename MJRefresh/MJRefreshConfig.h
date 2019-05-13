//
//  MJRefreshConfig.h
//
//  Created by Frank on 2018/11/27.
//  Copyright © 2018 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MJRefreshConfig : NSObject

/** 默认使用的语言版本, 默认为 nil. 将随系统的语言自动改变 */
@property (copy, nonatomic, nullable) NSString *languageCode;

/**
 默认的 Header 高度
 @note Default value is 54
 */
@property (nonatomic) CGFloat headerHeight;
/**
 默认的 Footer 高度
 @note Default value is 44
 */
@property (nonatomic) CGFloat footerHeight;
/**
 默认的快速动画切换时间
 @note 默认是 0.25s
 */
@property (nonatomic) NSTimeInterval fastAnimationDuration;
/**
 默认的慢速动画切换时间
 @note 默认是 0.4s
 */
@property (nonatomic) NSTimeInterval slowAnimationDuration;


/** @return Singleton Config instance */
+ (instancetype)defaultConfig;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
