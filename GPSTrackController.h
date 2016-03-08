//
//  GPSTrackController.h
//  LocationAndCompas
//
//  Created by Anastasiia Staiko on 3/6/16.
//  Copyright © 2016 Anastasiia Staiko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface GPSTrackController : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate, MKOverlay> {
    
    CLLocationManager *lm;
    NSMutableArray *trackPointArray;
    
    MKMapRect *routeRect;
    MKPolylineView *routeLineView;
    MKPolyline *routeLine;
}

- (IBAction)startTracking:(id)sender;
- (IBAction)stopTracking:(id)sender;
- (IBAction)clearTrack:(id)sender;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UILabel *directionLabel;

@end
