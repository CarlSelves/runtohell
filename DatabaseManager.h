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

+ (DatabaseManager*)getInstance;
- (void)insertOneActivity:(ActivityInfo *)activity;
- (void)createActivityInfo;

@end
