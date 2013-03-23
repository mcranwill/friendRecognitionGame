//
//  FRGgameWindowWithTables.m
//  friendRecognitionGame
//
//  Created by Mike Cranwill on 3/22/13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import "FRGgameWindowWithTables.h"
#import "SelectionTableViewController.h"
#include <stdlib.h>

@interface FRGgameWindowWithTables ()

@end

@implementation FRGgameWindowWithTables

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"%@",self.childViewControllers.lastObject);
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
        SelectionTableViewController * alertView = childViewController.view;
        // do something with the AlertView's subviews here...
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setImage {
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithObjectsAndKeys:@"picture.height(150).width(150)",@"fields",nil];
    //[[self.childViewControllers.lastObject blessedFriend] id]
    [FBRequestConnection startWithGraphPath:@"me" parameters:params HTTPMethod:nil completionHandler:^(FBRequestConnection *connection, id data, NSError *error) {
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

- (void) setLoading {
    if(![self.activitySpinnerTab isAnimating]){
        [self.activitySpinnerTab startAnimating];
    }
    [self.profilePicView setHidden:true];
    //[self.selectionPicker setHidden:true];
}

- (void) setDoneLoading {
    if([self.activitySpinnerTab isAnimating]){
        [self.activitySpinnerTab stopAnimating];
    }
    [self.profilePicView setHidden:false];
    //[self.selectionPicker setHidden:false];
}
 
@end
