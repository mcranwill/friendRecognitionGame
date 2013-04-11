//
//  FRGgameWindowWithTables.h
//  friendRecognitionGame
//
//  Created by Mike Cranwill on 3/22/13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBDataController.h"

@interface GameWindow : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *profilePicView;
@property (strong, nonatomic) FBDataController *fbDController;

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activitySpinnerTab;
- (void) setImage;
- (IBAction)submitTProcessing:(id)sender;
- (IBAction)receiveNewGame:(id)sender;
- (IBAction)requestResults:(id)sender;
- (void) setDoneLoading;
- (void) setLoading;
@end
