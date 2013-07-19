//
//  ViewController.m
//  CampusConnect
//
//  Created by Shamikul Amin on 6/14/13.
//  Copyright (c) 2013 Shamikul Amin. All rights reserved.
//

#import "ViewController.h"
#import "MenuController.h"
#import "RSAEncryption.h"
#import "NSData+Base64.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"



@interface ViewController ()
{
    NSFileManager *fileManager, *fileMan;
    NSString *fullPath, *fPath;
    NSFileHandle *fileHandle, *fHandle;
}

@end

@implementation ViewController
@synthesize deviceToken;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    _Password.secureTextEntry=YES;
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [paths objectAtIndex:0];
    NSString *eulapath = [[NSBundle mainBundle] pathForResource:@"eula" ofType:@"txt"];
    NSString *eula = [NSString stringWithContentsOfFile:eulapath encoding:NSUTF8StringEncoding error:nil];
    
    fileMan = [NSFileManager defaultManager];
    fHandle = [NSFileHandle fileHandleForUpdatingAtPath:[filePath stringByAppendingPathComponent:@"EULA_Accept.txt"]];
    [fileMan changeCurrentDirectoryPath:filePath];
    fPath=[NSString stringWithFormat:@"%@", [filePath stringByAppendingPathComponent:@"EULA_Accept.txt"]];
    [fileManager createFileAtPath:fPath contents:nil attributes:nil];
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Terms of Agreement" message:eula delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alert show];
    
    
    fileManager = [NSFileManager defaultManager];
    fileHandle = [NSFileHandle fileHandleForUpdatingAtPath:[filePath stringByAppendingPathComponent:@"loginInfo.txt"]];
    
    
    [fileManager changeCurrentDirectoryPath:filePath];
    fullPath = [NSString stringWithFormat:@"%@", [filePath stringByAppendingPathComponent:@"loginInfo.txt"]];
    
    BOOL fileExist = [[NSFileManager defaultManager]fileExistsAtPath:fullPath];
    
    
    if (fileExist)
    {
        
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
        
        NSString *appversion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
        appversion=[appversion stringByAppendingString:@"_IOS"];

        
        NSMutableDictionary *parameters= [NSMutableDictionary dictionary];
        [parameters setObject:userNameFromFile forKey:@"netid"];
        [parameters setObject:passwordFromFile forKey:@"password"];
        [parameters setObject:appversion forKey:@"version"];
        
        
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText = @"Logging In......";
        AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"https://129.107.116.135:8443"]];
        //-- the content of the POST request is passed in as an NSDictionary
        //-- in this example, there are two keys with an object each
        
        
        [httpClient postPath:@"/CampusConnectServer/campus_connect_android/login" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSLog(@"Request Successful, response '%@'", responseStr);
            _response=responseStr;
            
            
            deviceToken = [NSString stringWithFormat:@"%@",devID];
            deviceToken=[deviceToken stringByReplacingOccurrencesOfString:@"<" withString:@""];
            deviceToken=[deviceToken stringByReplacingOccurrencesOfString:@">" withString:@""];
            deviceToken=[deviceToken stringByReplacingOccurrencesOfString:@" " withString:@""];
            
            NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
            [parameter setObject:deviceToken forKey:@"regID"];
            
            AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"https://129.107.116.135:8443"]];
            //-- the content of the POST request is passed in as an NSDictionary
            //-- in this example, there are two keys with an object each
            
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
            
           
            
           [httpClient setDefaultHeader:@"Authorization" value:devbasic];
            
            [httpClient postPath:@"/CampusConnectServer/campus_connect_android/iosDeviceRegister" parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                NSLog(@"Request Failed, response '%@'", responseStr);
                NSLog(@"Error: %@", error.localizedDescription);
            }];
            

            
            if ([_response isEqualToString:@"true"]) {
                MenuController *second = [[MenuController alloc] initWithNibName:@"MenuController" bundle:nil];
                [self presentViewController:second animated:YES completion:nil];
            }
            else {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Login Failed" message:@"Your Login Credentials have changed, Please Try Again" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                [alert show];
            }
            
            
            [hud hide:YES afterDelay:2.0];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error.localizedDescription);
            [hud hide:YES afterDelay:2.0];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Connection Failed" message:@"Oops.....  The server appears to be down or you are not connected to the internet" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert show];
        }];

    }
    
    
    
}



- (IBAction)backgroundTouched:(id)sender;
{
    [_NetID resignFirstResponder];
    [_Password resignFirstResponder];
}


-(IBAction)Login:(id)sender
{
    RSAEncryption *rsa = [[RSAEncryption alloc] init];
    NSString *netID= self.NetID.text;
    NSString *pass = self.Password.text;
    
    NSString *base64user = [[rsa encryptWithString:netID] base64EncodedString];
    
    base64user=[base64user stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];

    NSString *base64Pass = [[rsa encryptWithString:pass] base64EncodedString];
    base64Pass=[base64Pass stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
    
    NSString *appversion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    appversion=[appversion stringByAppendingString:@"_IOS"];

    
    NSLog(@"Encrypted Username: %@",base64user);
    NSLog(@"Encrypted Password: %@",base64Pass);
    
    NSMutableDictionary *parameters= [NSMutableDictionary dictionary];
    [parameters setObject:base64user forKey:@"netid"];
    [parameters setObject:base64Pass forKey:@"password"];
    [parameters setObject:appversion forKey:@"version"];
    
   
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Logging In......";
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"https://129.107.116.135:8443"]];
    //-- the content of the POST request is passed in as an NSDictionary
    //-- in this example, there are two keys with an object each
    
    
    [httpClient postPath:@"/CampusConnectServer/campus_connect_android/login" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"Request Successful, response '%@'", responseStr);
         _response=responseStr;
        
        if ([_response isEqualToString:@"true"]) {
            
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *filePath = [paths objectAtIndex:0];
            
            fileManager = [NSFileManager defaultManager];
            fileHandle = [NSFileHandle fileHandleForUpdatingAtPath:[filePath stringByAppendingPathComponent:@"loginInfo.txt"]];
            
            
            [fileManager changeCurrentDirectoryPath:filePath];
            fullPath = [NSString stringWithFormat:@"%@", [filePath stringByAppendingPathComponent:@"loginInfo.txt"]];
            
            

                [fileManager createFileAtPath:fullPath contents:nil attributes:nil];
                
                NSString *userNameAndPasswordString = [NSString stringWithFormat:@"%@\n%@",base64user, base64Pass];
                
                fileHandle = [NSFileHandle fileHandleForUpdatingAtPath:fullPath];
                NSData *data;
                const char *bytesOfUserNameAndPassword = [userNameAndPasswordString UTF8String];
                data = [NSData dataWithBytes:bytesOfUserNameAndPassword length:strlen(bytesOfUserNameAndPassword)];
                [data writeToFile:fullPath atomically:YES];

            
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Login Failed" message:@"Invalid Credentials, Please Try Again" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert show];
        }

        
        [hud hide:YES afterDelay:2.0];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error.localizedDescription);
        [hud hide:YES afterDelay:2.0];
    }];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
