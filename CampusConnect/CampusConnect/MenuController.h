//
//  MenuController.h
//  CampusConnect
//
//  Created by Shamikul Amin on 6/14/13.
//  Copyright (c) 2013 Shamikul Amin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommunityMsgsController.h"
#import "ReportIncidentController.h"
#import "MapViewController.h"

@interface MenuController : UIViewController
{
    ReportIncidentController *reportIncident;
    MapViewController *mapView;
    CommunityMsgsController *commmsg;
}

- (IBAction)ReportIncident:(id)sender;
- (IBAction)NotificationList:(id)sender;
- (IBAction)NotificationMap:(id)sender;
@property (nonatomic,retain) NSString *header;


@end
