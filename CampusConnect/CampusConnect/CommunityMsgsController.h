//
//  CommunityMsgsController.h
//  CampusConnect
//
//  Created by Shamikul Amin on 7/3/13.
//  Copyright (c) 2013 Shamikul Amin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommMapViewController.h"

@interface CommunityMsgsController : UIViewController
<UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>
{
    CommMapViewController *commMapViewController;
}

@property (nonatomic, retain)CommMapViewController *commMapViewController;
@property (strong, nonatomic) NSMutableArray *imageCells;
@property (strong, nonatomic) NSMutableArray *json;
@property (strong, nonatomic) IBOutlet UITableView *commTableView;
@property (strong, nonatomic) UIAlertView *alert;
@property (strong, nonatomic) NSString *header;



- (IBAction)backButton:(id)sender;

@end
