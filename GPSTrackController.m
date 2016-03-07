//
//  GPSTrackController.m
//  LocationAndCompas
//
//  Created by Anastasiia Staiko on 3/6/16.
//  Copyright © 2016 Anastasiia Staiko. All rights reserved.
//

#import "GPSTrackController.h"

@implementation GPSTrackController


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
    //don't forget plist
    
    //    [self.locationManager requestAlwaysAuthorization];
    [lm startUpdatingLocation];
}

- (IBAction)stopTracking:(id)sender {
    
    lm = [[CLLocationManager alloc] init];
    [lm stopUpdatingLocation];
    lm = nil;
}


-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    //get the latest location
    CLLocation *currentLocation = [locations lastObject];
    
    //store latest location in stored track array
    [trackPointArray addObject:currentLocation];
    
    NSLog(@"%@", trackPointArray);
    
}






@end
