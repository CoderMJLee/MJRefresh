//
//  MJYiDataSource.h
//  MJRefreshExample
//
//  Created by Ying Yi on 14-7-11.
//  Copyright (c) 2014年 itcast. All rights reserved.
//  Email 517576002@qq.com

#import <Foundation/Foundation.h>

struct dataSourcePageInfoStruct {
    NSInteger page;
    NSInteger totalPages;
};
typedef struct dataSourcePageInfoStruct dataSourcePageInfoStruct;

@interface MJYiDataSource : NSObject
@property(nonatomic,strong)NSMutableArray *dsArray;//tableview或者collectionview的数据源
@property(nonatomic,assign)dataSourcePageInfoStruct pageStruct;//存储当前页数和总页数的结构体

//重置当前页和总页数均为0
-(void)reset;
//设置当前页和总页数
- (void)setPageInfoWithPage:(NSInteger)page AndTotalPages:(NSInteger)totalPages;
//页数加1
- (void)addPage;
//获得当前页
- (NSInteger)page;
//获得总页数
- (NSInteger)totalPages;
@end
