//
//  PlayListController.m
//  Run and Roll
//
//  Created by Joaquin on 13-4-20.
//  Copyright (c) 2013年 Joaquin Hwang. All rights reserved.
//

#import "PlayListController.h"

@interface PlayListController ()

@end

@implementation PlayListController
@synthesize m_playList;
@synthesize m_albumTitle;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [m_playList count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id key = [m_albumTitle objectAtIndex:section];
    return [[m_playList objectForKey:key] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger iSection = indexPath.section;
    NSInteger iRow = indexPath.row;
    
    id key = [m_albumTitle objectAtIndex:iSection];
    NSArray *items = (NSArray *)[m_playList objectForKey:key];
    
    static NSString *CellIdentifier = @"PlayListCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    cell.textLabel.text = [[items objectAtIndex:iRow] valueForProperty:MPMediaItemPropertyTitle];
    cell.detailTextLabel.text = [[items objectAtIndex:iRow] valueForProperty:MPMediaItemPropertyArtist];
    return cell;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *label = [[UILabel alloc] init];
    NSString *albumTitle = [m_albumTitle objectAtIndex:section];

    [label setTextAlignment:UITextAlignmentLeft];
    [label setText:albumTitle];
    [label setTextColor:[UIColor whiteColor]];
    [label setBackgroundColor:[UIColor scrollViewTexturedBackgroundColor]];
    return label;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSInteger iSection = indexPath.section;
        NSInteger iRow = indexPath.row;
        id key = [m_albumTitle objectAtIndex:iSection];
        NSMutableArray *tmpArray = [m_playList objectForKey:key];
        [tmpArray removeObjectAtIndex:iRow];
        [m_playList setObject:tmpArray forKey:key];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.delegate updatePlayList:m_playList];
    }
}
@end
