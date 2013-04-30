//
//  DataManager.m
//  Run and Roll
//
//  Created by Joaquin on 13-4-21.
//  Copyright (c) 2013年 Joaquin Hwang. All rights reserved.
//

#import "DataManager.h"

#define DBNAME @"runtohell.sqlite"

@implementation DataManager

+ (DataManager*)getInstance
{
    static dispatch_once_t pred = 0;
    __strong static DataManager *_sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init]; // or some other init method
    });
    return _sharedObject;
}


- (NSString *)databasePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    return [documents stringByAppendingPathComponent:DBNAME];
}

- (void)openDatabase
{
    if (sqlite3_open([[self databasePath] UTF8String], &m_DataBase) != SQLITE_OK)
    {
        sqlite3_close(m_DataBase);
        NSAssert(0, @"数据库打开失败");
    }
}


@end
