//
//  DBManager.m
//
//  Created on 15/6/5.
//  Copyright (c) 2015年. All rights reserved.
//

#import "DBManager.h"
#import "FMDatabase.h"
#import "DetailModel.h"

#define LFLog(...) NSLog(__VA_ARGS__)

@interface DBManager ()
{
    FMDatabase *_db; // FMDatabase的实例
    NSLock     *_lock; // 锁
}
@end

@implementation DBManager

// static 只能初始化一次
static DBManager *_DBMng;
+ (instancetype)shareManager
{
    static dispatch_once_t predicate; //谓词
    // 保证这个块代码只执行一次
    dispatch_once(&predicate, ^{
        _DBMng = [[DBManager alloc] init];
    });
    
    return _DBMng;
}
//加锁的写法
//+ (DBManager *)shareManager{
//    @synchronized(self){
//        if (_DBMng == nil) {
//            _DBMng = [[DBManager alloc] init];
//        }
//    }
//    return _DBMng;
//}
//
//+ (DBManager *)shareManager{
//    if (_DBMng == nil) {
//        _DBMng = [[DBManager alloc] init];
//    }
//    return _DBMng;
//}

- (instancetype)init
{
    if (self = [super init]) {
        _lock = [[NSLock alloc] init];
        // 获取沙盒Document目录
        NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        LFLog(@"沙盒目录%@",documentPath);
        // 拼接数据库名
        documentPath = [documentPath stringByAppendingString:@"/app.db"];
        
        // 创建数据库
        _db = [FMDatabase databaseWithPath:documentPath];
        
        // 创建表
        if ([_db open]) {
            // 创建sql语句
            NSString *str = @"create table if not exists app(appID varchar(32), appName varchar(200), iconUrl varchar(1024))";
            // 执行sql语句
            BOOL b = [_db executeUpdate:str];
            if (b) {
                LFLog(@"表创建成功");
            } else {
                LFLog(@"表创建失败:%@", _db.lastErrorMessage);
            }
        }
        
    }
    
    return self;
}

#pragma mark 加入数据
- (BOOL)insertDataWithDetailModel:(DetailModel *)model
{
    // 加锁是为了保证只有一个线程对此insertData操作
    [_lock lock];
    // 创建sql语句
    NSString *str = @"insert into app(appID, appName, iconUrl) values(?, ?, ?)";
    // 执行sql语句
    BOOL isSuccess = [_db executeUpdate:str, model.applicationId, model.name, model.iconUrl];
    if (isSuccess) {
        LFLog(@"插入数据成功");
    } else {
        LFLog(@"插入数据失败%@", _db.lastErrorMessage);
    }
    
    [_lock unlock];
    
    return isSuccess;
}

#pragma mark 删除数据
- (BOOL)deleteDataWithDetailModel:(DetailModel *)model
{
    [_lock lock];
    // 1，创建sql语句
    NSString *str = @"delete from app where appID = ?";
    
    // 2，执行sql语句
    BOOL isSuccess = [_db executeUpdate:str, model.applicationId];
    
    // 3，查看执行结果
    if (isSuccess) {
        LFLog(@"删除数据成功");
    } else {
        LFLog(@"删除数据失败%@", _db.lastErrorMessage);
    }
    
    [_lock unlock];
    return isSuccess;
}

#pragma mark 更新一条数据
- (BOOL)updateDataWithModel:(DetailModel *)model
{
    [_lock lock];
    NSString *sql = @"update app set appName = ? where appID = ?";
    BOOL isSuccess = [_db executeUpdate:sql,model.name,model.applicationId];
    if (isSuccess) {
        NSLog(@"更新数据成功");
    }else{
        NSLog(@"更新失败:%@",_db.lastErrorMessage);
    }
    [_lock unlock];
    return isSuccess;
}
#pragma mark 查询单个数据
- (BOOL)searchDataWithDetailModel:(DetailModel *)model
{
    NSString *str = @"select * from app where appID = ?";
    // 当查询的时候是执行executeQuery，返回值是一个结果集
    FMResultSet *set = [_db executeQuery:str, model.applicationId];
    // [set next],如果结果集里面有值，返回yes，反之no.
    return [set next];
}

#pragma mark 查询所有数据
- (NSArray *)searchAllData
{
    // 装模型的数组
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:0];
    NSString *str = @"select * from app";
    // 当查询的时候是执行executeQuery，返回值是一个结果集
    FMResultSet *set = [_db executeQuery:str];
    
    // 遍历结果集一条一条将数据取出来
    while ([set next]) {
        DetailModel *model = [[DetailModel alloc] init];
        model.applicationId = [set stringForColumn:@"appID"];
        model.name = [set stringForColumn:@"appName"];
        model.iconUrl = [set stringForColumn:@"iconUrl"];
        [arrayM addObject:model];
    }
    
    return arrayM;
}

@end
