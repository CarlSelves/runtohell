//
//  ActivityNavigationController.m
//  Run and Roll
//
//  Created by Joaquin on 13-1-28.
//  Copyright (c) 2013年 Joaquin Hwang. All rights reserved.
//

#import "ActivityNavigationController.h"

@interface ActivityNavigationController ()

@end

@implementation ActivityNavigationController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (![self.slidingViewController.underLeftViewController isKindOfClass:[MenuViewController class]]) {
        self.slidingViewController.underLeftViewController  = [self.storyboard instantiateViewControllerWithIdentifier:@"Menu"];
    }
    
    self.slidingViewController.underRightViewController = nil;
    self.slidingViewController.anchorLeftPeekAmount     = 0;
    self.slidingViewController.anchorLeftRevealAmount   = 0;
    
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
}


@end
