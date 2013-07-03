//
//  MapViewController.h
//  CampusConnect
//
//  Created by Shamikul Amin on 6/28/13.
//  Copyright (c) 2013 Shamikul Amin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController <MKMapViewDelegate>
- (IBAction)BackButton:(id)sender;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
- (IBAction)RefreshButton:(id)sender;

@end
