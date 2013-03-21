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
    
}

- (id)init {
    if (self = [super init]) {
        self.friendsList = [[NSArray alloc] init];
        self.results = [[ResultsObj alloc] initWithValue:0];
        //NSLog(@"... %@",self.results);

        return self;
    }
    return nil;
}

- (void)addResultObj:(ResultsObj *)res {
    NSLog(@"%@",res);
    [self setResults:res];
}
//
//- (void) setResults:(ResultsObj *)results {
//    _results.totalAttempts = results.totalAttempts;
//    _results.totalSuccesses = results.totalSuccesses;
//}

- (void) incrementSuccesses {
    [self.results incrementResultSuccesses];
    //_results.totalSuccesses++;
}

- (void) incrementAttempts {
    //NSLog([NSString stringWithFormat:@"attempts: %d",self.results.totalAttempts]);
    //NSLog(@"%@",self.results);
    [self.results incrementResultAttempts];
    //NSLog([NSString stringWithFormat:@"attempts: %d",self.results.totalAttempts]);
    //_results.totalAttempts++;
}

- (NSInteger) getAttempts{
    return self.results.totalAttempts;
}
- (NSInteger) getSuccesses{
    return self.results.totalSuccesses;
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
