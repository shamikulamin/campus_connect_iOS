//
//  ReportIncidentController.h
//  CampusConnect
//
//  Created by Shamikul Amin on 6/14/13.
//  Copyright (c) 2013 Shamikul Amin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReportIncidentController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextView *messageView;
- (IBAction)DoneButton:(id)sender;
- (IBAction)BackButton:(id)sender;
- (IBAction)CameraPic:(id)sender;
- (IBAction)viewImage:(id)sender;

    
@end
