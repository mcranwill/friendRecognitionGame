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
@synthesize totalSuccesses;
@synthesize totalAttempts;

- (void) initializeDefaultDataController {
    self.friendsList = [[NSArray alloc] init];
    totalAttempts = 0;
    totalSuccesses = 0;
}

- (id)init {
    if (self = [super init]) {
        [self initializeDefaultDataController];
        return self;
    }
    return nil;
}

- (void) incrementSuccesses {
    totalSuccesses++;
}

- (void) incrementAttempts {
    totalAttempts++;
}

- (NSString*) getRandomFriendName {
    return [[self.friendsList objectAtIndex:arc4random_uniform(self.friendsList.count)] name];
}

- (id) getChosenFriend {
    return [self.friendsList objectAtIndex: arc4random_uniform(self.friendsList.count)];
}

- (NSString*) lineOpen {
    if (self.friendsList.count >0) {
        return @"success";
    } else {
        return @"fail, we did not get a new object.";
    }
    
}
@end
