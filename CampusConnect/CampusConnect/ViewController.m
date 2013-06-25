//
//  ViewController.m
//  CampusConnect
//
//  Created by Shamikul Amin on 6/14/13.
//  Copyright (c) 2013 Shamikul Amin. All rights reserved.
//

#import "ViewController.h"
#import "MenuController.h"

@interface ViewController ()
{
    NSFileManager *fileManager;
    NSString *fullPath;
    NSFileHandle *fileHandle;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [paths objectAtIndex:0];
    
    fileManager = [NSFileManager defaultManager];
    fileHandle = [NSFileHandle fileHandleForUpdatingAtPath:[filePath stringByAppendingPathComponent:@"loginInfo.txt"]];
    
    
    [fileManager changeCurrentDirectoryPath:filePath];
    fullPath = [NSString stringWithFormat:@"%@", [filePath stringByAppendingPathComponent:@"loginInfo.txt"]];
    
    BOOL fileExist = [[NSFileManager defaultManager]fileExistsAtPath:fullPath];
    
    
    if (!fileExist)
    {
        [fileManager createFileAtPath:fullPath contents:nil attributes:nil];
        
        NSString *userNameAndPasswordString = [NSString stringWithFormat:@"%s\n%s","test", "123"];
        
        fileHandle = [NSFileHandle fileHandleForUpdatingAtPath:fullPath];
        NSData *data;
        const char *bytesOfUserNameAndPassword = [userNameAndPasswordString UTF8String];
        data = [NSData dataWithBytes:bytesOfUserNameAndPassword length:strlen(bytesOfUserNameAndPassword)];
        [data writeToFile:fullPath atomically:YES];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents folder
        NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:@"Images"];
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath])
            [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:nil]; //Create folder
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Done Setting Username and Password" message:@"Completed" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
    }
    
    
}

- (IBAction)backgroundTouched:(id)sender;
{
    [_NetID resignFirstResponder];
    [_Password resignFirstResponder];
}


-(IBAction)Login:(id)sender
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
        else if(count == 0) // append characters to usernamefromfile
        {
            userNameFromFile = [userNameFromFile stringByAppendingString:[NSString stringWithFormat:@"%c", charsFromFile[i]]];
        }
        else    // append characters to passwordfromfile
        {
            passwordFromFile = [passwordFromFile stringByAppendingString:[NSString stringWithFormat:@"%c", charsFromFile[i]]];
        }
    }
    
    if ([userNameFromFile isEqualToString:self.NetID.text] && [passwordFromFile isEqualToString:self.Password.text]) {
        MenuController *second = [[MenuController alloc] initWithNibName:@"MenuController" bundle:nil];
        [self presentViewController:second animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Mismatch" message:@"Username or Password is incorrect" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
    }
    
}


 



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
