//
//  GameWindow.h
//  friendRecognitionGame
//
//  Created by Mike Cranwill on 2/26/13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBDataController.h"

@interface GameWindow : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (strong, nonatomic) FBDataController *fbDController;

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activitySpinnerGW;
@property (strong, nonatomic) IBOutlet UIImageView *profilePicViewer;
@property (strong, nonatomic) IBOutlet UIPickerView *selectionPicker;
@property (strong, nonatomic) NSMutableArray *arrayOptions;

@property id blessedFriend;
- (IBAction)getResults:(id)sender;

- (void) setImage;
- (void) setDoneLoading;
- (void) setLoading;
- (IBAction)submitForProcessing:(id)sender;
- (IBAction)setNewGame:(id)sender;
@end

/*
 NSEnumerator *enumerat = [data keyEnumerator];
 id key;
 // extra parens to suppress warning about using = instead of ==
 while((key = [enumerat nextObject]))
 NSLog(@"key=%@ value=%@", key, [data objectForKey:key]);
 */

