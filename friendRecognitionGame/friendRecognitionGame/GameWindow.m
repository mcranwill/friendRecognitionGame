//
//  GameWindow.m
//  friendRecognitionGame
//
//  Created by Mike Cranwill on 2/26/13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import "GameWindow.h"
#include <stdlib.h>

@interface GameWindow ()
@end

@implementation GameWindow

- (void) awakeFromNib {
    [super awakeFromNib];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.arrayOptions = [[NSMutableArray alloc] init];
    NSLog([self.fbDController lineOpen]);
    [self setGameWithOptionsAndImage];
    NSLog(@"%c", [self.activitySpinnerGW isAnimating]);
    NSLog(@"%c", TRUE);
    
    //[self.activitySpinnerGW setHidden:YES];
    //[self.activitySpinner setHidden:true];
    
}



- (void) setImage {
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithObjectsAndKeys:@"picture.height(150).width(150)",@"fields",nil];

    [FBRequestConnection startWithGraphPath:[self.blessedFriend id] parameters:params HTTPMethod:nil completionHandler:^(FBRequestConnection *connection,  //Get the friends list
                                                                     id data,                 //object and identify it as data.
                                                                     NSError *error) {
        if (!error) {
            [self.profilePicViewer setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[[data  valueForKey:@"picture"] data] valueForKey:@"url"]]]]];
        
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
    if(![self.activitySpinnerGW isAnimating]){
        [self.activitySpinnerGW startAnimating];
    }
    [self.profilePicViewer setHidden:true];
    [self.selectionPicker setHidden:true];
}

- (void) setDoneLoading {
    if([self.activitySpinnerGW isAnimating]){
        [self.activitySpinnerGW stopAnimating];
    }
    [self.profilePicViewer setHidden:false];
    [self.selectionPicker setHidden:false];
}

- (void) setGameWithOptionsAndImage {
    if([_arrayOptions count] > 0){
        [_arrayOptions removeAllObjects];
    }
    [self.selectionPicker reloadComponent:0];
    
    for(int i=0; i<3;i++){
        [_arrayOptions addObject:[self.fbDController getRandomFriendName]];
    }
    
    self.blessedFriend = [_fbDController getChosenFriend];
    [_arrayOptions addObject:[self.blessedFriend name]];
    
    [self shuffleOptions];
    [self.selectionPicker reloadComponent:0];
    [self setImage];
}

- (void) shuffleOptions {
    for (NSInteger i=0; i< [_arrayOptions count];i++){
        int elementsLeft = [_arrayOptions count] -i;
        int n = arc4random_uniform(elementsLeft) + i;
        
        [_arrayOptions exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
}



- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    
    return [_arrayOptions count];
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [_arrayOptions objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)submitForProcessing:(id)sender {
    //NSLog([self.blessedFriend name]);
    //NSLog([_arrayOptions objectAtIndex:[self.selectionPicker selectedRowInComponent:0]]);
    
    NSMutableString *msg = [[NSMutableString alloc] init];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Result" message:msg delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    
    if([self.blessedFriend name] == [_arrayOptions objectAtIndex:[self.selectionPicker selectedRowInComponent:0]]){
        [msg appendString:@"You got it right! \n"];
        [msg appendString:@"Congratulations "];
        [alert setMessage:msg];
        
        [self.fbDController incrementSuccesses];
    }else{
        NSString *correctAns = [[NSString alloc] initWithString:[self.blessedFriend name]];
        [msg appendString:@"The correct answer was \n"];
        [msg appendString:correctAns];
        [msg appendString:@"\n Better luck next time." ];
        
        [alert setMessage:msg];
    }
    
    [self setLoading];
    [alert show];
    
    [self.fbDController incrementAttempts];
    
    [self setGameWithOptionsAndImage];
}

- (IBAction)getResults:(id)sender {
    NSString *msg = [NSString stringWithFormat:@"Successes: %d \n Total Attempts: %d", [self.fbDController getSuccesses], [self.fbDController getAttempts]];
                  //  @"Successes: %d",;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Past Results" message:msg delegate:nil cancelButtonTitle:@"Finished" otherButtonTitles: nil];
    [alert show];

}

- (IBAction)setNewGame:(id)sender {
    [self setGameWithOptionsAndImage];
}
@end
