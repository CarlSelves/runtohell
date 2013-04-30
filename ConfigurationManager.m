//
//  ConfigurationManager.m
//  Run and Roll
//
//  Created by Carl on 13-1-25.
//  Copyright (c) 2013年 Carl Hwang. All rights reserved.
//

#import "ConfigurationManager.h"

@implementation ConfigurationManager

+ (ConfigurationManager*)getInstance
{
    static dispatch_once_t pred = 0;
    __strong static ConfigurationManager *_sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init]; // or some other init method
    });
    return _sharedObject;
}

- (NSArray*)getMenuItem
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"MainMenu" ofType:@"xml"];
    NSData *xmlData = [[NSData alloc] initWithContentsOfFile:filePath];
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:xmlData options:0 error:nil];
    GDataXMLElement *rootElement = [doc rootElement];
    NSArray *menuItems = [rootElement elementsForName:@"MenuItem"];
    return menuItems;
}

//余留问题，单例模式，何时释放申请的内存

@end
