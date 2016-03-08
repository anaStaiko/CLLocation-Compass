//
//  GPSTrackController.m
//  LocationAndCompas
//
//  Created by Anastasiia Staiko on 3/6/16.
//  Copyright © 2016 Anastasiia Staiko. All rights reserved.
//

#import "GPSTrackController.h"

@implementation GPSTrackController

@synthesize mapView;

-(void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated {
    
    trackPointArray = [[NSMutableArray alloc] init];
}

-(void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}




- (IBAction)startTracking:(id)sender {
    //start location manager
    lm = [[CLLocationManager alloc] init];
    lm.delegate = self;
    lm.desiredAccuracy = kCLLocationAccuracyBest;
    lm.distanceFilter = kCLDistanceFilterNone;
    [lm requestAlwaysAuthorization];
    [lm startUpdatingLocation];
    
    mapView.delegate = self;
    mapView.showsUserLocation = self;
    
    lm.headingFilter = kCLHeadingFilterNone;
    [lm startUpdatingHeading];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading {
    NSLog(@"magnetic heading is %f", newHeading.magneticHeading);
    NSLog(@"true heading is %f", newHeading.trueHeading);
}


-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    //get the latest location
    CLLocation *currentLocation = [locations lastObject];
    
    //store latest location in stored track array
    [trackPointArray addObject:currentLocation];
    
    //get latest location coordinates
    CLLocationDegrees Latitude = currentLocation.coordinate.latitude;
    CLLocationDegrees Longitude = currentLocation.coordinate.longitude;
    CLLocationCoordinate2D locationCoordinates =CLLocationCoordinate2DMake(Latitude, Longitude);
    
    //get heading info. Based on GPS direction 
    CLLocationDirection direction = currentLocation.course;
    NSLog(@"direction is %.0f", direction);
    _directionLabel.text = [NSString stringWithFormat:@"%.0f°", currentLocation.course];
    
    //zoom map to show user's location
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(locationCoordinates, 1000, 1000);
    MKCoordinateRegion adjustRegion = [mapView regionThatFits:viewRegion];
    [mapView setRegion:adjustRegion animated:YES];
    
    NSInteger numberOfSteps = trackPointArray.count;
    
    CLLocationCoordinate2D coordinates[numberOfSteps];
    for (NSInteger index = 0; index < numberOfSteps; index++) {
        CLLocation *location = [trackPointArray objectAtIndex:index];
        CLLocationCoordinate2D coordinate2 = location.coordinate;
        
        coordinates[index] = coordinate2;
    }
    
    MKPolyline *polyline = [MKPolyline polylineWithCoordinates:coordinates count:numberOfSteps];
    [mapView addOverlay:polyline];
    
}


-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay {
    
    MKPolylineRenderer *polylineRenderer = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
    polylineRenderer.strokeColor = [UIColor redColor];
    polylineRenderer.lineWidth = 5.0;
    
    return polylineRenderer;
}


- (IBAction)stopTracking:(id)sender {
    
    lm = [[CLLocationManager alloc] init];
    [lm stopUpdatingLocation];
    lm = nil;
    

    
    //stop showing user location
     mapView.showsUserLocation = NO;
    
    //reset array of tracks
    trackPointArray = nil;
    trackPointArray = [[NSMutableArray alloc]init];
    
}

- (IBAction)clearTrack:(id)sender {
    //remove overlay on mapView
    [mapView removeOverlays:mapView.overlays];

}




@end
