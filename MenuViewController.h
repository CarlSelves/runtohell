//
//  MenuViewController.h
//  Run and Roll
//
//  Created by Joaquin on 13-1-25.
//  Copyright (c) 2013年 Joaquin Hwang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ECSlidingViewController.h"
#import "ConfigurationManager.h"
#import "GDataXMLNode.h"
#import "MainMenuCell.h"

@interface MenuViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSArray* menuItems;
}
@property (strong, nonatomic) IBOutlet UITableView *MovetableView;
@property (strong, nonatomic) IBOutlet UITableView *UnmovetableView;

@end
