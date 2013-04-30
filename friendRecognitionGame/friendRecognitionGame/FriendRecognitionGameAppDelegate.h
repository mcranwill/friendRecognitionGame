//
//  FriendRecognitionGameAppDelegate.h
//  friendRecognitionGame
//
//  Created by Mike Cranwill on 2/6/13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "FRGLoginViewController.h"
//#import "FRGViewController.h"
#import "FRGLoggedInBaseViewController.h"

@interface FriendRecognitionGameAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
extern NSString *const FBSessionStateChangedNotification;
@property (strong, nonatomic) FRGLoginViewController *loginController;
@property (strong, nonatomic) FRGLoggedInBaseViewController *loggedInController;
//typedef void(^TypeComplitionHandler)(id result)
- (void) openSession;
- (void) closeSession;

@end
