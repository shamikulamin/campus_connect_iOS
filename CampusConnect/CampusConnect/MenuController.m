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

/*TEST FOR COMMITING*/

@interface MenuController ()

@end

@implementation MenuController

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
}

- (IBAction)NotificationMap:(id)sender {
    MapViewController *maps = [[MapViewController alloc] initWithNibName:@"MapViewController" bundle:nil];
    [self presentViewController:maps animated:YES completion:nil];
    
}
@end
