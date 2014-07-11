//
//  MJYiDataSource.m
//  MJRefreshExample
//
//  Created by Ying Yi on 14-7-11.
//  Copyright (c) 2014年 itcast. All rights reserved.
//  Email 517576002@qq.com

#import "MJYiDataSource.h"

@implementation MJYiDataSource
- (id)init
{
    self = [super init];
    if (self) {
        self.dsArray = [[NSMutableArray alloc]initWithCapacity:32];
        
        dataSourcePageInfoStruct stru;
        stru.page = 0;
        stru.totalPages = 0;
        
        self.pageStruct = stru;
        
        
    }
    return self;
}

-(void)reset
{
    [self setPageInfoWithPage:0 AndTotalPages:0];
    [self.dsArray removeAllObjects];
}


- (void)setPageInfoWithPage:(NSInteger)page AndTotalPages:(NSInteger)totalPages
{
    dataSourcePageInfoStruct stru;
    stru.page = page;
    stru.totalPages = totalPages;
    self.pageStruct = stru;
}

- (void)addPage
{
    [self setPageInfoWithPage:self.pageStruct.page+1 AndTotalPages:self.pageStruct.totalPages];
}

- (NSInteger)page
{
    return self.pageStruct.page;
}

- (NSInteger)totalPages
{
    return self.pageStruct.totalPages;
}

@end
