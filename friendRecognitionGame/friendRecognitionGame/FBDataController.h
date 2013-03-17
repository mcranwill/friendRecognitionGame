//
//  FBDataController.h
//  friendRecognitionGame
//
//  Created by Mike Cranwill on 2/21/13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import <FacebookSDK/FacebookSDK.h>

@interface FBDataController : FBGraphObject
@property (nonatomic, copy) NSArray *friendsList;
@property NSInteger totalAttempts;
@property NSInteger totalSuccesses;
- (void) initializeDefaultDataController;
- (void) incrementSuccesses;
- (void) incrementAttempts;
- (NSString*) getRandomFriendName;
//- (UIImageView *) requestProfilePic: (NSString *) blessedFriend;
- (id) getChosenFriend;
- (NSString *) requestFriendsList;
- (NSString*) lineOpen;
@end
