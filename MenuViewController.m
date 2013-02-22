//
//  MenuViewController.m
//  Run and Roll
//
//  Created by Joaquin on 13-1-25.
//  Copyright (c) 2013年 Joaquin Hwang. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.slidingViewController setAnchorRightRevealAmount:260.0f];
    self.slidingViewController.underLeftWidthLayout = ECFullWidth;
    
    menuItems = [[ConfigurationManager getInstance] getMenuItem];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger number = 0;
    if (tableView == self.MovetableView)
        number = [menuItems count] - 1;
    else if (tableView == self.UnmovetableView)
        number = 1;
    return number;
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MainMenuCell";
    MainMenuCell *cell = (MainMenuCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    NSLog(@"indexpathrow:%d", indexPath.row);
    if (tableView == self.MovetableView)
    {
        cell.menuLabel.text = [[[[menuItems objectAtIndex:indexPath.row + 1] elementsForName:@"Title"] objectAtIndex:0] stringValue];
    }
    else if (tableView == self.UnmovetableView)
    {
        cell.menuLabel.text = [[[[menuItems objectAtIndex:indexPath.row] elementsForName:@"Title"] objectAtIndex:0] stringValue];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier;
    if (tableView == self.UnmovetableView)
    {
        identifier = [[[[menuItems objectAtIndex:indexPath.row] elementsForName:@"Title"] objectAtIndex:0] stringValue];
    }
    else if (tableView == self.MovetableView)
    {
        identifier = [[[[menuItems objectAtIndex:indexPath.row + 1] elementsForName:@"Title"] objectAtIndex:0] stringValue];

    }
    
    UIViewController *newTopViewController = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
    
    [self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
        CGRect frame = self.slidingViewController.topViewController.view.frame;
        self.slidingViewController.topViewController = newTopViewController;
        self.slidingViewController.topViewController.view.frame = frame;
        [self.slidingViewController resetTopView];
    }];
}

@end
