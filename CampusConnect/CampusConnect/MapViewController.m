//
//  MapViewController.m
//  CampusConnect
//
//  Created by Shamikul Amin on 6/28/13.
//  Copyright (c) 2013 Shamikul Amin. All rights reserved.
//

#import "MapViewController.h"
#import "ASIHTTPRequest.h"
#import "LocationObjects.h"


#define METERS_PER_MILE 1609.344

@interface MapViewController ()

@end

@implementation MapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated {
    
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude=32.729738;
    zoomLocation.longitude=-97.113058;
    
    MKCoordinateRegion mapRegion = [_mapView region];
    CLLocationCoordinate2D centerLocation = mapRegion.center;
    
    NSString *jsonFile = [[NSBundle mainBundle]pathForResource:@"command" ofType:@"json"];
    NSString *formatString = [NSString stringWithContentsOfFile:jsonFile encoding:NSUTF8StringEncoding error:nil];
    NSString *json = [NSString stringWithFormat:formatString, centerLocation.latitude, centerLocation.longitude, 0.5*METERS_PER_MILE];
    NSURL *url = [NSURL URLWithString:@"http://129.107.116.135:8080/CampusConnectServer/campus_connect_android/getCommunityMsgForMap/"];
    
    ASIHTTPRequest *_request= [ASIHTTPRequest requestWithURL:url];
    __weak ASIHTTPRequest *request = _request;
    
    request.requestMethod = @"POST";
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    [request appendPostData:[json dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request setDelegate:self];
    [request setCompletionBlock:^{
        NSString *responseString = [request responseString];
        NSData *responseData = [request responseData];
        NSLog(@"Response: %@", responseString);
        //self plotCrimePositions:responseData];
        NSError* error;
        NSArray* json = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
        
        int x;
        for(x=0; x<[json count]; x++)
        {
        
            NSDictionary *jsonObj = [json objectAtIndex:x];
            NSLog(@"json object: %@", jsonObj);
        
            NSString* msg_title = [jsonObj objectForKey:@"msg_title"];
            NSLog(@"msg_title: %@\n", msg_title);
        
            NSString* msg_type = [jsonObj objectForKey:@"msg_type"];
            NSLog(@"msg_type: %@\n", msg_type);
        
            NSString* msg_id = [jsonObj objectForKey:@"comm_msg_id"];
            NSLog(@"comm_msg_id: %@\n", msg_id);
        
            NSString* latlong = [jsonObj objectForKey:@"latlong"];
            NSLog(@"latlong: %@\n", latlong);
        
            NSString* msg_desc = [jsonObj objectForKey:@"msg_description"];
            NSLog(@"msg_description: %@\n", msg_desc);
        
            NSString* msg_exp = [jsonObj objectForKey:@"expiry_time"];
            NSLog(@"msg_expiry: %@\n", msg_exp);
        

        
            NSArray *stcoords = [latlong componentsSeparatedByString:@", "];
        
            CGFloat lat = (CGFloat)[stcoords[0] floatValue];
            CGFloat longi = (CGFloat)[stcoords[1] floatValue];
        
            CLLocationCoordinate2D coordinates;
            coordinates.latitude=lat;
            coordinates.longitude=longi;
        
            MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
        
            _mapView.mapType=MKMapTypeHybrid;
        
        
        
            [_mapView setRegion:viewRegion animated:YES];
        
            MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
            point.coordinate = coordinates;
            point.title = msg_title;
            point.subtitle=msg_desc;
            [self.mapView addAnnotation:point];
        }
        
        
        /*latitude=32.729738;
         zoomLocation.longitude=-97.113058;*/
        
        
        
    }];
    [request setFailedBlock:^{
        NSError *error = [request error];
        NSLog(@"Error: %@", error.localizedDescription);
    }];
    [request startAsynchronous];
    


    
   
    
    

}

- (MKAnnotationView *)mapView:(MKMapView *)theMapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    static NSString *SFAnnotationIdentifier = @"SFAnnotationIdentifier";
    MKPinAnnotationView *pinView =
    (MKPinAnnotationView *)[_mapView dequeueReusableAnnotationViewWithIdentifier:SFAnnotationIdentifier];
    if (!pinView)
    {
        MKAnnotationView *annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:SFAnnotationIdentifier];
        UIImage *flagImage = [UIImage imageNamed:@"icon_crime.png"];
        // You may need to resize the image here.
        annotationView.image = flagImage;
        return annotationView;
    }
    else
    {
        pinView.annotation = annotation;
    }
    return pinView;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)BackButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}




- (IBAction)RefreshButton:(id)sender {
    MKCoordinateRegion mapRegion = [_mapView region];
    CLLocationCoordinate2D centerLocation = mapRegion.center;
    
    NSString *jsonFile = [[NSBundle mainBundle]pathForResource:@"command" ofType:@"json"];
    NSString *formatString = [NSString stringWithContentsOfFile:jsonFile encoding:NSUTF8StringEncoding error:nil];
    NSString *json = [NSString stringWithFormat:formatString, centerLocation.latitude, centerLocation.longitude, 0.5*METERS_PER_MILE];
    NSURL *url = [NSURL URLWithString:@"http://129.107.116.135:8080/CampusConnectServer/campus_connect_android/getCommunityMsgForMap/"];
    
    ASIHTTPRequest *_request= [ASIHTTPRequest requestWithURL:url];
    __weak ASIHTTPRequest *request = _request;
    
    request.requestMethod = @"POST";
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    [request appendPostData:[json dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request setDelegate:self];
    [request setCompletionBlock:^{
        NSString *responseString = [request responseString];
        NSData *responseData = [request responseData];
        NSLog(@"Response: %@", responseString);
        //self plotCrimePositions:responseData];
        NSError* error;
        NSArray* json = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
        
        NSDictionary *jsonObj = [json objectAtIndex:1];
        NSLog(@"json object: %@", jsonObj);
        
        NSString* msg_title = [jsonObj objectForKey:@"msg_title"];
        NSLog(@"msg_title: %@\n", msg_title);
        
        NSString* msg_type = [jsonObj objectForKey:@"msg_type"];
        NSLog(@"msg_type: %@\n", msg_type);
        
        NSString* msg_id = [jsonObj objectForKey:@"comm_msg_id"];
        NSLog(@"comm_msg_id: %@\n", msg_id);
        
        NSString* latlong = [jsonObj objectForKey:@"latlong"];
        NSLog(@"latlong: %@\n", latlong);
        
        NSString* msg_desc = [jsonObj objectForKey:@"msg_description"];
        NSLog(@"msg_description: %@\n", msg_desc);
        
        NSString* msg_exp = [jsonObj objectForKey:@"expiry_time"];
        NSLog(@"msg_expiry: %@\n", msg_exp);
        
        CLLocationCoordinate2D coords;
        coords.latitude=32.729738;
        coords.longitude=97.113058;
        
        NSArray *stcoords = [latlong componentsSeparatedByString:@", "];
        
        CGFloat lat = (CGFloat)[stcoords[0] floatValue];
        CGFloat longi = (CGFloat)[stcoords[1] floatValue];
        
        CLLocationCoordinate2D coordinates;
        coordinates.latitude=lat;
        coordinates.longitude=longi;
        
        MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
        point.coordinate = coordinates;
        point.title = msg_title;
        point.subtitle=msg_desc;
        [self.mapView addAnnotation:point];
        
        
        /*latitude=32.729738;
        zoomLocation.longitude=-97.113058;*/
        
        
        
    }];
    [request setFailedBlock:^{
        NSError *error = [request error];
        NSLog(@"Error: %@", error.localizedDescription);
    }];
    [request startAsynchronous];
}
@end
