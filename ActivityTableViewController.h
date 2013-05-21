//
//  ActivityTableViewController.h
//  Run and Roll
//
//  Created by Carl on 13-1-28.
//  Copyright (c) 2013年 Carl Hwang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ECSlidingViewController.h"

@interface ActivityTableViewController : UITableViewController
{
    NSMutableArray *m_MonthSet;
    NSMutableDictionary *m_DateSetForMonth;
}
- (IBAction)revealMenu:(id)sender;
@property (nonatomic,strong) NSMutableArray *m_MonthSet;
@property (nonatomic,strong) NSMutableDictionary *m_DateSetForMonth;

@end
