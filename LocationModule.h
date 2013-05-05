//
//  LocationModule.h
//  Run and Roll
//
//  Created by Carl on 13-3-31.
//  Copyright (c) 2013年 Carl Hwang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@protocol LocationModuleDelegate <NSObject>

-(void)changeTotalDist;

@end

@interface LocationModule : NSObject<MKMapViewDelegate, CLLocationManagerDelegate>
{
    NSMutableArray *locationsArray;
    CLLocationManager *locationManager;
    CLLocation *lastAvailableLocation;
    float totalDist;
    BOOL isFirstDist;
}
@property (nonatomic) id<LocationModuleDelegate> delegate;
@property (nonatomic) MKPolyline *routeLine;
@property (nonatomic) MKPolylineView *routeLineView;
@property (nonatomic, strong) MKMapView *mapView;
@property (nonatomic) float totalDist;
@property (nonatomic, strong) NSMutableArray *locationsArray;

- (void) setMapRoute;
- (LocationModule*)init;
- (void) stopLocationUpdate;
@end


@interface MKLocationManager
+ (id) sharedLocationManager;
- (BOOL) chinaShiftEnabled;
- (CLLocation*)_applyChinaLocationShift:(CLLocation*)arg;   // 传入原始位置，计算偏移后的位置
@end
