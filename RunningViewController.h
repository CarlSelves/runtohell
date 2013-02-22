//
//  RunningViewController.h
//  Run and Roll
//
//  Created by Joaquin on 13-2-7.
//  Copyright (c) 2013年 Joaquin Hwang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface RunningViewController : UIViewController<MKMapViewDelegate, CLLocationManagerDelegate>
{
    NSMutableArray *locationsArray;
    CLLocationManager *locationManager;
    int timerMinute;
    int timerSecond;
    double distance;
    CLLocation *lastAvailableLocation;
}

@property (nonatomic) MKPolyline *routeLine;
@property (nonatomic) MKPolylineView *routeLineView;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UILabel *totalTimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *totalDistanceLabel;
@property (strong, nonatomic) IBOutlet UILabel *avgSpeedLabel;

- (void) setMapRoute;
@end
