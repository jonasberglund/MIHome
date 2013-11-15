//
//  ViewController.m
//  MIHome
//
//  Created by Jonas Berglund on 2013-11-15.
//  Copyright (c) 2013 Jonas Berglund. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController (){
    CLLocationManager *locationManager;
    BOOL isHome;
    CLLocationCoordinate2D coord;
    long epsilon;
}

@end

@implementation ViewController
@synthesize mapView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.mapView.delegate = self;
    
    isHome = false;
    epsilon = 0.2;
    
    //This is home
    coord.longitude = 11.937437;
    coord.latitude = 57.709129;
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
    [locationManager startUpdatingLocation];
    
    NSLog(@"%@", [self deviceLocation]);
    
    if(fabs(locationManager.location.coordinate.latitude - coord.latitude) <= epsilon &&
       fabs(locationManager.location.coordinate.longitude - coord.longitude) <= epsilon){
        _homeLabel.text = @"Yes!";
    }else{
        _homeLabel.text = @"Nope!";
    }
    
    NSLog(@"%f", fabs(locationManager.location.coordinate.latitude - coord.latitude));
}

- (NSString *)deviceLocation {
    return [NSString stringWithFormat:@"latitude: %f longitude: %f", locationManager.location.coordinate.latitude, locationManager.location.coordinate.longitude];
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 800, 800);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
    
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    
    point.coordinate = coord;
    point.title = @"This is home!";
    //point.subtitle = @"I'm here!!!";
    
    [self.mapView addAnnotation:point];

}


@end
