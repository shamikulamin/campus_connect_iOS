//
//  CameraController.m
//  CampusConnect
//
//  Created by Shamikul Amin on 6/15/13.
//  Copyright (c) 2013 Shamikul Amin. All rights reserved.
//

#import "CameraController.h"

@interface CameraController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>;
@end

@implementation CameraController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
    self.imageView.image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    //Set Photo Date
    NSString *date = [self currentDateandTime];
    //Save Image to Documents Directory
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    NSString  *imagePath = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/Images/%@_image.png",date]];
    [UIImagePNGRepresentation(image) writeToFile:imagePath atomically:YES];
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

- (NSString *)currentDateandTime
{
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MMddyyyy_HHmmssSS"];
    NSString *dateString = [dateFormat stringFromDate:today];
    
    return dateString;
}

- (IBAction)getPic:(id)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:picker animated:YES completion:NULL];
}

- (IBAction)backButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
