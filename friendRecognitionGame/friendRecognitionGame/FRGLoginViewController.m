//
//  FRGLoginViewController.m
//  friendRecognitionGame
//
//  Created by Mike Cranwill on 2/12/13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import "FRGLoginViewController.h"
#import "FriendRecognitionGameAppDelegate.h"

@interface FRGLoginViewController ()
- (IBAction)performLogin:(id)sender;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@end

@implementation FRGLoginViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
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

- (IBAction)performLogin:(id)sender {
    [self.spinner startAnimating];
    
    FriendRecognitionGameAppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    @synchronized(self){
        [appDelegate openSession];
        [self performSegueWithIdentifier:@"loginSuccess" sender:self];
    }
    
}

- (void)loginFailed
{
    // User switched back to the app without authorizing. Stay here, but
    // stop the spinner.
    [self.spinner stopAnimating];
}
@end
