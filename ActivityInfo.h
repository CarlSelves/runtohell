//
//  ActivityInfo.h
//  Run and Roll
//
//  Created by Joaquin on 13-4-30.
//  Copyright (c) 2013年 Joaquin Hwang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Defines.h"

@interface ActivityInfo : NSObject {
    int m_identify;
    int m_dateTimeStamp;
    float m_distance;
    int m_totalTime;
    float m_speed;
    int m_calorie;
    int m_status;
    NSArray *m_record;
    int m_mapInfoTableName;
    NSArray *m_locations;
}
@property(nonatomic,assign) int m_identify;
@property(nonatomic,assign) int m_dateTimeStamp;
@property(nonatomic,assign) float m_distance;
@property(nonatomic,assign) int m_totalTime;
@property(nonatomic,assign) float m_speed;
@property(nonatomic,assign) int m_calorie;
@property(nonatomic,assign) int m_status;
@property(nonatomic,strong) NSArray *m_record;
@property(nonatomic,assign) int m_mapInfoTableName;
@property(nonatomic,strong) NSArray *m_locations;

@end
