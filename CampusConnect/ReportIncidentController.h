//
//  ReportIncidentController.h
//  CampusConnect
//
//  Created by Shamikul Amin on 6/14/13.
//  Copyright (c) 2013 Shamikul Amin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>


@interface ReportIncidentController : UIViewController <UITextFieldDelegate,CLLocationManagerDelegate>{
    CLLocationManager *locationManager;
    NSString *lat;
    NSString *lon;
}

@property (weak, nonatomic) IBOutlet UITextView *messageView;
- (IBAction)DoneButton:(id)sender;
- (IBAction)BackButton:(id)sender;
- (IBAction)CameraPic:(id)sender;
- (IBAction)viewImage:(id)sender;
- (IBAction)SendReport:(id)sender;
@property (strong, nonatomic) NSMutableArray *pngFiles;
@property (strong, nonatomic) NSMutableArray *images;
@property (strong, nonatomic) NSMutableArray *imgData;
@property (nonatomic, strong) NSString *header;

    
@end
