//
//  FRGLoggedInBaseViewController.h
//  friendRecognitionGame
//
//  Created by Mike Cranwill on 2/21/13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FRGLoggedInBaseViewController : UIViewController
- (IBAction)performLogout:(id)sender;
@property (strong, nonatomic) IBOutlet UITextView *userInfoTextView;


@end
