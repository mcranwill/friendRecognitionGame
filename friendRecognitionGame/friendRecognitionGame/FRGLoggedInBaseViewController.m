//
//  FRGLoggedInBaseViewController.m
//  friendRecognitionGame
//
//  Created by Mike Cranwill on 2/21/13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import "FRGLoggedInBaseViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import "FBDataController.h"
#import "GameWindow.h"
#import "GameWindowPickerView.h"

@interface FRGLoggedInBaseViewController ()

@end

@implementation FRGLoggedInBaseViewController
@synthesize userInfoTextView;

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.fbDController = [[FBDataController alloc] init];
}

- (void)viewDidAppear:(BOOL)animated{
    
    //[super viewDidAppear:true];
    if([[FBSession activeSession] isOpen]){
        NSLog(@"We are in an active session.");
    }
    NSLog(@"is something going on?");
    [FBRequestConnection
     startForMyFriendsWithCompletionHandler:^(FBRequestConnection *connection,  //Get the friends list
                                              id data,                 //object and identify it as data.
                                              NSError *error) {
         if (!error) {
             //Update friends list
             NSLog(@"Starting to load friends list");
             _fbDController.friendsList = (NSArray*)[data data];
             NSLog(@"I finished.");
             //Prints out friends List to a UITextView
             /*NSString *userInfo = [[NSString alloc] init];
              NSMutableArray *friendNames = [[NSMutableArray alloc] init];
              for (int i =0; i <[_fbDController.friendsList count]; i++){
              [friendNames addObject:[[_fbDController.friendsList objectAtIndex:i] name]];
              }
              userInfo = [userInfo
              stringByAppendingString:
              [NSString stringWithFormat:@"friendNames: %@\n\n",
              friendNames]];            //add friendNames object to userInfo.*/
             //[self prepareForSegue:<#(UIStoryboardSegue *)#> sender:<#(id)#>]
             
             if([self.activitySpinner isAnimating]){
                 [self.activitySpinner setHidden:YES];
             }
             
             [self performSegueWithIdentifier:@"playGame1" sender:self];
             //[self.activitySpinner setHidden:true];
             //[self.userInfoTextView setHidden:false];
             //self.userInfoTextView.text = userInfo;
         } else if (error){
             NSLog(@" Our error code is %d",[error code]);
             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"We failed to load your friends list, please try again." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
             [alert show];
             if([self.activitySpinner isAnimating]){
                 [self.activitySpinner setHidden:YES];
             }
             //[self performSegueWithIdentifier:@"toLogin" sender:self];
             
         }
     }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"View loaded. Am I doing anything?");
    //Check to see that user is connected to FB.
    //if (FBSession.activeSession.isOpen) {
   
    //}
    
    UIApplication *app = [UIApplication sharedApplication];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:app];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    // paths[0];
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *archivePath = [documentsDirectory stringByAppendingPathComponent:@"data.tlist"];
    
    if ([fileManager fileExistsAtPath:archivePath] == YES)
    {
        //Decode
        NSData *data = [NSData dataWithContentsOfFile:archivePath];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        
        NSMutableString *temp = [[NSMutableString alloc] init];
        [temp appendString:@"key"];
        while ([unarchiver containsValueForKey:temp]) {
            ResultsObj *temporaryResultsObj =[[ResultsObj alloc] initWithValue:0];
            temporaryResultsObj = [unarchiver decodeObjectForKey:temp];
            [self.fbDController addResultObj:[unarchiver decodeObjectForKey:temp]];
            
            //[[self tableView] ];
            [temp appendString:@"1"];
            //inde++;
        }
    }
    
    
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"playGame"]){
        GameWindowPickerView *controller = (GameWindowPickerView *)segue.destinationViewController;
        controller.fbDController = _fbDController;
    } else if([segue.identifier isEqualToString:@"playGame1"]){
        GameWindow *contr = (GameWindow *) segue.destinationViewController;
        contr.fbDController = _fbDController;
    } else if([segue.identifier isEqualToString:@"cancelAndLogout"]){
        //[FBSession.activeSession closeAndClearTokenInformation];
        //[self ]
    }
}

- (void)applicationDidEnterBackground:(NSNotification *)notification {
    NSLog(@"Entering Background");
    [self.fbDController writeResultsToFile];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)performLogout:(id)sender {
    [FBSession.activeSession closeAndClearTokenInformation];
}

@end
