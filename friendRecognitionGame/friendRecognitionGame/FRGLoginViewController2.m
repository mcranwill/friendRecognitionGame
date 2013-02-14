//
//  FRGLoginViewController2.m
//  friendRecognitionGame
//
//  Created by Mike Cranwill on 2/14/13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import "FRGLoginViewController2.h"
#import "FriendRecognitionGameAppDelegate.h"

@interface FRGLoginViewController2 ()

@end

@implementation FRGLoginViewController2

@synthesize spinner;

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
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loginFailed
{
    // User switched back to the app without authorizing. Stay here, but
    // stop the spinner.
    [self.spinner stopAnimating];
}

- (IBAction)performLogin:(id)sender {
    [self.spinner startAnimating];
    
    FriendRecognitionGameAppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    [appDelegate openSession];
}
@end
