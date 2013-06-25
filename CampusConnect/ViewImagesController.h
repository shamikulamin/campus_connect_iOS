//
//  ViewImagesController.h
//  CampusConnect
//
//  Created by Shamikul Amin on 6/21/13.
//  Copyright (c) 2013 Shamikul Amin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewFullImageController.h"

@interface ViewImagesController : UIViewController
<UITableViewDataSource, UITableViewDelegate>
{
    ViewFullImageController *viewFullImageController;
}

@property (weak, nonatomic) IBOutlet UITableView *ViewImagesTable;
@property (strong, nonatomic) NSMutableArray *imageCells;
@property (strong, nonatomic) NSMutableArray *images;
@property (strong, nonatomic) NSMutableArray *pngFiles;
- (IBAction)backButton:(id)sender;

@end
