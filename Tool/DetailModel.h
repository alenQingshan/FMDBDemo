//
//  DetailModel.h
//
//  Created on 15/6/4.
//  Copyright (c) 2015年. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailModel : NSObject
@property (nonatomic, copy) NSString *applicationId; // 应用id
@property (nonatomic, copy) NSString *iconUrl; // 图片路径
@property (nonatomic, copy) NSString *name; // 图片名字
@property (nonatomic, copy) NSString *currentPrice; // 价格
@property (nonatomic, copy) NSString *categoryName; // 分类名
@property (nonatomic, copy) NSString *starCurrent; // 星级
@property (nonatomic, copy) NSArray *photos; // 滑动图片数组
@property (nonatomic, copy) NSString *description_long; // 描述
@property (nonatomic, copy) NSString *itunesUrl; // itunes路径

@end
