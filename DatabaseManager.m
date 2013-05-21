//
//  DatabaseManager.m
//  Run and Roll
//
//  Created by Joaquin on 13-4-21.
//  Copyright (c) 2013年 Joaquin Hwang. All rights reserved.
//

#import "DatabaseManager.h"
#import <CoreLocation/CoreLocation.h>

#define DBNAME @"runtohell.sqlite"

@implementation DatabaseManager
//@synthesize m_database;


static DatabaseManager* g_databaseManager = nil;
+(DatabaseManager*)getInstance
{
    if (g_databaseManager == nil) {
        g_databaseManager = [[DatabaseManager alloc] init];
    }
    return g_databaseManager;
}


-(NSString *)databasePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    return [documents stringByAppendingPathComponent:DBNAME];
}

-(BOOL)openDatabase
{
    if (sqlite3_open([[self databasePath] UTF8String], &m_database) != SQLITE_OK)
    {
        sqlite3_close(m_database);
        NSAssert(0, @"数据库打开失败");
    }
    else{
        NSLog(@"数据库打开成功");
        return YES;
    }
    return NO;
}

-(void)closeDatabase
{
    sqlite3_close(m_database);
}

-(void)createActivityInfo
{
    NSString *sql = @"CREATE TABLE if not exists 'main'.'Activity_Info' ('id' INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL  UNIQUE ,'date_timestamp' INTEGER NOT NULL ,'distance' FLOAT NOT NULL  DEFAULT (0.0) ,'total_time' FLOAT NOT NULL  DEFAULT (0.0) ,'speed' FLOAT NOT NULL  DEFAULT (0.0) ,'calorie' INTEGER NOT NULL  DEFAULT (0) ,'status' INTEGER NOT NULL  DEFAULT (3) ,'record_timestamp' INTEGER NOT NULL  DEFAULT (0) ,'map_table_name' INTEGER NOT NULL  DEFAULT (0) )";
    
    if ([self openDatabase]) {
        if (sqlite3_exec(m_database, [sql UTF8String], NULL, NULL, nil) == SQLITE_OK) {
            NSLog(@"create act table ok");
        }
        [self closeDatabase];
    }
}



-(void)dropActivityInfo{
    NSString *sql = @"DROP TABLE 'main'.'Activity_Info'";
    if ([self openDatabase]) {
        if (sqlite3_exec(m_database, [sql UTF8String], NULL, NULL, nil) == SQLITE_OK) {
            NSLog(@"drop act table ok");
        }
        [self closeDatabase];
    }
}


-(void)insertOneActivity:(ActivityInfo *)activity
{
    char *errMsg;
    NSString *sql = [NSString stringWithFormat:@"insert into Activity_Info (date_timestamp, distance, total_time, speed, calorie, status, record_timestamp, map_table_name) values ('%d', '%f', '%d', '%f', '%d', '%d', '%d', '%d')", activity.m_dateTimeStamp, activity.m_distance, activity.m_totalTime, activity.m_speed, activity.m_calorie, 1, activity.m_mapInfoTableName, activity.m_mapInfoTableName];
    NSLog(@"%@",sql);
    if ([self openDatabase]) {
        if (sqlite3_exec(m_database, [sql UTF8String], NULL, NULL, &errMsg) == SQLITE_OK) {
            NSLog(@"INSERT act OK");
            [self createMapTableByName:activity.m_mapInfoTableName];
            [self insertOneLocationsArray:activity.m_locations toMap:activity.m_mapInfoTableName];
        }
        [self closeDatabase];
    }
}

-(NSArray *)selectAllActivities{
    NSString *sql = [NSString stringWithFormat:@"select date_timestamp, distance, total_time, speed, calorie, status, record_timestamp, map_table_name from Activity_Info"];
    NSLog(@"%@",sql);
    if ([self openDatabase]) {
        sqlite3_stmt *statement;
        NSMutableArray *tmpArray = [[NSMutableArray alloc] init];
        if (sqlite3_prepare_v2(m_database, [sql UTF8String], -1, &statement, nil) == SQLITE_OK) {
            NSLog(@"select all act ok! ");
            while (sqlite3_step(statement) == SQLITE_ROW) {
                ActivityInfo *oneActInfo = [[ActivityInfo alloc] init];
                oneActInfo.m_dateTimeStamp = sqlite3_column_int(statement, 0);
                oneActInfo.m_distance = sqlite3_column_double(statement, 1);
                oneActInfo.m_totalTime = sqlite3_column_int(statement, 2);
                oneActInfo.m_speed = sqlite3_column_double(statement, 3);
                oneActInfo.m_calorie = sqlite3_column_int(statement, 4);
                oneActInfo.m_status = sqlite3_column_int(statement, 5);
                int recordTimeStamp = sqlite3_column_int(statement, 6);
                oneActInfo.m_record = [self selectRecordsByTimestamp:recordTimeStamp];
                int mapTableName = sqlite3_column_int(statement, 7);
                oneActInfo.m_locations = [self selectOneMapForLocationsArray:mapTableName];
                [tmpArray addObject:oneActInfo];
                [oneActInfo release];
            }
        }
        sqlite3_finalize(statement);
        [self closeDatabase];
        return [tmpArray autorelease];
    }
    return nil;
}

-(void)createRecordTable{
    NSString *sql = @"CREATE TABLE if not exists 'main'.'Record' ('id' INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL  UNIQUE , 'timestamp' INTEGER NOT NULL , 'type' INTEGER NOT NULL )";
    if ([self openDatabase]) {
        if (sqlite3_exec(m_database, [sql UTF8String], NULL, NULL, nil) == SQLITE_OK) {
            NSLog(@"create Record table ok");
        }
        [self closeDatabase];
    }
}

-(void)insertOneRecordByType:(int)type andTimestamp:(int)timestamp{
    char *errMsg;
    NSString *sql = [NSString stringWithFormat:@"insert into Record (timestamp, type) values ('%d','%d')", timestamp, type];
    NSLog(@"%@",sql);
    if ([self openDatabase]) {
        if (sqlite3_exec(m_database, [sql UTF8String], NULL, NULL, &errMsg) == SQLITE_OK) {
            NSLog(@"INSERT record OK");
        }
        [self closeDatabase];
    }
}

-(NSArray *)selectRecordsByTimestamp:(int)timestamp{
    NSString *sql = [NSString stringWithFormat:@"select type from Record where 'timestamp' = %d", timestamp];
    NSLog(@"%@",sql);
    if ([self openDatabase]) {
        sqlite3_stmt *statement;
        NSMutableArray *tmpArray = [[NSMutableArray alloc] init];
        if (sqlite3_prepare_v2(m_database, [sql UTF8String], -1, &statement, nil) == SQLITE_OK) {
            NSLog(@"select record.type ok! ");
            while (sqlite3_step(statement) == SQLITE_ROW) {
                [tmpArray addObject:sqlite3_column_int(statement, 0)];
            }
        }
        sqlite3_finalize(statement);
        [self closeDatabase];
        return [tmpArray autorelease];
    }
    return nil;
}

-(void)createMapTableByName:(int)name{
    NSString *sql = [NSString stringWithFormat:@"CREATE TABLE if not exists 'main'.'%d' ('id' INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL  UNIQUE , 'latitude' DOUBLE NOT NULL , 'longtitude' DOUBLE NOT NULL )", name];
    if ([self openDatabase]) {
        if (sqlite3_exec(m_database, [sql UTF8String], NULL, NULL, nil) == SQLITE_OK) {
            NSLog(@"create map table ok");
        }
        [self closeDatabase];
    }
}

-(void)insertOneLocationsArray:(NSArray *)locationsArray toMap:(int)mapTableName{
    char *errMsg;
    if ([self openDatabase]){
        for (CLLocation *location in locationsArray) {
            NSString *sql = [NSString stringWithFormat:@"insert into %d (latitude, longtitude) values ('%lf','%lf')",mapTableName, location.coordinate.latitude, location.coordinate.longitude];
            if (sqlite3_exec(m_database, [sql UTF8String], NULL, NULL, &errMsg) == SQLITE_OK) {
                NSLog(@"insert one location");
            }
        }
        [self closeDatabase];
    }
}

-(NSArray *)selectOneMapForLocationsArray:(int)mapTableName{
    NSString *sql = [NSString stringWithFormat:@"select latitude, longtitude from %d",mapTableName];
    NSLog(@"%@",sql);
    if ([self openDatabase]) {
        sqlite3_stmt *statement;
        NSMutableArray *tmpArray = [[NSMutableArray alloc] init];
        if (sqlite3_prepare_v2(m_database, [sql UTF8String], -1, &statement, nil) == SQLITE_OK) {
            NSLog(@"select map ok! ");
            while (sqlite3_step(statement) == SQLITE_ROW) {
                double latitude = sqlite3_column_double(statement, 0);
                double longtitude = sqlite3_column_double(statement, 1);
                CLLocation *location = [[CLLocation alloc] initWithLatitude:latitude longitude:longtitude];
                [tmpArray addObject:location];
                [location release];
            }
        }
        sqlite3_finalize(statement);
        [self closeDatabase];
        return [tmpArray autorelease];
    }
    return nil;
}

-(void)dealloc{
    [g_databaseManager release];
    [super dealloc];
}

@end
