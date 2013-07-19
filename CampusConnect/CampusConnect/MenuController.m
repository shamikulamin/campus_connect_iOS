//
//  MenuController.m
//  CampusConnect
//
//  Created by Shamikul Amin on 6/14/13.
//  Copyright (c) 2013 Shamikul Amin. All rights reserved.
//

#import "MenuController.h"
#import "ReportIncidentController.h"
#import "MapViewController.h"
#import "CommunityMsgsController.h"

/*TEST FOR COMMITING*/

@interface MenuController ()

@end

@implementation MenuController
@synthesize header;

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
    ReportIncidentController *report = [[ReportIncidentController alloc] initWithNibName:@"ReportIncidentController" bundle:nil];
    MapViewController *map = [[MapViewController alloc] initWithNibName:@"MapViewController" bundle:nil];
    CommunityMsgsController *comm = [[CommunityMsgsController alloc] initWithNibName:@"CommunityMsgsController" bundle:nil];
    self->reportIncident = report;
    self->mapView = map;
    self->commmsg = comm;
    reportIncident.header = header;
    commmsg.header = header;
    mapView.header = header;
    NSLog(@"%@",header);
    NSLog(@"%@",commmsg.header);
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ReportIncident:(id)sender {
    ReportIncidentController *third = [[ReportIncidentController alloc] initWithNibName:@"ReportIncidentController" bundle:nil];
    [self presentViewController:third animated:YES completion:nil];
}

- (IBAction)NotificationList:(id)sender {
    CommunityMsgsController *msg_lists = [[CommunityMsgsController alloc] initWithNibName:@"CommunityMsgsController" bundle:nil];
    [self presentViewController:msg_lists animated:YES completion:nil];
    
}

- (IBAction)NotificationMap:(id)sender {
    MapViewController *maps = [[MapViewController alloc] initWithNibName:@"MapViewController" bundle:nil];
    [self presentViewController:maps animated:YES completion:nil];
    
}
@end
