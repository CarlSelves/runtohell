//
//  DataManager.h
//  Run and Roll
//
//  Created by Joaquin on 13-4-21.
//  Copyright (c) 2013年 Joaquin Hwang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"

@interface DataManager : NSObject
{
    sqlite3 *m_DataBase;
}

+ (DataManager*)getInstance;
- (void)openDatabase;

@end
