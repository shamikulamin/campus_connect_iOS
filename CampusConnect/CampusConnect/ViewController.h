//
//  ViewController.h
//  CampusConnect
//
//  Created by Shamikul Amin on 6/14/13.
//  Copyright (c) 2013 Shamikul Amin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *NetID;

@property (weak, nonatomic) IBOutlet UITextField *Password;


- (IBAction)Login:(id)sender;

- (IBAction)backgroundTouched:(id)sender;

@end
