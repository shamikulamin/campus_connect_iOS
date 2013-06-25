//
//  ViewFullImageController.h
//  CampusConnect
//
//  Created by Shamikul Amin on 6/24/13.
//  Copyright (c) 2013 Shamikul Amin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewFullImageController : UIViewController
{
    UIImage *image;
}
- (IBAction)BackButton:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *PicView;
@property (strong, nonatomic) IBOutlet UIImage *image;


@end
