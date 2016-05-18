//
//  DBManager.h
//
//  Created on 15/6/5.
//  Copyright (c) 2015年. All rights reserved.
//
//  单例

#import <Foundation/Foundation.h>
@class DetailModel;
@interface DBManager : NSObject

+ (instancetype)shareManager;

// 插入一条数据
- (BOOL)insertDataWithDetailModel:(DetailModel *)model;

// 删除一条数据
- (BOOL)deleteDataWithDetailModel:(DetailModel *)model;

// 更改一条数据
- (BOOL)updateDataWithModel:(DetailModel *)model;
// 查询表里面是否有这条数据
- (BOOL)searchDataWithDetailModel:(DetailModel *)model;

// 查询表里面所有的数据
- (NSArray *)searchAllData;
@end
