//
//  ConfigurationManager.h
//  Run and Roll
//
//  Created by Carl on 13-1-25.
//  Copyright (c) 2013年 Carl Hwang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GDataXMLNode.h"

@interface ConfigurationManager : NSObject

+ (ConfigurationManager*)getInstance;
- (NSArray*)getMenuItem;

@end
