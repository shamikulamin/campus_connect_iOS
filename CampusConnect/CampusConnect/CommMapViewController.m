//
//  CommMapViewController.m
//  CampusConnect
//
//  Created by Shamikul Amin on 7/8/13.
//  Copyright (c) 2013 Shamikul Amin. All rights reserved.
//

#import "CommMapViewController.h"
#import "AnnotationLocation.h"

#define METERS_PER_MILE 1609.344

@interface CommMapViewController ()

@end

@implementation CommMapViewController
@synthesize mapView, message_title,msg_descrip,longitude,latitude, msg_type;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude=32.729738;
    zoomLocation.longitude=-97.113058;
    
    CGFloat lat = (CGFloat)[latitude floatValue];
    CGFloat longi = (CGFloat)[longitude floatValue];
    
    CLLocationCoordinate2D coordinates;
    coordinates.latitude=lat;
    coordinates.longitude=longi;
    
    
    AnnotationLocation *annotation = [[AnnotationLocation alloc] initWithName:message_title desc:msg_descrip coordinate:coordinates];
    [mapView addAnnotation:annotation];
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(coordinates, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
    
    mapView.mapType=MKMapTypeHybrid;
    
    
    
    [mapView setRegion:viewRegion animated:YES];
    
   
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    
    static NSString *identifier = @"AnnotationLocation";
    if([annotation isKindOfClass:[AnnotationLocation class]]) {
        
        MKAnnotationView *annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        
        if(annotationView==nil) {
            annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
            
        } else {
            annotationView.annotation = annotation;
        }
        
        annotationView.enabled = YES;
        annotationView.canShowCallout = YES;
        if ([msg_type isEqual:@"crimealert"]) {
            annotationView.image = [UIImage imageNamed:@"map_icon_crime.png"];
        }
        else if ([msg_type isEqual:@"parking"]) {
            annotationView.image = [UIImage imageNamed:@"map_icon_parking.png"];
        }
        else if ([msg_type isEqual:@"weather"]) {
            annotationView.image = [UIImage imageNamed:@"map_icon_weather.png"];
        }
        
        return annotationView;
    }
    return nil;
}
    


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
