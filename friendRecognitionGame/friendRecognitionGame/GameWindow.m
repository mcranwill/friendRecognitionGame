//
//  FRGgameWindowWithTables.m
//  friendRecognitionGame
//
//  Created by Mike Cranwill on 3/22/13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import "GameWindow.h"
#import "SelectionTableViewController.h"
#import "ResultNavigation.h"
#include <stdlib.h>

@interface GameWindow ()

@end

@implementation GameWindow

- (void)viewDidLoad
{
    [super viewDidLoad];
    //NSLog(@"%@",self.childViewControllers.lastObject);
    [self setLoading];
    NSString *logText = [NSString stringWithFormat:@"You are logged in as %@",self.fbDController.user];
    //[self.loggedInLabel setText:logText];
    
    
    [self.childViewControllers.lastObject setGameWithOptions];
    [self setImage];
    //self.arrayOptions = [[NSMutableArray alloc] init];
    //NSLog([self.fbDController lineOpen]);
    //[self setGameWithOptionsAndImage];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString * segueName = segue.identifier;
    if ([segueName isEqualToString: @"select_embed"]) {
        SelectionTableViewController * childViewController = (SelectionTableViewController *) [segue destinationViewController];
        //SelectionTableViewController * alertView = childViewController.view;
        childViewController.fbDController = _fbDController;
        childViewController.gwindow = self;
        //FRGgameWindowWithTables *contr = (FRGgameWindowWithTables *) segue.destinationViewController;
        //contr.fbDController = _fbDController;
        // do something with the AlertView's subviews here...
    }else if([segueName isEqualToString:@"menu"]){
        ResultNavigation * menuViewController = (ResultNavigation *) [segue destinationViewController];
    }else if([segueName isEqualToString:@"performLogout"]){
        //NSLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"FBAccessTokenInformationKey"]);
        //[[[NSUserDefaults standardUserDefaults] objectForKey:@"FBAccessTokenInformationKey"] removeAllObjects];
        [FBSession.activeSession closeAndClearTokenInformation];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setImage {
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithObjectsAndKeys:@"picture.height(150).width(150)",@"fields",nil];
    
    [FBRequestConnection startWithGraphPath:[[self.childViewControllers.lastObject blessedFriend] id] parameters:params HTTPMethod:nil completionHandler:^(FBRequestConnection *connection, id data, NSError *error) {
        if (!error) {
            [self.profilePicView setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[[data  valueForKey:@"picture"] data] valueForKey:@"url"]]]]];
            
            [self setDoneLoading];
            //Code to print out data received in data object
            /*
             NSEnumerator *enumerat = [data keyEnumerator];
             id key;
             while((key = [enumerat nextObject]))
             NSLog(@"key=%@ value=%@", key, [data objectForKey:key]);*/
        }
    }];
}

/*- (IBAction)submitTProcessing:(id)sender {
    //a logout function.
    [FBSession.activeSession closeAndClearTokenInformation];
}*/

    //Code to perform submission.
    /*NSMutableString *msg = [[NSMutableString alloc] init];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Result" message:msg delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    
    NSIndexPath *ip = [[self.childViewControllers.lastObject tableView] indexPathForSelectedRow];
    if([[self.childViewControllers.lastObject blessedFriend] name] == [[self.childViewControllers.lastObject arrayOptions] objectAtIndex:[ip row]]){
        [msg appendString:@"You got it right! \n"];
        [msg appendString:@"Congratulations "];
        [alert setMessage:msg];
        
        [self.fbDController incrementSuccesses];
    }else{
        NSString *correctAns = [[NSString alloc] initWithString:[[self.childViewControllers.lastObject blessedFriend] name]];
        [msg appendString:@"The correct answer was \n"];
        [msg appendString:correctAns];
        [msg appendString:@"\n Better luck next time." ];
        
        [alert setMessage:msg];
    }
    
    [self setLoading];
    [self.fbDController incrementAttempts];
    
    [self.fbDController writeResultsToFile];
    [alert show];
    
    
    
    [self.childViewControllers.lastObject setGameWithOptions];
    [self setImage];*/


- (IBAction)receiveNewGame:(id)sender {
    [self setLoading];
    if( [self.childViewControllers.lastObject lastRow] < 10){
        [self.childViewControllers.lastObject removeSubmitButton:[NSIndexPath indexPathForRow:[self.childViewControllers.lastObject lastRow] inSection:0]];
    }
    [self.childViewControllers.lastObject setGameWithOptions];
    [self setImage];
}

- (IBAction)requestResults:(id)sender {
    NSString *msg = [NSString stringWithFormat:@"Successes: %d \n Total Attempts: %d", [self.fbDController getSessionSuccesses], [self.fbDController getSessionAttempts]];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Past Results" message:msg delegate:nil cancelButtonTitle:@"Finished" otherButtonTitles: nil];
    
    [alert show];
}

- (void) setLoading {
    if(![self.activitySpinnerTab isAnimating]){
        [self.activitySpinnerTab startAnimating];
    }
    [self.profilePicView setHidden:true];
    //[[self.childViewControllers.lastObject contain]]
    [[self.childViewControllers.lastObject tableView] setHidden:true];
    //[self.selectionPicker setHidden:true];
}

- (void) setDoneLoading {
    if([self.activitySpinnerTab isAnimating]){
        [self.activitySpinnerTab stopAnimating];
    }
    [self.profilePicView setHidden:false];
    [[self.childViewControllers.lastObject tableView] setHidden:false];
    //[self.selectionPicker setHidden:false];
}

- (void)applicationDidEnterBackground:(NSNotification *)notification {
    NSLog(@"Entering Background");
    [self.fbDController writeResultsToFile];
}

/*- (IBAction)performLogout:(id)sender {
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"FBAccessTokenInformationKey"]);
    NSLog(@"hello DC");
    [FBSession.activeSession closeAndClearTokenInformation];
    
    /*for (NSObject *each in [[NSUserDefaults standardUserDefaults] objectForKey:@"FBAccessTokenInformationKey"]) {
        <#statements#>
    }
    for (
}*/
 
@end
