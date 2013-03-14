//
//  FBDataController.m
//  friendRecognitionGame
//
//  Created by Mike Cranwill on 2/21/13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import "FBDataController.h"
#include <stdlib.h>

@implementation FBDataController

- (void) initializeDefaultDataController {
    //[super init];
    self.friendsList = [[NSArray alloc] init];
}

- (id)init {
    if (self = [super init]) {
        [self initializeDefaultDataController];
        return self;
    }
    return nil;
}

- (NSString*) getRandomFriendName {
    return [[self.friendsList objectAtIndex:arc4random_uniform(self.friendsList.count)] name];
}

- (id) getChosenFriend {
    //id temp = [self.friendsList objectAtIndex:<#(NSUInteger)#>]
    return [self.friendsList objectAtIndex: arc4random_uniform(self.friendsList.count)];
}

- (NSString*) lineOpen {
    if (self.friendsList.count >0) {
        return @"success";
    } else {
        return @"fail, we did not get a new object.";
    }
    
}

/*- (NSString *) requestFriendsList{
       
    __block NSString *userInfo = [[NSString alloc] init];
    __block int x=0;
    //__block
    NSLog([NSString stringWithFormat:@"%d", x]);
    [FBRequestConnection
     startForMyFriendsWithCompletionHandler:^(FBRequestConnection *connection,  //Get the friends list
                                              id data,                 //object and identify it as data.
                                              NSError *error) {
         if (!error) {
             //Update friends list
             self.friendsList = (NSArray*)[data data];
             //Code to print out friends List
             
             NSMutableArray *friendNames = [[NSMutableArray alloc] init];
             //NSLog([NSString stringWithFormat:@"%d", [self.friendsList count]]);
             for (int i =0; i <[self.friendsList count]; i++){           //add each friend name to friendNames.
                 
                 [friendNames addObject:[[self.friendsList objectAtIndex:i] name]];
             }
             userInfo = [userInfo
                         stringByAppendingString:
                         [NSString stringWithFormat:@"friendNames: %@\n\n",
                          friendNames]];            //add friendNames object to userInfo.
             
             x++;
             
             //[userInfo retain];
             //NSLog(userInfo);
             //NSLog([NSString stringWithFormat:@"%d and I am in requestFriendsList", [self.friendsList count]]);
         }
     }];
    NSLog([NSString stringWithFormat:@"%d", x]);
    //NSLog(@"I survived");
    //NSLog(userInfo);
    return userInfo;
    
}*/

/*- (UIImageView *) requestProfilePic: (NSString *) blessedFriend{
    __block UIImageView *profilePic = [[UIImageView alloc] init];
    NSMutableString *path = @"";
    [path appendString:blessedFriend];
    [path appendString:@"/picture"];
    [FBRequestConnection startWithGraphPath:path completionHandler:^(FBRequestConnection *connection,  //Get the friends list
                                                                     id data,                 //object and identify it as data.
                                                                     NSError *error) {
        if (!error) {
            //Update friends list
            profilePic = (UIImageView *)[data imageView];
        }
    }];
    
    return profilePic;
    
}*/
@end
