//
//  HomeNavigationController.m
//  Run and Roll
//
//  Created by Carl on 13-1-25.
//  Copyright (c) 2013年 Carl Hwang. All rights reserved.
//

#import "HomeNavigationController.h"

@interface HomeNavigationController ()

@end

@implementation HomeNavigationController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
	// Do any additional setup after loading the view.
    if (![self.slidingViewController.underLeftViewController isKindOfClass:[MenuViewController class]]) {
        self.slidingViewController.underLeftViewController  = [self.storyboard instantiateViewControllerWithIdentifier:@"Menu"];
    }
    
    self.slidingViewController.underRightViewController = nil;
    self.slidingViewController.anchorLeftPeekAmount     = 0;
    self.slidingViewController.anchorLeftRevealAmount   = 0;
    
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
}


@end
