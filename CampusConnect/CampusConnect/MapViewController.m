//
//  MapViewController.m
//  CampusConnect
//
//  Created by Shamikul Amin on 6/28/13.
//  Copyright (c) 2013 Shamikul Amin. All rights reserved.
//

#import "MapViewController.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "NSData+Base64.h"
#import "AnnotationLocation.h"



#define METERS_PER_MILE 1609.344

@interface MapViewController ()

@end

@implementation MapViewController
@synthesize json, header, msg_type;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(NSString*)getHeader
{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [paths objectAtIndex:0];
    NSString *fullPath = [NSString alloc];
    NSFileHandle *fileHandle = [NSFileHandle alloc];
    
    
    
    fullPath = [NSString stringWithFormat:@"%@", [filePath stringByAppendingPathComponent:@"loginInfo.txt"]];
    fileHandle = [NSFileHandle fileHandleForUpdatingAtPath:fullPath];
    NSString *stringFromFile = [NSString stringWithContentsOfFile:fullPath encoding:NSASCIIStringEncoding error:nil];
    
    const char *charsFromFile = [stringFromFile UTF8String];
    
    NSString *userNameFromFile = [[NSString alloc]init];
    NSString *passwordFromFile = [[NSString alloc]init];
    
    int count = 0;
    for (int i = 0; i < strlen(charsFromFile); i++) {
        if (charsFromFile[i]=='\n') {
            ++count;
        }
        else if(count == 0) { // append characters to usernamefromfile
            userNameFromFile = [userNameFromFile stringByAppendingString:[NSString stringWithFormat:@"%c", charsFromFile[i]]];
        }
        else  {  // append characters to passwordfromfile
            
            passwordFromFile = [passwordFromFile stringByAppendingString:[NSString stringWithFormat:@"%c", charsFromFile[i]]];
        }
    }
    
    NSString *devinfo = [NSString alloc];
    NSString *devbasic = [NSString alloc];
    NSString *b64 = [NSString alloc];
    NSData *data = [NSData alloc];
    
    
    
    devbasic=@"Basic ";
    devinfo = [userNameFromFile stringByAppendingString:@":"];
    devinfo = [devinfo stringByAppendingString:passwordFromFile];
    data = [devinfo dataUsingEncoding:NSUTF8StringEncoding];
    
    b64 = [data base64EncodedString];
    
    b64 =[b64 stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
    devbasic = [devbasic stringByAppendingString:b64];
    
    
    NSLog(@"%@",devbasic);
    
    return devbasic;
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    
    
    

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading Map....";
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"https://129.107.116.135:8443"]];
    //-- the content of the POST request is passed in as an NSDictionary
    //-- in this example, there are two keys with an object each
    
    header = [self getHeader];
     [httpClient setDefaultHeader:@"Authorization" value:header];
    
    [httpClient postPath:@"/CampusConnectServer/campus_connect_android/getCommunityMsgForMap/" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSData *responseData = [[NSData alloc] initWithData:responseObject];
        NSLog(@"Request Successful, response '%@'", responseStr);
        json =  [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
        
        int x;
        for(x=0; x<[json count]; x++)
        {
            
            NSDictionary *jsonObj = [json objectAtIndex:x];
            NSLog(@"json object: %@", jsonObj);
            
            NSString* msg_title = [jsonObj objectForKey:@"msg_title"];
            NSLog(@"msg_title: %@\n", msg_title);
            
            msg_type = [jsonObj objectForKey:@"msg_type"];
            NSLog(@"msg_type: %@\n", msg_type);
            
            NSString* msg_id = [jsonObj objectForKey:@"comm_msg_id"];
            NSLog(@"comm_msg_id: %@\n", msg_id);
            
            NSString* latlong = [jsonObj objectForKey:@"latlong"];
            NSLog(@"latlong: %@\n", latlong);
            
            NSString* msg_desc = [jsonObj objectForKey:@"msg_description"];
            NSLog(@"msg_description: %@\n", msg_desc);
            
            NSString* msg_exp = [jsonObj objectForKey:@"expiry_time"];
            NSLog(@"msg_expiry: %@\n", msg_exp);
            
            int z;
            CGFloat zoomLat = 0;
            CGFloat zoomLong = 0;
            for (z=0; z<[json count]; z++) {
                NSDictionary *jsonLatObj = [json objectAtIndex:z];
                NSString *zoomCoord = [jsonLatObj objectForKey:@"latlong"];
                
                NSArray *stlatcoords = [zoomCoord componentsSeparatedByString:@", "];
                
                CGFloat zoomLati = (CGFloat)[stlatcoords[0] floatValue];
                CGFloat zoomlongi = (CGFloat)[stlatcoords[1] floatValue];
                
                if (zoomLati>zoomLat) {
                    zoomLat=zoomLati;
                }
                if (zoomlongi>zoomLong) {
                    zoomLong=zoomlongi;
                }
            }
            
            CLLocationCoordinate2D zoomLocation;
            zoomLocation.latitude=32.729738;
            zoomLocation.longitude=-97.113058;
            
            
            NSArray *stcoords = [latlong componentsSeparatedByString:@", "];
            
            CGFloat lat = (CGFloat)[stcoords[0] floatValue];
            CGFloat longi = (CGFloat)[stcoords[1] floatValue];
            
            CLLocationCoordinate2D coordinates;
            coordinates.latitude=lat;
            coordinates.longitude=longi;
            
            AnnotationLocation *annotation = [[AnnotationLocation alloc] initWithName:msg_title desc:msg_desc coordinate:coordinates];
            [_mapView addAnnotation:annotation];
            
            MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
            
            _mapView.mapType=MKMapTypeHybrid;
            
            MKCoordinateRegion adjustedRegion = [_mapView regionThatFits:viewRegion];
            
            [_mapView setRegion:adjustedRegion animated:YES];
            
            
            
            [hud hide:YES afterDelay:2.0];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error.localizedDescription);
        [hud hide:YES afterDelay:2.0];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Connection Failed" message:@"Oops.....  The server appears to be down or you are not connected to the internet" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
    }];

    [hud hide:YES afterDelay:3.0];
          

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


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(buttonIndex==0) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
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
   }
@end
