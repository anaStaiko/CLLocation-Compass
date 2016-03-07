//
//  GPSTrackController.h
//  LocationAndCompas
//
//  Created by Anastasiia Staiko on 3/6/16.
//  Copyright © 2016 Anastasiia Staiko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface GPSTrackController : UIViewController <CLLocationManagerDelegate> {
    
    CLLocationManager *lm;
    NSMutableArray *trackPointArray;
}

- (IBAction)startTracking:(id)sender;

- (IBAction)stopTracking:(id)sender;


@end
