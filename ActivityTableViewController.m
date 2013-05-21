//
//  ActivityTableViewController.m
//  Run and Roll
//
//  Created by Carl on 13-1-28.
//  Copyright (c) 2013年 Carl Hwang. All rights reserved.
//

#import "ActivityTableViewController.h"
#import "DataManager.h"
#import "ActivityCell.h"
#import "ActivityInfo.h"


@implementation ActivityTableViewController
@synthesize m_DateSetForMonth;
@synthesize m_MonthSet;

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSArray *AllActInfo = [[DataManager getInstance] getAllActInfo];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    for (ActivityInfo *act in AllActInfo) {
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:act.m_dateTimeStamp];
        NSString *dateStr = [formatter stringFromDate:date];
        BOOL has
        for (NSString *str in m_MonthSet) {
            if ([str isEqualToString:dateStr]) {
                <#statements#>
            }
        }
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[DataManager getInstance] getAllActInfo] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ActivityCell";
    ActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    ActivityInfo *act = [[[DataManager getInstance] getAllActInfo] objectAtIndex:indexPath.row];
    
    cell.m_DateLabel.text = [NSString stringWithFormat:@"%d",act.m_dateTimeStamp];
    cell.m_DistanceLabel.text = [NSString stringWithFormat:@"%f", act.m_distance];
    cell.m_SpeedLabel.text = [NSString stringWithFormat:@"%f",act.m_speed];
    cell.m_TimeLabel.text = [NSString stringWithFormat:@"%d", act.m_totalTime];   
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

- (IBAction)revealMenu:(id)sender
{
    [self.slidingViewController anchorTopViewTo:ECRight];
}
@end
