//
//  ViewImageController.m
//  CampusConnect
//
//  Created by Shamikul Amin on 6/18/13.
//  Copyright (c) 2013 Shamikul Amin. All rights reserved.
//

#import "ViewImagesController.h"

@interface ViewImagesController ()

/* THIS IS A TEST COMMIT*/

@end

@implementation ViewImagesController
@synthesize ViewImagesTable, imageCells, images, pngFiles;

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
    imageCells=[[NSMutableArray alloc]initWithObjects:@"First Picture",@"Second Picture",@"Third Picture",@"Fourth Picture",@"Fifth Picture",@"Sixth Picture",@"Seventh Picture",@"Eighth Picture",@"Ninth Picture",@"Tenth Picture",nil];
    
    NSString *extension = @"png";
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    // NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString  *imagePath = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/Images/"]];
    NSArray *contents = [fileManager contentsOfDirectoryAtPath:imagePath error:NULL];
    // NSArray *contents = [fileManager contentsOfDirectoryAtPath:documentsDirectory error:NULL];
    pngFiles = [NSMutableArray arrayWithCapacity: [contents count]];
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
    
    images = [NSMutableArray arrayWithCapacity: [pngFiles count]];
    for (filename in pngFiles)
    {
        NSString *test=[imagePath stringByAppendingFormat:@"/%@",filename];
        UIImage *image = [UIImage imageWithContentsOfFile:test];
        // UIImage *image = [UIImage imageWithContentsOfFile: filename];
        [images addObject: image];
    }
    
}



#pragma mark -UITableView Datasource

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    viewFullImageController= [[ViewFullImageController alloc]initWithNibName:@"ViewFullImageController" bundle:nil];
    viewFullImageController.image=images[indexPath.row];
    [self presentViewController:viewFullImageController animated:YES completion:nil];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return pngFiles.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier=@"Cell";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.accessoryType=UITableViewCellAccessoryDetailDisclosureButton;
    cell.textLabel.text = [imageCells objectAtIndex:indexPath.row];
    
    switch (indexPath.row) {
        case 0:
            cell.imageView.image=images[0];
            break;
        case 1:
            cell.imageView.image=images[1];
            break;
        case 2:
            cell.imageView.image=images[2];
            break;
        case 3:
            cell.imageView.image=images[3];
            break;
        case 4:
            cell.imageView.image=images[4];
            break;
        case 5:
            cell.imageView.image=images[5];
            break;
        case 6:
            cell.imageView.image=images[6];
            break;
        case 7:
            cell.imageView.image=images[7];
            break;
        case 8:
            cell.imageView.image=images[8];
            break;
        case 9:
            cell.imageView.image=images[9];
            break;
            
        default:
            break;
    }
    
    return cell;
}


#pragma mark - UITableView Delegate methods


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


- (IBAction)backButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
