//
//  FBDataController.h
//  friendRecognitionGame
//
//  Created by Mike Cranwill on 2/21/13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import <FacebookSDK/FacebookSDK.h>
#import "ResultsObj.h"

@interface FBDataController : FBGraphObject
@property (nonatomic, copy) NSArray *friendsList;
@property (nonatomic) ResultsObj *results;
@property (nonatomic) NSString *user;
- (NSInteger) getAttempts;
- (NSInteger) getSuccesses;
- (void) incrementSuccesses;
- (void) incrementAttempts;
- (NSString*) getRandomFriendName;
- (id) getChosenFriend;
- (NSString*) lineOpen;
- (void) addResultObj:(ResultsObj *)res;
- (void) writeResultsToFile;
@end
