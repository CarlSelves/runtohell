//
//  RunningViewController.h
//  Run and Roll
//
//  Created by Carl on 13-2-7.
//  Copyright (c) 2013年 Carl Hwang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "LocationModule.h"
#import "MusicTableViewController.h"
#import "ActivityDetailController.h"

@interface RunningViewController : UIViewController<MusicControllerDelegate,LocationModuleDelegate>
{
    int timerMinute;
    int timerSecond;
    ActivityInfo *activityInfo;
    LocationModule *locationModule;
    int startTimestamp;
}
@property (nonatomic,strong) ActivityInfo *activityInfo;

//music info
@property (nonatomic, strong) IBOutlet UILabel *musicTitleLabel;
@property (nonatomic, strong) IBOutlet UIButton *prevButton;
@property (nonatomic, strong) IBOutlet UIButton *changeButton;
@property (nonatomic, strong) IBOutlet UIButton *nextButton;
@property (strong, nonatomic) IBOutlet UIButton *addMusicButton;

//running info
@property (strong, nonatomic) IBOutlet UILabel *totalDistanceLabel;
@property (nonatomic, strong) IBOutlet UILabel *timerLabel;
@property (nonatomic, strong) IBOutlet UILabel *speedLabel;
@property (nonatomic, strong) IBOutlet UILabel *lastMinuteDistanceLabel;

@property (strong, nonatomic) IBOutlet UIButton *continueButton;
@property (strong, nonatomic) IBOutlet UIButton *finishButton;

@property (nonatomic, strong) MKMapView *mapView;
@property (nonatomic, strong) UIButton *mapViewBackButton;

//running info title
@property (nonatomic, strong) IBOutlet UILabel *milePresentLabel;
@property (nonatomic, strong) IBOutlet UIImageView *timerPresentImage;
@property (nonatomic, strong) IBOutlet UIImageView*speedPresentImage;
@property (nonatomic, strong) IBOutlet UILabel *lastMinutePresentLabel;

//helper
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) IBOutlet UIButton *pauseButton;
@property (nonatomic, strong) IBOutlet UIImageView *mainLogoImage;

//button respond
- (IBAction)pauseRunning:(id)sender;
- (IBAction)continueRunning:(id)sender;
- (IBAction)finishRunning:(id)sender;

@end