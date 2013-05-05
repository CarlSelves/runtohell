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
@property(nonatomic) int m_identify;
@property(nonatomic) int m_dateTimeStamp;
@property(nonatomic) float m_distance;
@property(nonatomic) int m_totalTime;
@property(nonatomic) float m_speed;
@property(nonatomic) int m_calorie;
@property(nonatomic) int m_status;
@property(nonatomic,strong) NSArray *m_record;
@property(nonatomic) int m_mapInfoTableName;
@property(nonatomic,strong) NSArray *m_locations;

@end
