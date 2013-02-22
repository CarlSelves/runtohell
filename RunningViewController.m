//
//  RunningViewController.m
//  Run and Roll
//
//  Created by Joaquin on 13-2-7.
//  Copyright (c) 2013年 Joaquin Hwang. All rights reserved.
//

#import "RunningViewController.h"

@interface RunningViewController ()

@end

@implementation RunningViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    locationsArray = [[NSMutableArray alloc] init];
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = 5.f;
    
    [locationManager startUpdatingLocation];
    
    timerMinute = timerSecond = 0;
    distance = 0.0;
    lastAvailableLocation = nil;
    [NSTimer scheduledTimerWithTimeInterval:(1.f) target:self selector:@selector(timerAdvance:) userInfo:nil repeats:YES];
}

- (void)timerAdvance:(NSTimer*)timer
{
    timerSecond++;
    if(timerSecond >= 60)
    {
        timerMinute++;
        timerSecond=0;
    }
    if (timerSecond < 10) 
         self.totalTimeLabel.text = [NSString stringWithFormat:@"%d:0%d", timerMinute, timerSecond];
    else
         self.totalTimeLabel.text = [NSString stringWithFormat:@"%d:%d", timerMinute, timerSecond];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setMapView:nil];
    [self setTotalTimeLabel:nil];
    [self setAvgSpeedLabel:nil];
    [self setTotalDistanceLabel:nil];
    [super viewDidUnload];
}

- (void)setMapRoute
{
    MKMapPoint northEastPoint = MKMapPointMake(0.f,0.f);
    MKMapPoint southWestPoint = MKMapPointMake(0.f,0.f);
    MKMapPoint *pointArray = malloc(sizeof(CLLocationCoordinate2D) *locationsArray.count);
    
    for(int idx = 0; idx < locationsArray.count; idx++)
    {
        CLLocation *location = [locationsArray objectAtIndex:idx];
        
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
    
    if (self.routeLine)
        [self.mapView removeOverlay:self.routeLine];
    
    self.routeLine = [MKPolyline polylineWithPoints:pointArray count:locationsArray.count];
    
    if (nil != self.routeLine)
        [self.mapView addOverlay:self.routeLine];   
    
    free(pointArray);
}

#pragma mark - MKMapView Delegate
- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id<MKOverlay>)overlay
{
    MKOverlayView* overlayView = nil;
    if(overlay == self.routeLine)
    {
        //if we have not yet created an overlay view for this overlay, create it now.
        if(nil == self.routeLineView)
        {
            self.routeLineView = [[MKPolylineView alloc] initWithPolyline:self.routeLine];
            self.routeLineView.fillColor = [UIColor redColor];
            self.routeLineView.strokeColor = [UIColor redColor];
            self.routeLineView.lineWidth = 3;
        }
        overlayView = self.routeLineView;
    }
    return overlayView;
}

#pragma mark - CLLocationManager Delegate
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    if(newLocation.coordinate.latitude == 0.0f || newLocation.coordinate.longitude == 0.0f)
        return;
    
    double newDistance = [newLocation distanceFromLocation:lastAvailableLocation];
    
    if (lastAvailableLocation == nil) {
        lastAvailableLocation = newLocation;
        [locationsArray addObject:newLocation];
    }
    
    if (newDistance >= 5.0f) {
        distance += newDistance;
        lastAvailableLocation = newLocation;
        [locationsArray addObject:newLocation];
        //[self updateLocation];
        
        // create the overlay
        [self setMapRoute];
        
        // zoom in on the route.
        //[self zoomInOnRoute];
    }
    self.totalDistanceLabel.text = [NSString stringWithFormat:@"%.2f", distance];

}

@end
