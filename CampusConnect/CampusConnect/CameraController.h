//
//  CameraController.h
//  CampusConnect
//
//  Created by Shamikul Amin on 6/15/13.
//  Copyright (c) 2013 Shamikul Amin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CameraController : UIViewController

@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) IBOutlet UIButton *takePhotoButton;
- (IBAction)getPic:(id)sender;
- (IBAction)backButton:(id)sender;
@property (nonatomic, strong) NSString *header;


@end
