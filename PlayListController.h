//
//  PlayListController.h
//  Run and Roll
//
//  Created by Joaquin on 13-4-20.
//  Copyright (c) 2013年 Joaquin Hwang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@class PlayListController;

@protocol PlayListControllerDelegate <NSObject>
- (void)updatePlayList:(NSMutableDictionary *)playList;
@end

@interface PlayListController : UITableViewController
{
    NSMutableDictionary *m_playList;
    NSMutableArray *m_albumTitle;
}
@property (nonatomic,weak) id <PlayListControllerDelegate> delegate;
@property (nonatomic,strong) NSMutableDictionary *m_playList;
@property (nonatomic,strong) NSMutableArray *m_albumTitle;

@end
