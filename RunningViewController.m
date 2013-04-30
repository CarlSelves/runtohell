//
//  RunningViewController.m
//  Run and Roll
//
//  Created by Carl on 13-2-7.
//  Copyright (c) 2013年 Carl Hwang. All rights reserved.
//

#import "RunningViewController.h"

@interface RunningViewController ()

@end

#pragma mark - Defines
typedef int LayoutCode;

//Layout Code
const LayoutCode INRUN_MUSIC = 1;
const LayoutCode INRUN_NOMSC = 2;
const LayoutCode PAUSE_MUSIC = 3;
const LayoutCode PAUSE_NOMSC = 4;

typedef int CheckMarkCellType;

const CheckMarkCellType NONE = 1;
const CheckMarkCellType NOW = 2;
const CheckMarkCellType PLAYLIST = 3;

@implementation RunningViewController

//music info
@synthesize musicTitleLabel;
@synthesize prevButton;
@synthesize nextButton;
@synthesize changeButton;
@synthesize addMusicButton;

//running info
@synthesize totalDistanceLabel;
@synthesize timerLabel;
@synthesize speedLabel;
@synthesize lastMinuteDistanceLabel;

@synthesize mapView;
@synthesize mapViewBackButton;

//running info title
@synthesize milePresentLabel;
@synthesize timerPresentImage;
@synthesize speedPresentImage;
@synthesize lastMinutePresentLabel;

//helper
@synthesize scrollView;
@synthesize pauseButton;
@synthesize mainLogoImage;

- (void)viewDidLoad
{
    [super viewDidLoad];
    locationModule = [[LocationModule alloc] init];

    
    [self widgetInit];
    [self timerInit];
    /*--注释1holder--*/
}

//控件初始化
- (void)widgetInit
{
    //scrollView Initialize
    scrollView.contentSize = CGSizeMake(320*2, 320);

    //mapView Initialize
    mapView = locationModule.mapView;
    
    //mapViewBackButton Initialize
    mapViewBackButton= [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 73, 43)];
    [mapViewBackButton addTarget:self action:@selector(btnSetOffset:) forControlEvents:UIControlEventTouchUpInside];
    [mapViewBackButton setImage:[UIImage imageNamed:@"IMG_0748.JPG"] forState:UIControlStateNormal];
    
    [scrollView addSubview:self.mapView];
    [mapView addSubview:self.mapViewBackButton];
        
    [self setWidgetLayout:INRUN_NOMSC];
     
}

//选择不同状态下的控件组
- (void)setWidgetLayout:(LayoutCode)code
{
    switch (code) {
        case INRUN_NOMSC:
            prevButton.hidden = YES;
            nextButton.hidden = YES;
            changeButton.hidden = YES;
            addMusicButton.hidden = YES;
            break;
        case INRUN_MUSIC:
            prevButton.hidden = YES;
            nextButton.hidden = YES;
            changeButton.hidden = YES;
            addMusicButton.hidden = YES;
            break;
        case PAUSE_NOMSC:
            prevButton.hidden = YES;
            nextButton.hidden = YES;
            changeButton.hidden = YES;
            addMusicButton.hidden = NO;
            break;
        case PAUSE_MUSIC:
            prevButton.hidden = NO;
            nextButton.hidden = NO;
            changeButton.hidden = NO;
            addMusicButton.hidden = YES;
            break;
        default:
            break;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString *id = [segue identifier];
    if ([id isEqualToString:@"Music1"] || [id isEqualToString:@"Music2"]) {
        UINavigationController *navigationController = segue.destinationViewController;
        MusicTableViewController *musicController = [[navigationController viewControllers] objectAtIndex:0];
        musicController.delegate = self;
        musicController.m_checkMarkCellType = NONE;
    }
}

#pragma mark - Timer
- (void)timerInit
{
    timerMinute = timerSecond = 0;
    [NSTimer scheduledTimerWithTimeInterval:(1.f) target:self selector:@selector(timerAdvance:) userInfo:nil repeats:YES];
}

- (void)timerAdvance:(NSTimer*)timer{
    timerSecond++;
    if(timerSecond >= 60)
    {
        timerMinute++;
        timerSecond=0;
    }
    timerLabel.text = [NSString stringWithFormat:@"%.2d:%.2d", timerMinute, timerSecond];
}
#pragma mark - Timer - end

- (IBAction)btnSetOffset:(id)sender {
    [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}

#pragma mark - MusicController delegate
- (void)musicControllerDidCancel:(MusicTableViewController *)controller
{
    [controller dismissModalViewControllerAnimated:YES];
}
- (void)musicControllerDidDone:(MusicTableViewController *)controller
{
    
}

- (void)viewDidUnload {
    [self setTotalDistanceLabel:nil];
    [self setChangeButton:nil];
    [self setAddMusicButton:nil];
    [super viewDidUnload];
}
- (IBAction)pauseRunning:(id)sender {
    [self setWidgetLayout:PAUSE_NOMSC];
}
@end


/*------------------文件输出写法-------------------------------/
 NSFileManager *fileManager = [NSFileManager defaultManager];
 NSArray *directoryPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
 documentDirectory = [directoryPaths objectAtIndex:0];
 NSString *didUpdateToLocationfilePath = [documentDirectory stringByAppendingPathComponent:@"didUpdateLog.txt"];
 NSString *viewForOverLayfilePath= [documentDirectory stringByAppendingPathComponent:@"viewForOverlayLog.txt"];
 if (![fileManager fileExistsAtPath:didUpdateToLocationfilePath]) {
 [fileManager createFileAtPath:didUpdateToLocationfilePath contents:nil attributes:nil];
 }
 if (![fileManager fileExistsAtPath:viewForOverLayfilePath]) {
 [fileManager createFileAtPath:viewForOverLayfilePath contents:nil attributes:nil];
 }
 
 NSString *string2 = [NSString stringWithFormat:@"count of locationsArray is %d \n", locationsArray.count];
 NSString *string3 = @"---------------out didUpdateToLocation-----------------\n";
 //NSMutableData *writer = [[NSMutableData alloc] init];
 [writerLocation appendData:[string1 dataUsingEncoding:NSUTF8StringEncoding]];
 [writerLocation appendData:[string2 dataUsingEncoding:NSUTF8StringEncoding]];
 [writerLocation appendData:[string3 dataUsingEncoding:NSUTF8StringEncoding]];
------------------文件输出写法-------------------------------*/
