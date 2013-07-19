//
//  CommunityMsgsController.m
//  CampusConnect
//
//  Created by Shamikul Amin on 7/3/13.
//  Copyright (c) 2013 Shamikul Amin. All rights reserved.
//

#import "CommunityMsgsController.h"
#import "CommMapViewController.h"
#import "AFNetworking.h"
#import "NSData+Base64.h"
#import "MBProgressHUD.h"

@interface CommunityMsgsController ()


@end

@implementation CommunityMsgsController
@synthesize commMapViewController, header;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(NSString*)getHeader
{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [paths objectAtIndex:0];
    NSString *fullPath = [NSString alloc];
    NSFileHandle *fileHandle = [NSFileHandle alloc];
    
    
    
        fullPath = [NSString stringWithFormat:@"%@", [filePath stringByAppendingPathComponent:@"loginInfo.txt"]];
        fileHandle = [NSFileHandle fileHandleForUpdatingAtPath:fullPath];
        NSString *stringFromFile = [NSString stringWithContentsOfFile:fullPath encoding:NSASCIIStringEncoding error:nil];
        
        const char *charsFromFile = [stringFromFile UTF8String];
        
        NSString *userNameFromFile = [[NSString alloc]init];
        NSString *passwordFromFile = [[NSString alloc]init];
        
        int count = 0;
        for (int i = 0; i < strlen(charsFromFile); i++) {
            if (charsFromFile[i]=='\n') {
                ++count;
            }
            else if(count == 0) { // append characters to usernamefromfile
                userNameFromFile = [userNameFromFile stringByAppendingString:[NSString stringWithFormat:@"%c", charsFromFile[i]]];
            }
            else  {  // append characters to passwordfromfile
                
                passwordFromFile = [passwordFromFile stringByAppendingString:[NSString stringWithFormat:@"%c", charsFromFile[i]]];
            }
        }
    
    NSString *devinfo = [NSString alloc];
    NSString *devbasic = [NSString alloc];
    NSString *b64 = [NSString alloc];
    NSData *data = [NSData alloc];
    
    
    
    devbasic=@"Basic ";
    devinfo = [userNameFromFile stringByAppendingString:@":"];
    devinfo = [devinfo stringByAppendingString:passwordFromFile];
    data = [devinfo dataUsingEncoding:NSUTF8StringEncoding];
    
    b64 = [data base64EncodedString];
    
    b64 =[b64 stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
    devbasic = [devbasic stringByAppendingString:b64];
    
    
    NSLog(@"%@",devbasic);
    
    return devbasic;
    
}

- (void)viewWillAppear:(BOOL)animated
{

    _json = [[NSMutableArray alloc] init];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading Messages....";
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"https://129.107.116.135:8443"]];
    
  //  [httpClient setDefaultHeader:<#(NSString *)#> value:<#(NSString *)#>]
    //-- the content of the POST request is passed in as an NSDictionary
    //-- in this example, there are two keys with an object each
    
    header = [self getHeader];
    
    [httpClient setDefaultHeader:@"Authorization" value:header];
    NSLog(@"%@",header);
    
    [httpClient postPath:@"/CampusConnectServer/campus_connect_android/getCommunityMsg/" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSData *responseData = [[NSData alloc] initWithData:responseObject];
        NSLog(@"Request Successful, response '%@'", responseStr);
        _json =  [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
        
        NSDictionary *jsonObj = [_json objectAtIndex:0];
        NSLog(@"json object: %@", jsonObj);
        
        [_commTableView reloadData];
        [hud hide:YES afterDelay:1.0];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error.localizedDescription);
        [hud hide:YES afterDelay:1.0];
        _alert = [[UIAlertView alloc]initWithTitle:@"Connection Failed" message:@"Oops.....  The server appears to be down or you are not connected to the internet" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [_alert show];
        
    }];

    // Do any additional setup after loading the view from its nib.
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(buttonIndex==0) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark -UITableView Datasource

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CommMapViewController *maps = [[CommMapViewController alloc] initWithNibName:@"CommMapViewController" bundle:nil];
    NSDictionary *tempDictionary = [_json objectAtIndex:indexPath.row];
    NSLog(@"LATING: %@",[tempDictionary objectForKey:@"latlong"]);
    if (![[tempDictionary objectForKey:@"latlong"]isEqual:@"none"]) {
        
        NSString *msg_type = [tempDictionary objectForKey:@"msg_type"];
        NSString *msg_title = [tempDictionary objectForKey:@"msg_title"];
        NSString *msg_descrip = [tempDictionary objectForKey:@"msg_description"];
        NSString *latlong = [tempDictionary objectForKey:@"latlong"];
        NSArray *stcoords = [latlong componentsSeparatedByString:@", "];
    
        self.commMapViewController = maps;
        commMapViewController.msg_type = msg_type;
        commMapViewController.message_title=msg_title;
        commMapViewController.msg_descrip=msg_descrip;
        commMapViewController.latitude=stcoords[0];
        commMapViewController.longitude=stcoords[1];
    
        [self presentViewController:maps animated:YES completion:nil];
    }
    else {
        NSLog(@"No latlong");
    }
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_json count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier=@"Cell";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    NSDictionary *tempDictionary= [_json objectAtIndex:indexPath.row];
    

    
    if(cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = [tempDictionary objectForKey:@"msg_title"];
    cell.detailTextLabel.text = [tempDictionary objectForKey:@"reporting_time"];
    NSString *image_type = [tempDictionary objectForKey:@"msg_type"];
    
    if ([image_type isEqual: @"crimealert"]) {
        UIImage *image = [UIImage imageNamed:@"icon_crime.png"];
        cell.imageView.image=image;
    }
    else if ([image_type isEqual:@"parking"]) {
        UIImage *image = [UIImage imageNamed:@"icon_parking.png"];
        cell.imageView.image=image;
    }
    else if ([image_type isEqual:@"general"]){
        UIImage *image = [UIImage imageNamed:@"icon_general.png"];
        cell.imageView.image=image;
    }
    else if ([image_type isEqual:@"weather"]){
        UIImage *image = [UIImage imageNamed:@"icon_weather.png"];
        cell.imageView.image=image;
    }
    
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
