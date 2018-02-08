//
//  ViewController.m
//  FMDBLessionOne
//
//  Created by Alexander on 2018/2/8.
//  Copyright © 2018年 alexander. All rights reserved.
//

#import "ViewController.h"
#import "FMDatabase.h"

@interface ViewController ()


@end

@implementation ViewController
{
	// 数据库路径
	NSString *_dbPath;
	// 数据库实例
	FMDatabase *_db;

}


- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	[self createDB];
	//[self createTb];
	//[self insertData];
	//[self deleteData];
	
	//[self updateData];
	// [self queryData];
	[self deleteTable];
}

/** 0 数据库的创建 */
- (void)createDB
{
	// 0 路径
	_dbPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
	
	// 数据库的名字
	NSString *dbName = [_dbPath stringByAppendingPathComponent:@"alex.sqlite"];
	// 创建数据库
	_db = [FMDatabase databaseWithPath:dbName];
	NSLog(@"%@",_dbPath);
	// 打开指定路径的数据库  存在则打开 不存在进行创建
	if ([_db open]) {
		NSLog(@"数据库已然打开");
	}else{
		NSLog(@"数据库打开失败");
	}
}

/** 1 创建表 */
- (void)createTb
{
	// sql 语句
	NSString *opStr = @"CREATE TABLE IF NOT EXISTS t_class(id integer PRIMARY KEY AUTOINCREMENT,name text NOT NULL,age integer NOT NULL,sex TEXT NOT NULL);";
	BOOL res = [_db executeUpdate:opStr];
	
	if (res) {
	// 创建成功
	NSLog(@"创建表成功");
	}else{
	// 创建失败
	NSLog(@"创建表失败");
	}
	
}

/** 2 插入数据 */
- (void)insertData
{
	NSString *name  = @"巨星";
	NSString *sex = @"男";
	int age = 76;
	
	// sql 语句
	NSString *sql = @"INSERT INTO t_class(name,age,sex)VALUES(?,?,?)";
	
	BOOL res = [_db executeUpdate:sql,name,@(age),sex];
	
	if (res) {
		NSLog(@"数据插入成功");
	}else{
		NSLog(@"数据插入失败");
	}
}

/** 3 删除数据 */
- (void)deleteData
{
	// 删除的时候必然有条件匹配
	// 例如id 或者 对应的字段
	BOOL res = [_db executeUpdate:@"delete from t_class where id = ?",@(1)];
	
	if (res) {
	
		NSLog(@"删除成功");
	}else{
		NSLog(@"删除失败");
	}

}

/** 4 更新数据 */
- (void)updateData
{
	NSString *name = @"小米";
	NSString *oldName = @"刘德华";
	
	BOOL res = [_db executeUpdate:@"update t_class set name = ? where name = ?",name,oldName];
	if (res) {
		NSLog(@"修改成功");
	}else{
		NSLog(@"修改失败");
	}
}


/**5 查询数据*/
- (void)queryData
{
	// 查询整个表 select * from t_class
	// 根据条件查询
	FMResultSet *resultSet = [_db executeQuery:@"select * from t_class where id = ?",@(5)];
	// 循环遍历出每一个选项
	while ([resultSet next]) {
		NSString *name = [resultSet objectForColumn:@"name"];
		NSLog(@"name-- %@",name);
	}

}

/** 删除表 */
- (void)deleteTable
{
	BOOL res = [_db executeUpdate:@"drop table if exists t_class"];
	if (res) {
	// 删除成功
	NSLog(@"删除表成功");
	}else{
	// 删除失败
	NSLog(@"删除表失败");
	}

}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


@end
