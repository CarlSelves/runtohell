//
//  DatabaseManager.h
//  Run and Roll
//
//  Created by Joaquin on 13-4-21.
//  Copyright (c) 2013年 Joaquin Hwang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"
#import "ActivityInfo.h"

@interface DatabaseManager : NSObject
{
    sqlite3 *m_database;
}

+(DatabaseManager*)getInstance;

-(void)insertOneActivity:(ActivityInfo *)activity;
-(void)createActivityInfo;
-(void)dropActivityInfo;
-(NSArray *)selectAllActivities;

-(void)createRecordTable;
-(void)insertOneRecordByType:(int)type andTimestamp:(int)timestamp;
-(NSArray *)selectRecordsByTimestamp:(int)timestamp;

-(void)createMapTableByName:(int)name;
-(void)insertOneLocationsArray:(NSArray *)locationsArray toMap:(int)mapTableName;
-(NSArray *)selectOneMapForLocationsArray:(int)mapTableName;

@end
