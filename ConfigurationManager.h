//
//  ConfigurationManager.h
//  Run and Roll
//
//  Created by Joaquin on 13-1-25.
//  Copyright (c) 2013年 Joaquin Hwang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GDataXMLNode.h"

@interface ConfigurationManager : NSObject

+ (ConfigurationManager*)getInstance;
- (NSArray*)getMenuItem;

@end
