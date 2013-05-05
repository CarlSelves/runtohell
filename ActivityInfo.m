//
//  ActivityInfo.m
//  Run and Roll
//
//  Created by Joaquin on 13-4-30.
//  Copyright (c) 2013年 Joaquin Hwang. All rights reserved.
//

#import "ActivityInfo.h"

@implementation ActivityInfo
@synthesize m_calorie;
@synthesize m_dateTimeStamp;
@synthesize m_distance;
@synthesize m_record;
@synthesize m_identify;
@synthesize m_mapInfoTableName;
@synthesize m_speed;
@synthesize m_status;
@synthesize m_totalTime;
@synthesize m_locations;

-(id)init{
    self = [super init];
    if (nil != self) {
        m_record = nil;
        m_locations = nil;
    }
    return self;
}
@end
