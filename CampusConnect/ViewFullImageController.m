//
//  ViewFullImageController.m
//  CampusConnect
//
//  Created by Shamikul Amin on 6/24/13.
//  Copyright (c) 2013 Shamikul Amin. All rights reserved.
//

#import "ViewFullImageController.h"

@interface ViewFullImageController ()

@end

@implementation ViewFullImageController
@synthesize PicView, image;

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
    PicView.image=image;
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
@end
