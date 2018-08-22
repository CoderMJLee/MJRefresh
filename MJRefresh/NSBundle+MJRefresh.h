//
//  NSBundle+MJRefresh.h
//  MJRefreshExample
//
//  Created by MJ Lee on 16/6/13.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM (NSInteger, MJLanguageCode) {
    MJLanguageDefault = 0,
    MJLanguageEn = 1, // en
    MJLanguageZhHans = 2, // zh-Hans
    MJLanguageZhHant = 3 // zh-Hant
};

@interface NSBundle(MJRefresh)

@property(nonatomic, assign) MJLanguageCode language;

+(instancetype)mj_refreshBundle;
+(UIImage *)mj_arrowImage;
+(NSString *)mj_localizedStringForKey: (NSString *)key value: (NSString *)value;
+(NSString *)mj_localizedStringForKey: (NSString *)key customCode: (MJLanguageCode)code;
+(NSString *)mj_localizedStringForKey: (NSString *)key value: (NSString *)value customCode: (MJLanguageCode)code;

@end
