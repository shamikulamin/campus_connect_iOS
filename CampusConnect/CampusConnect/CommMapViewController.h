//
//  CommMapViewController.h
//  CampusConnect
//
//  Created by Shamikul Amin on 7/8/13.
//  Copyright (c) 2013 Shamikul Amin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface CommMapViewController : UIViewController <MKMapViewDelegate>
{
    NSString *longitude;
    NSString *latitude;
    NSString *message_title;
    NSString *msg_descrip;
}
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (retain, nonatomic)NSString *message_title;
@property (retain, nonatomic)NSString *msg_descrip;
@property (retain, nonatomic)NSString *longitude;
@property (retain, nonatomic)NSString *latitude;
@property (retain, nonatomic)NSString *msg_type;


- (IBAction)backButton:(id)sender;

@end
