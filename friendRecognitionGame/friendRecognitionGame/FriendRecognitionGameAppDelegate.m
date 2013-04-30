//
//  FriendRecognitionGameAppDelegate.m
//  friendRecognitionGame
//
//  Created by Mike Cranwill on 2/6/13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import "FriendRecognitionGameAppDelegate.h"
#import "FRGLoginViewController.h"
#import "FRGLoggedInBaseViewController.h"

@interface FriendRecognitionGameAppDelegate ()

//@property (strong, nonatomic) UINavigationController* navController;
-(void) showLoginView;

@end

@implementation FriendRecognitionGameAppDelegate

NSString *const FBSessionStateChangedNotification =
@"com.example.Login:FBSessionStateChangedNotification";
@synthesize loginController = _loginController;
@synthesize loggedInController = _loggedInController;
//@synthesize mainViewController = _mainViewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //self.loginController = [[FRGLoginViewController alloc] i]; // Override point for customization after application launch.
    /*self.navController = [[UINavigationController alloc]
                          initWithRootViewController:self.mainViewController];
    self.window.rootViewController = self.navController;
    [self.window makeKeyAndVisible];
    */
    //self.loginController = [[FRGLoginViewController alloc] i
    //NSLog(@"In the initial call");
    if (FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded){ //See if we have a valid token for the current state.
        //show logged in view
        [self openSession];
        //NSLog(@"we have a valid token");
    }else{
        //no display the login page.
        [self showLoginView];
    }
    return YES;
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return [FBSession.activeSession handleOpenURL:url];
}

- (void) showLoginView {
   /* UIViewController *topViewController = [self.navController topViewController];
    
    FRGLoginViewController* loginViewController = [[FRGLoginViewController alloc] initWithNibName:@"FRGLoginViewController2" bundle:nil];
    [topViewController presentModalViewController:loginViewController animated:NO ];*/
    
    UIViewController *topViewController = self.window.rootViewController;
    //UIViewController *modalViewController = [topViewController modalViewController];
    // If the login screen is not already displayed, display it. If the login screen is
    // displayed, then getting back here means the login in progress did not successfully
    // complete. In that case, notify the login view so it can update its UI appropriately.
    if (![topViewController isKindOfClass:[FRGLoginViewController class]]) {
        NSLog(@"kind of class succeeded!!");
        FRGLoginViewController* loginViewController = self.loginController;
        [topViewController presentViewController:loginViewController animated:NO completion:nil];
    } else {
        NSLog(@"%@",topViewController);
        NSLog(@"kind of class failed");
        FRGLoginViewController* loginViController = (FRGLoginViewController*) topViewController;
        [loginViController loginFailed];
    }

}


- (void)sessionStateChanged:(FBSession *)session
                      state:(FBSessionState) state
                      error:(NSError *)error
{
   // NSLog(@"State has changed");
    //NSLog((NSString *) state);
    switch (state) {
        case FBSessionStateOpen: {
            //NSLog(@"state is currently open.");
            if (!error) {
                /*UIViewController *topViewController = self.window.rootViewController;
                // We have a valid session
                NSLog(@"User session found");
                //[curViewController dismissViewControllerAnimated:YES completion:nil];
                //FRGLoginViewController* loginViewController = self.loginController;
                if (![topViewController isKindOfClass:[FRGLoggedInBaseViewController class]]) {
                    NSLog(@"kind of class succeeded");
                    FRGLoggedInBaseViewController* loggedInController = self.loggedInController;
                    [topViewController presentViewController:loggedInController animated:NO completion:nil];
                } else {
                    NSLog(@"kind of class failed");
                    FRGLoggedInBaseViewController* loggedInController = (FRGLoggedInBaseViewController*) topViewController;
                    //[FRGLoggedInBaseViewController loginFailed];
                    [topViewController presentViewController:loggedInController animated:NO completion:nil];
                }
                FRGLoggedInBaseViewController* loggedInController = self.loggedInController;
                [topViewController presentViewController:loggedInController animated:YES completion:nil];
                
                //[self reautorizarPermisos:self ];*/
                //[self.loginController performSegueWithIdentifier:@"loginSuccess" sender:self.loginController];
                //loginSuccess
                //[self.window.rootViewController perfSeg];
                NSLog(@"User session found");
                /*FRGLoginViewController* loginViewController = (FRGLoginViewController*) self.window.rootViewController;;
                [loginViewController performSegueWithIdentifier:@"loginSuccess" sender:loginViewController];
*/
                /*if([self.window.rootViewController isKindOfClass:[FRGLoginViewController class]] ){
                    FRGLoginViewController* loginViController = (FRGLoginViewController*) self.window.rootViewController;*/
                    //[loginViController perfSeg];
                //}
            }
             break;
        }
        case FBSessionStateClosed:{
            //NSLog(@"session closed successfully!");
            break;
        }
            
        case FBSessionStateClosedLoginFailed:
            [FBSession.activeSession closeAndClearTokenInformation];
            
            [self showLoginView];
            break;
        default:
            break;
    }
    
    if (error) {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Error"
                                  message:error.localizedDescription
                                  delegate:nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }
}

- (void)openSession
{
    NSArray *permissions = [[NSArray alloc] initWithObjects:
                            @"user_location",
                            @"user_birthday",
                            @"read_friendlists",
                            @"user_likes",
                            @"user_photos",
                            @"friends_photos",
                            nil];
    [FBSession openActiveSessionWithReadPermissions:permissions
                                       allowLoginUI:YES
                                  completionHandler:
     ^(FBSession *session,
       FBSessionState state, NSError *error) {
         [self sessionStateChanged:session state:state error:error];
     }];
}



- (void) closeSession {
    [FBSession.activeSession closeAndClearTokenInformation];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    // We need to properly handle activation of the application with regards to Facebook Login
    // (e.g., returning from iOS 6.0 Login Dialog or from fast app switching).
    [FBSession.activeSession handleDidBecomeActive];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
