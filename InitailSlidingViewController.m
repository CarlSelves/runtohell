//
//  InitailSlidingViewController.m
//  Run and Roll
//
//  Created by Carl on 13-1-23.
//  Copyright (c) 2013年 Carl Hwang. All rights reserved.
//

#import "InitailSlidingViewController.h"
#import "DatabaseManager.h"

@interface InitailSlidingViewController ()

@end

@implementation InitailSlidingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    self.topViewController = [storyboard instantiateViewControllerWithIdentifier:@"Home"];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
