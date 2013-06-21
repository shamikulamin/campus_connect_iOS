//
//  ViewImagesController.h
//  CampusConnect
//
//  Created by Shamikul Amin on 6/21/13.
//  Copyright (c) 2013 Shamikul Amin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewImagesController : UIViewController
<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *ViewImagesTable;

@end
