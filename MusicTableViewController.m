//
//  MusicTableViewController.m
//  Run and Roll
//
//  Created by Carl on 13-4-19.
//  Copyright (c) 2013年 Carl Hwang. All rights reserved.
//

#import "MusicTableViewController.h"

@interface MusicTableViewController ()

@end

@implementation MusicTableViewController
@synthesize m_playerList;
@synthesize m_checkMarkCellType;

- (void)viewDidLoad
{
    [super viewDidLoad];
    switch (m_checkMarkCellType) {
        case 1:
            m_checkMarkEnableCell = m_noneMusicCell;
            break;
        case 2:
            m_checkMarkEnableCell = m_nowPlayingCell;
            break;
        case 3:
            m_checkMarkEnableCell = m_playerListCell;
            break;
        default:
            break;
    }
    m_checkMarkEnableCell.accessoryType = UITableViewCellAccessoryCheckmark;
    m_playerList = [[NSArray alloc] init];
    [self initActIndicatorView];    
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = (UITableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    int iSection = indexPath.section;
    int iRow = indexPath.row;

    if (iSection == 0){
        if (iRow == 0){

        }
    }else if (iSection == 1) {
        if (iRow == 0) {
            
        } else if (iRow == 1) {

        }
    }else if (iSection == 2) {
        if (iRow == 0) {
            if (actIndicatorView) {
                [actIndicatorView startAnimating];
                [self gotoMusicPickerController];
                //[actIndicatorView stopAnimating];
            }
            
        }
    }
    [self setCellCheckMarkEnable:cell];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    return;
}

#pragma mark - MediaPicker delagate

- (void)mediaPicker:(MPMediaPickerController *)mediaPicker didPickMediaItems:(MPMediaItemCollection *)mediaItemCollection
{
    self.m_playerList = [self removeRepeatItems:[mediaItemCollection items]];
    m_playerListCell.accessoryType = UITableViewCellAccessoryCheckmark;
    [actIndicatorView stopAnimating];
    [self updateSongsNum];
    [mediaPicker dismissModalViewControllerAnimated:YES];
}

- (void)mediaPickerDidCancel:(MPMediaPickerController *)mediaPicker
{
    m_checkMarkEnableCell.accessoryType = UITableViewCellAccessoryCheckmark;
    [actIndicatorView stopAnimating];
    [mediaPicker dismissModalViewControllerAnimated:YES];
}

#pragma mark - PlayListController delegate

- (void)updatePlayList:(NSMutableDictionary *)playList
{
    NSArray *keys = [playList allKeys];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (id key in keys) {
        [array addObjectsFromArray:[playList objectForKey:key]];
    }
    m_playerList = array;
    [self updateSongsNum];
}

#pragma mark - member function

- (void)updateSongsNum
{
    m_playerListCell.detailTextLabel.text = [NSString stringWithFormat:@"%d首歌曲", [m_playerList count]];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"PlayList"]) {
        PlayListController *playListController = segue.destinationViewController;
        
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        NSMutableArray *array = [[NSMutableArray alloc] init];
        
        for (MPMediaItem *item in m_playerList) {
            id key = [item valueForProperty:MPMediaItemPropertyAlbumTitle];
            NSMutableArray *tmpArray = [dict objectForKey:key];
            if (!tmpArray) {
                tmpArray = [[NSMutableArray alloc] init];
                [array addObject:key];
            }
            [tmpArray addObject:item];
            [dict setObject:tmpArray forKey:key];
        }
        
        playListController.delegate = self;
        playListController.m_playList = dict;
        playListController.m_albumTitle = array;
    }
}

- (NSArray *)removeRepeatItems:(NSArray *)array
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    for (MPMediaItem *item in array) {
        [dict setObject:item forKey:[item valueForProperty:MPMediaItemPropertyTitle]];
    }
    NSArray *resArray = [dict allValues];
    return resArray;
}

- (void)gotoMusicPickerController
{
    MPMediaPickerController *picker = [[MPMediaPickerController alloc] initWithMediaTypes:MPMediaTypeMusic];
    picker.delegate = self;
    picker.prompt = @"选择你的跑步歌曲";
    picker.title = @"Music Library";
    picker.allowsPickingMultipleItems = YES;
    [self presentModalViewController:picker animated:YES];
}

- (void)setCellCheckMarkEnable:(UITableViewCell*)cell
{
    if (cell != m_playerListCell) {
        m_playerListCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if (cell != m_nowPlayingCell) {
        m_nowPlayingCell.accessoryType = UITableViewCellAccessoryNone;
    }
    if (cell != m_noneMusicCell) {
        m_noneMusicCell.accessoryType = UITableViewCellAccessoryNone;
    }
    if (cell != m_musicLibraryCell) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        m_checkMarkEnableCell = cell;
    }  
}

- (void)initActIndicatorView
{
    actIndicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 120.f, 120.f)];
    [actIndicatorView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
    CGSize size = self.view.frame.size;
    [actIndicatorView setCenter:CGPointMake(size.width/2, size.height/2-50)];
    [actIndicatorView setBackgroundColor:[UIColor blackColor]];
    [actIndicatorView setAlpha:0.7];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20.f, 90.f, 80.f, 20.f)];
    label.text = @"正在读取音乐库";
    [label setTextColor:[UIColor whiteColor]];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setFont:[UIFont boldSystemFontOfSize:11]];
    [label setTextAlignment:UITextAlignmentCenter];
    [actIndicatorView addSubview:label];
    actIndicatorView.layer.cornerRadius = 6.0;
    [self.view addSubview:actIndicatorView];
}

- (void)viewDidUnload {
    m_playerListCell = nil;
    m_nowPlayingCell = nil;
    m_noneMusicCell = nil;
    [super viewDidUnload];
}
- (IBAction)didCancel:(id)sender {
    [self.delegate musicControllerDidCancel:self];
}

- (IBAction)didDone:(id)sender {
}
@end
