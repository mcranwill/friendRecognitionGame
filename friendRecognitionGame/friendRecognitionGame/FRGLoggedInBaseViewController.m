//
//  FRGLoggedInBaseViewController.m
//  friendRecognitionGame
//
//  Created by Mike Cranwill on 2/21/13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import "FRGLoggedInBaseViewController.h"
#import <FacebookSDK/FacebookSDK.h>

@interface FRGLoggedInBaseViewController ()

@end

@implementation FRGLoggedInBaseViewController
@synthesize userInfoTextView;

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if (FBSession.activeSession.isOpen) {       //Check to see that user is connected to FB.
        
        [FBRequestConnection
         startForMyFriendsWithCompletionHandler:^(FBRequestConnection *connection,  //Get the friends list
                                           id data,                 //object and identify it as data.
                                           NSError *error) {
             if (!error) {
                 NSString *userInfo = @"";
                 NSArray* friends = (NSArray*)[data data];
                 NSMutableArray *friendNames = [[NSMutableArray alloc] init];
                 //NSLog(@"You have %d friends", [friends count]);        //Test code to print num friends
                 for (int i =0; i <[friends count]; i++){           //add each friend name to friendNames.
                     [friendNames addObject:[[friends objectAtIndex:i] name]];                   }
                 
                 userInfo = [userInfo
                             stringByAppendingString:
                             [NSString stringWithFormat:@"friendNames: %@\n\n",
                              friendNames]];            //add friendNames object to userInfo.
                 self.userInfoTextView.text = userInfo;         // Display the user info
             }
         }];
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
