//
//  ViewImageController.m
//  CampusConnect
//
//  Created by Shamikul Amin on 6/18/13.
//  Copyright (c) 2013 Shamikul Amin. All rights reserved.
//

#import "ViewImageController.h"

@interface ViewImageController ()

@end

@implementation ViewImageController

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
    
    NSString *extension = @"png";
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
   // NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString  *imagePath = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/Images/"]];
    NSArray *contents = [fileManager contentsOfDirectoryAtPath:imagePath error:NULL];
   // NSArray *contents = [fileManager contentsOfDirectoryAtPath:documentsDirectory error:NULL];
    NSMutableArray *pngFiles = [NSMutableArray arrayWithCapacity: [contents count]];
    NSString *filename;
    for (filename in contents)
    {
        if ([[filename pathExtension] isEqualToString:extension])
        {
            [pngFiles addObject: filename];
        }
    }
    //Now the array \"pngFiles\" contains a list of pathnames to all the images in the documents directory.
    //You could then do this:
    
    NSMutableArray *images = [NSMutableArray arrayWithCapacity: [pngFiles count]];
    for (filename in pngFiles)
    {
        NSString *test=[imagePath stringByAppendingFormat:@"/%@",filename];
        UIImage *image = [UIImage imageWithContentsOfFile:test];
       // UIImage *image = [UIImage imageWithContentsOfFile: filename];
        [images addObject: image];
    }
    
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    static NSString* CellIdentifier = @"Cell";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    cell.textLabel.text = @"I'm a UITableViewCell!";
    cell.imageView.image = images[1];
    
    return cell;
}
    
   /* UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(12,12,123,123)];
    imageView.image = images[2];
    [self.view addSubview: imageView]; */

   /* [super viewDidLoad];
    [self loadImage:@"06182013_12225933"];
    // Do any additional setup after loading the view from its nib.
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIImage*)loadImage:(NSString*)imageName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"Images/%@.png", imageName]];
    return [UIImage imageWithContentsOfFile:fullPath];
}*/


@end
