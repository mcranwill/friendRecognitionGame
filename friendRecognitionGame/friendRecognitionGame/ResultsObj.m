//
//  ResultsObj.m
//  friendRecognitionGame
//
//  Created by Mike Cranwill on 3/21/13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import "ResultsObj.h"

@implementation ResultsObj
@synthesize totalAttempts;
@synthesize totalSuccesses;
@synthesize userName;


- (id) initWithValue:(NSString *) text:(NSInteger *) tot{
    self = [super init ];
        self.userName = text;
        self.totalSuccesses = tot;
        self.totalAttempts = tot;
    //NSLog(@"this is self.%@",self);
    return self;
}

- (NSInteger) returnAttempts{
    return self.totalAttempts;
}
- (NSInteger) returnSuccesses{
    return self.totalSuccesses;
}

- (id)initWithCoder:(NSKeyedUnarchiver *)aDecoder{
    if ((self = [super init])) {
        self.userName = [aDecoder decodeObjectForKey:@"username"];
        self.totalAttempts = [aDecoder decodeIntegerForKey:@"attempts"];
        self.totalSuccesses = [aDecoder decodeIntegerForKey:@"success"];
        //   [self setText:[aDecoder decodeObjectForKey:@"theText"]];
    }
    return self;

}
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.userName forKey:@"username"];
    [aCoder encodeInteger:self.totalAttempts forKey:@"attempts"];
    [aCoder encodeInteger:self.totalSuccesses forKey:@"success"];
    
}

- (void) incrementResultAttempts {
    //NSLog([NSString stringWithFormat:@"attempts: %d",self.totalAttempts]);
    self.totalAttempts++;
    //NSLog([NSString stringWithFormat:@"attempts: %d",self.totalAttempts]);
}
- (void) incrementResultSuccesses{
    self.totalSuccesses++;
}
@end
