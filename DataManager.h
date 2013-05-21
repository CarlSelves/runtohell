//
//  DataManager.h
//  Run and Roll
//
//  Created by Joaquin on 13-5-5.
//  Copyright (c) 2013年 Joaquin Hwang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataManager : NSObject

@property (nonatomic, strong) NSArray *allActivityInfo;

+(DataManager *)getInstance;
-(void)getAndSaveAllActInfo;
-(NSArray *)getAllActInfo;

@end
