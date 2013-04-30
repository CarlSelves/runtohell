//
//  MusicTableViewController.h
//  Run and Roll
//
//  Created by Carl on 13-4-19.
//  Copyright (c) 2013年 Carl Hwang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <QuartzCore/QuartzCore.h>
#import "PlayListController.h"


@class MusicTableViewController;

@protocol MusicControllerDelegate <NSObject>
- (void)musicControllerDidCancel:(MusicTableViewController *)controller;
- (void)musicControllerDidDone:(MusicTableViewController *)controller;

@end

@interface MusicTableViewController : UITableViewController<MPMediaPickerControllerDelegate, PlayListControllerDelegate>
{
    NSArray *m_playerList;
    UITableViewCell *m_checkMarkEnableCell;
    int m_checkMarkCellType;
    UIActivityIndicatorView *actIndicatorView;
    
    IBOutlet UITableViewCell *m_playerListCell;
    IBOutlet UITableViewCell *m_nowPlayingCell;
    IBOutlet UITableViewCell *m_noneMusicCell;
    IBOutlet UITableViewCell *m_musicLibraryCell;
}
@property (nonatomic,weak) id <MusicControllerDelegate> delegate;
@property (nonatomic,strong) NSArray *m_playerList;
@property (nonatomic) int m_checkMarkCellType;

- (IBAction)didCancel:(id)sender;
- (IBAction)didDone:(id)sender;

@end
