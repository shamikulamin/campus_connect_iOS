//
//  MapViewController.h
//  CampusConnect
//
//  Created by Shamikul Amin on 6/28/13.
//  Copyright (c) 2013 Shamikul Amin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController <MKMapViewDelegate, UIAlertViewDelegate>
- (IBAction)BackButton:(id)sender;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
- (IBAction)RefreshButton:(id)sender;
@property (strong, nonatomic) NSArray *json;
@property (strong, nonatomic) NSString *header;
@property (strong, nonatomic) NSString *msg_type;

@end
