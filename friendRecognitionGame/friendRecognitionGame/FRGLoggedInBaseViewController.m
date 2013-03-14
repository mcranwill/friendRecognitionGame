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

@interface FRGLoggedInBaseViewController ()

@end

@implementation FRGLoggedInBaseViewController
@synthesize userInfoTextView;

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.fbDController = [[FBDataController alloc] init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //Check to see that user is connected to FB.
    
    if (FBSession.activeSession.isOpen) {
        [FBRequestConnection
         startForMyFriendsWithCompletionHandler:^(FBRequestConnection *connection,  //Get the friends list
                                                  id data,                 //object and identify it as data.
                                                  NSError *error) {
             if (!error) {
                 //Update friends list
                 _fbDController.friendsList = (NSArray*)[data data];
                 //Code to print out friends List
                 
                 NSString *userInfo = [[NSString alloc] init];
                 NSMutableArray *friendNames = [[NSMutableArray alloc] init];
                 for (int i =0; i <[_fbDController.friendsList count]; i++){ 
                     [friendNames addObject:[[_fbDController.friendsList objectAtIndex:i] name]];
                 }
                 userInfo = [userInfo
                             stringByAppendingString:
                             [NSString stringWithFormat:@"friendNames: %@\n\n",
                              friendNames]];            //add friendNames object to userInfo.
                 self.userInfoTextView.text = userInfo;
             }
         }];
    }
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"playGame"]){
        GameWindow *controller = (GameWindow *)segue.destinationViewController;
        controller.fbDController = _fbDController;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)performLogout:(id)sender {
    [FBSession.activeSession closeAndClearTokenInformation];
    //NSLog(FBSession.activeSession.state);
}

@end
