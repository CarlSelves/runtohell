//
//  DataManager.m
//  Run and Roll
//
//  Created by Joaquin on 13-5-5.
//  Copyright (c) 2013年 Joaquin Hwang. All rights reserved.
//

#import "DataManager.h"
#import "DatabaseManager.h"

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

-(void)getAndSaveAllActInfo{
    self.allActivityInfo = [[DatabaseManager getInstance] selectAllActivities];
    //ActivityInfo *oneActInfo = [self.allActivityInfo objectAtIndex:0];
    //NSLog(@"data:%d distance:%f time:%d speed:%f colorie:%d status:%d",oneActInfo.m_dateTimeStamp,oneActInfo.m_distance, oneActInfo.m_totalTime, oneActInfo.m_speed, oneActInfo.m_calorie, oneActInfo.m_status);
}

-(NSArray *)getAllActInfo{
    return self.allActivityInfo;
}

@end
