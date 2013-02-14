//
//  FRGLoginViewController2.h
//  friendRecognitionGame
//
//  Created by Mike Cranwill on 2/14/13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FRGLoginViewController2 : UIViewController
- (IBAction)performLogin:(id)sender;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
- (void)loginFailed;
@end
