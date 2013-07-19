//
//  ViewController.h
//  CampusConnect
//
//  Created by Shamikul Amin on 6/14/13.
//  Copyright (c) 2013 Shamikul Amin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuController.h"

@interface ViewController : UIViewController
{
    MenuController *menuController;
@public
    NSData *devID;
}

@property (weak, nonatomic) IBOutlet UITextField *NetID;

@property (weak, nonatomic) IBOutlet UITextField *Password;
@property (strong, nonatomic) NSMutableArray *json;
@property (weak,nonatomic) NSString *response;
@property (weak,nonatomic) NSString *deviceToken;

- (IBAction)Login:(id)sender;

- (IBAction)backgroundTouched:(id)sender;

@end
