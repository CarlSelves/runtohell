//
//  ActivityDetailController.h
//  Run and Roll
//
//  Created by Joaquin on 13-5-1.
//  Copyright (c) 2013年 Joaquin Hwang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "ActivityInfo.h"
#import "LocationModule.h"
#import "DatabaseManager.h"

@interface ActivityDetailController : UIViewController<MKMapViewDelegate> {
    ActivityInfo *m_activityInfo;
    MKMapView *m_mapView;
    MKPolyline *m_polyLine;
    MKPolylineView *m_polyLineView;
}
@property (strong, nonatomic) IBOutlet UILabel *m_distanceLabel;
@property (strong, nonatomic) IBOutlet UILabel *m_totalTimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *m_calorieLabel;
@property (strong, nonatomic) IBOutlet UILabel *m_speedLabel;
@property (strong, nonatomic) IBOutlet MKMapView *m_mapView;

@property (nonatomic,strong) ActivityInfo *m_activityInfo;

- (IBAction)doFinishRunning:(id)sender;

@end
