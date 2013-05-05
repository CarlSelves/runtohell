//
//  LocationModule.m
//  Run and Roll
//
//  Created by Carl on 13-3-31.
//  Copyright (c) 2013年 Carl Hwang. All rights reserved.
//

#import "LocationModule.h"

@implementation LocationModule
@synthesize mapView;
@synthesize totalDist;
@synthesize locationsArray;

- (LocationModule*) init
{
    mapView = [[MKMapView alloc] initWithFrame:CGRectMake(320, 0, 320, 320)];
    mapView.delegate = self;
    mapView.showsUserLocation = YES;
    locationsArray = [[NSMutableArray alloc] init];
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = 0.1f;
    [locationManager startUpdatingLocation];
    
    CLLocationCoordinate2D coords;
    coords.latitude = 37.322222;
    coords.longitude = -122.0333;
    MKCoordinateRegion region = MKCoordinateRegionMake(coords, MKCoordinateSpanMake(20, 20));
    [mapView setRegion:[mapView regionThatFits:region] animated:YES];
    
    lastAvailableLocation = nil;
    totalDist = 0.f;
    isFirstDist = YES;
    
    return self;
}

- (void)setMapRoute {
    MKMapPoint northEastPoint = MKMapPointMake(0.f,0.f);
    MKMapPoint southWestPoint = MKMapPointMake(0.f,0.f);
    MKMapPoint *pointArray = malloc(sizeof(CLLocationCoordinate2D)*locationsArray.count);
    
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
//改动两处，1.（id<MKOverlay> -> id）2.取消两层if判断后成功，具体原因2者其1待定
- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id)overlay {
    MKOverlayView* overlayView = nil;
    self.routeLineView = [[MKPolylineView alloc] initWithPolyline:self.routeLine];
    self.routeLineView.fillColor = [UIColor redColor];
    self.routeLineView.strokeColor = [UIColor redColor];
    self.routeLineView.lineWidth = 3;
    overlayView = self.routeLineView;
    
    return overlayView;
}

#pragma mark - CLLocationManager Delegate
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
    NSLog(@"invoke");
    if(newLocation.coordinate.latitude == 0.0f || newLocation.coordinate.longitude == 0.0f)
        return;
    
    if ([[MKLocationManager sharedLocationManager] chinaShiftEnabled])
    {
        newLocation = [[MKLocationManager sharedLocationManager] _applyChinaLocationShift:newLocation];
        if (newLocation == nil)
            return;
        
        if (lastAvailableLocation)
        {
            double newDistance = [newLocation distanceFromLocation:lastAvailableLocation];
            NSLog(@"newdistance: %f", newDistance);
            float distInterval = isFirstDist ? 10.0f : 5.0f;
            if (newDistance >= distInterval)
            {
                NSLog(@"invoke if");
                totalDist += newDistance;
                [self.delegate changeTotalDist];
                isFirstDist = NO;
                lastAvailableLocation = newLocation;
                [locationsArray addObject:newLocation];
                //[self updateLocation];
                // create the overlay
                [self setMapRoute];
                // zoom in on the route.
                //[self zoomInOnRoute];
            }

        }
        else
        {
            lastAvailableLocation = newLocation;
            [locationsArray addObject:newLocation];
            MKCoordinateRegion region = MKCoordinateRegionMake(newLocation.coordinate, MKCoordinateSpanMake(0.002, 0.002));
            [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
        }
    }
}

-(void)stopLocationUpdate
{
    [locationManager stopUpdatingLocation];
}
@end
