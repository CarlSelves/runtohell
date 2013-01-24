//
//  HomeViewController.m
//  Run and Roll
//
//  Created by Joaquin on 13-1-24.
//  Copyright (c) 2013年 Joaquin Hwang. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController


- (IBAction)revealMenu:(id)sender
{
    [self.slidingViewController anchorTopViewTo:ECRight];
}


@end
