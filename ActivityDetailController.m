//
//  ActivityDetailController.m
//  Run and Roll
//
//  Created by Joaquin on 13-5-1.
//  Copyright (c) 2013年 Joaquin Hwang. All rights reserved.
//

#import "ActivityDetailController.h"


@implementation ActivityDetailController
@synthesize m_calorieLabel;
@synthesize m_distanceLabel;
@synthesize m_mapView;
@synthesize m_speedLabel;
@synthesize m_totalTimeLabel;
@synthesize m_activityInfo;


- (void)viewDidLoad
{
    [super viewDidLoad];

	// Do any additional setup after loading the view.
    NSLog(@"date:%d calorie:%d dist:%f mapinfoName:%d speed:%f totaltime:%d",m_activityInfo.m_dateTimeStamp, m_activityInfo.m_calorie, m_activityInfo.m_distance, m_activityInfo.m_mapInfoTableName, m_activityInfo.m_speed, m_activityInfo.m_totalTime);
    
    for (CLLocation *location in m_activityInfo.m_locations) {
        NSLog(@"lat:%f long:%f", location.coordinate.latitude, location.coordinate.longitude);
    }
    [self setMapRoute];
    
}

- (void)viewDidUnload {
    [self setM_distanceLabel:nil];
    [self setM_totalTimeLabel:nil];
    [self setM_calorieLabel:nil];
    [self setM_speedLabel:nil];
    [self setM_mapView:nil];
    [super viewDidUnload];
}

- (IBAction)doFinishRunning:(id)sender {
    [[DatabaseManager getInstance] createActivityInfo];
    [[DatabaseManager getInstance] insertOneActivity:m_activityInfo];
}

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id)overlay {
    MKOverlayView* overlayView = nil;
    m_polyLineView = [[MKPolylineView alloc] initWithPolyline:m_polyLine];
    m_polyLineView.fillColor = [UIColor redColor];
    m_polyLineView.strokeColor = [UIColor redColor];
    m_polyLineView.lineWidth = 10;
    overlayView = m_polyLineView;
    
    return overlayView;
}

- (void)setMapRoute {
    MKMapPoint northEastPoint = MKMapPointMake(0.f,0.f);
    MKMapPoint southWestPoint = MKMapPointMake(0.f,0.f);
    MKMapPoint *pointArray = malloc(sizeof(CLLocationCoordinate2D)*m_activityInfo.m_locations.count);
    
    for(int idx = 0; idx < m_activityInfo.m_locations.count; idx++)
    {
        CLLocation *location = [m_activityInfo.m_locations objectAtIndex:idx];
        
        CLLocationDegrees latitude  = location.coordinate.latitude;
        CLLocationDegrees longitude = location.coordinate.longitude;
        
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude, longitude);
        MKMapPoint point = MKMapPointForCoordinate(coordinate);
        
        if (idx == 0)
        {
            northEastPoint = point;
            southWestPoint = point;
        }
        else
        {
            if (point.x > northEastPoint.x)
                northEastPoint.x = point.x;
            if (point.y > northEastPoint.y)
                northEastPoint.y = point.y;
            if (point.x < southWestPoint.x)
                southWestPoint.x = point.x;
            if (point.y < southWestPoint.y)
                southWestPoint.y = point.y;
        }
        pointArray[idx] = point;
    }
    
    if (m_polyLine)
        [m_mapView removeOverlay:m_polyLine];
    
    m_polyLine = [MKPolyline polylineWithPoints:pointArray count:m_activityInfo.m_locations.count];
    
    if (nil != m_polyLine)
        [m_mapView addOverlay:m_polyLine];
    
    //处理缩放
//    CLLocation *firstLocation = [m_activityInfo.m_locations objectAtIndex:0];
//    MKCoordinateRegion region = MKCoordinateRegionMake(firstLocation.coordinate, MKCoordinateSpanMake(0.002, 0.002));
//    [m_mapView setRegion:[m_mapView regionThatFits:region] animated:YES];
    
    free(pointArray);
}

@end
