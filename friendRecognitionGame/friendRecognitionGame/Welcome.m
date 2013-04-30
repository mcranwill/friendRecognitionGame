//
//  Welcome.m
//  friendRecognitionGame
//
//  Created by Mike Cranwill on 4/30/13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import "Welcome.h"
#import "FriendRecognitionGameAppDelegate.h"

@interface Welcome ()

@end

@implementation Welcome

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // Register for notifications on FB session state changes
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(sessionStateChanged:)
     name:FBSessionStateChangedNotification
     object:nil];
}

- (void) viewDidUnload {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)sessionStateChanged:(NSNotification*)notification {
    if (FBSession.activeSession.isOpen) {
        // If a deep link, go to the seleceted menu
        [self performSegueWithIdentifier:@"enterGame" sender:self];
    } else {
        [self performSegueWithIdentifier:@"segLogin" sender:self];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (FBSession.activeSession.isOpen ) {
        // If the user's session is active, personalize, but
        // only if this is not deep linking into the order view.
        //[self populateUserDetails];
    } else if (FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded) {
        // Check the session for a cached token to show the proper authenticated
        // UI. However, since this is not user intitiated, do not show the login UX.
        FriendRecognitionGameAppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
        [appDelegate openSession:NO];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // Present login modal if necessary after the view has been
    // displayed, not in viewWillAppear: so as to allow display
    // stack to "unwind"
    if (FBSession.activeSession.isOpen ) {
        //GOTO game screen
        [self performSegueWithIdentifier:@"enterGame" sender:self];
    } else if (FBSession.activeSession.isOpen ||
               FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded ||
               FBSession.activeSession.state == FBSessionStateCreatedOpening) {
        [self performSegueWithIdentifier:@"enterGame" sender:self];
    } else {
        [self performSegueWithIdentifier:@"segLogin" sender:self];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
