# FMDB数据库的使用演示和封装工具类
使用了FMDB来实现数据库,创建了DManager来创建数据库,实现增删改查,使用方法简单,快捷,同时不会出现数据重复操作.
Used FMDB to realize the database, created DManager to create a database, additions and deletions to change search, use method is simple, fast and avoid the duplication of data operation.


使用步骤。。。

使用cocoapods,下载FMDB,将DBManager文件导入工程中,并创建自己的model

// 单例
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
