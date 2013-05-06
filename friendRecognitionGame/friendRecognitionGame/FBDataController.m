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


- (id)init {
    if (self = [super init]) {
        self.friendsList = [[NSArray alloc] init];
        self.allResults = [[NSMutableArray alloc] init];
        //self.results = [[ResultsObj alloc] initWithValue:0];
        return self;
    }
    return nil;
}

- (void) addResultsForCurrentUser{
    NSLog(@"Beginning add results to current user. Current username is %@",self.user);
    int i =0;
    bool found = false;
    if([self.allResults count]> 0){
        while(i < [self.allResults count] && !found){
            NSLog(@"%@",[[self.allResults objectAtIndex:i] userName]);
            
            if([[[self.allResults objectAtIndex:i] userName] isEqualToString:[self user]]){
                NSLog(@"string comparison evaluated to true");
                found=true;
                self.resultsIndex = i;
            }
            i++;
        }
    }else{
        NSLog(@"allResults was previously empty.  Add the current session. With user %@",self.user);
        [self.allResults addObject:[[ResultsObj alloc] initWithValue:self.user :0]];
        self.resultsIndex = i;
    }
}

- (void)addResultObj:(ResultsObj *)res {
    if(res != nil){
        [[self allResults] addObject:res];
        NSLog(@"added object successfully.");
    }else{
        NSLog(@"incoming object was nil.");
    }
    //[self setResults:res];
}

- (void) incrementSuccesses {
    [[self.allResults objectAtIndex:self.resultsIndex]  incrementResultSuccesses] ;
    //_results.totalSuccesses++;
}

- (void) incrementAttempts {
    [[self.allResults objectAtIndex:self.resultsIndex]  incrementResultAttempts] ;
    //[self.results incrementResultAttempts];
}

- (NSInteger) getSessionAttempts{
    return [[self.allResults objectAtIndex:self.resultsIndex] returnAttempts];
}

- (NSInteger) getSessionSuccesses{
    
    return [[self.allResults objectAtIndex:self.resultsIndex] returnSuccesses];
}

- (NSString*) getRandomFriendName {
    return [[self.friendsList objectAtIndex:arc4random_uniform(self.friendsList.count)] name];
}

- (void) writeResultsToFile{
    NSLog(@"We are beginning to write results to file.");
    NSLog(@"Current username is %@",self.user);
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    // paths[0];
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *archivePath = [documentsDirectory stringByAppendingPathComponent:@"data.tlist"];
    
    NSMutableData *data = [NSMutableData data];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    
    NSMutableString *tempKey = [[NSMutableString alloc] init];
    [tempKey appendString:@"key"];
    NSLog(@"%d",[self.allResults count]);
    for (int i=0; i<[self.allResults count]; i++) {
        [tempKey appendString:@"1"];
        [archiver encodeObject:[self.allResults objectAtIndex:i] forKey:tempKey];
        NSLog(@"%@",[[self.allResults objectAtIndex:i] userName]);
    }
    /*for (ResultsObj *temp in self.allResults) {
        [archiver encodeObject:temp forKey: @"key"];
    }*/
    //[archiver encodeObject:self.results forKey: @"key"];
    [archiver finishEncoding];
    
    BOOL success = [data writeToFile:archivePath atomically:YES];
    if (success) {
        NSLog(@"printed successfully");
    }else {
        NSLog(@"something failed");
    }
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
