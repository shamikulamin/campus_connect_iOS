//
//  ReportIncidentController.m
//  CampusConnect
//
//  Created by Shamikul Amin on 6/14/13.
//  Copyright (c) 2013 Shamikul Amin. All rights reserved.
//

#import "ReportIncidentController.h"
#import "CameraController.h"
#import "ViewImagesController.h"
#import "NSData+Base64.h"
#import "AFNetworking.h"

@interface ReportIncidentController ()

@end

@implementation ReportIncidentController
@synthesize pngFiles, images, header, imgData;

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


- (void)viewDidLoad
{
    [super viewDidLoad];
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
    // Do any additional setup after loading the view from its nib.
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];
    NSLog(@"lat%f - lon%f", location.coordinate.latitude, location.coordinate.longitude);
    lat=[[NSNumber numberWithFloat:location.coordinate.latitude] stringValue];
    lon=[[NSNumber numberWithFloat:location.coordinate.longitude] stringValue];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)DoneButton:(id)sender {
    [_messageView resignFirstResponder];}

- (IBAction)BackButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)CameraPic:(id)sender {
    CameraController *third = [[CameraController alloc] initWithNibName:@"CameraController" bundle:nil];
    [self presentViewController:third animated:YES completion:nil];
    
}

- (IBAction)viewImage:(id)sender {
    ViewImagesController *third = [[ViewImagesController alloc] initWithNibName:@"ViewImagesController" bundle:nil];
    [self presentViewController:third animated:YES completion:nil];
    
}

- (IBAction)SendReport:(id)sender {
    NSString *extension = @"png";
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString  *imagePath = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/Images/"]];
    NSArray *contents = [fileManager contentsOfDirectoryAtPath:imagePath error:NULL];
    
    pngFiles = [NSMutableArray arrayWithCapacity: [contents count]];
    NSString *filename;
    for (filename in contents)
    {
        if ([[filename pathExtension] isEqualToString:extension])
        {
            [pngFiles addObject: filename];
        }
    }
    //Now the array \"pngFiles\" contains a list of pathnames to all the images in the documents directory.
    //You could then do this:
    
    imgData = [NSMutableArray arrayWithCapacity: [pngFiles count]];
    images = [NSMutableArray arrayWithCapacity: [pngFiles count]];
    for (filename in pngFiles)
    {
        NSString *test=[imagePath stringByAppendingFormat:@"/%@",filename];
        UIImage *image = [UIImage imageWithContentsOfFile:test];
        NSData *data = UIImagePNGRepresentation(image);
        [imgData addObject:data];
        NSLog(@"%lu",(unsigned long)[imgData count]);
        // UIImage *image = [UIImage imageWithContentsOfFile: filename];
        [images addObject: image];
    }
    
    NSString *documentsDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    
    
    NSString *key1 = self.messageView.text;
    NSString *key2 = [NSString alloc];
    double time = [[NSDate date] timeIntervalSince1970];
    long l_time = [[NSNumber numberWithDouble:time] longValue];

    
    if([key1 length]<10) {
        key2=key1;
    }
    
   else {
       key2 = [key1 substringWithRange:NSMakeRange(0, 10)];
    }
    
    
    
    header = [self getHeader];
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"https://129.107.116.135:8443"]];
    [httpClient setDefaultHeader:@"Authorization" value:header];
    NSMutableURLRequest *request = [httpClient multipartFormRequestWithMethod:@"POST" path:@"/CampusConnectServer/campus_connect_android/sendReport" parameters:nil constructingBodyWithBlock: ^(id <AFMultipartFormData>formData) {
        int i;
        for(i=0;i<[pngFiles count];i++) {
            [formData appendPartWithFileData:imgData[i] name:@"image" fileName:pngFiles[i] mimeType:@"image/png"];
        }
        [formData appendPartWithFormData:[key1 dataUsingEncoding:NSUTF8StringEncoding] name:@"message"];
        [formData appendPartWithFormData:[key2 dataUsingEncoding:NSUTF8StringEncoding] name:@"message_title"];
        [formData appendPartWithFormData:[lat dataUsingEncoding:NSUTF8StringEncoding] name:@"latitude"];
        [formData appendPartWithFormData:[lon dataUsingEncoding:NSUTF8StringEncoding] name:@"longitude"];
        //[formData appendPartWithFormData:l_time  name:@"reporting_time"];
        // etc.
    }];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    // if you want progress updates as it's uploading, uncomment the following:
    //
     [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
         NSLog(@"Sent %lld of %lld bytes", totalBytesWritten, totalBytesExpectedToWrite);
     }];
    
    [httpClient enqueueHTTPRequestOperation:operation];
                                                               
}
@end
