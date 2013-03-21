//
//  ResultsObj.m
//  friendRecognitionGame
//
//  Created by Mike Cranwill on 3/21/13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import "ResultsObj.h"

@implementation ResultsObj

- (id) initWithValue:(NSInteger *) tot{
    self = [super init ];
        self.totalSuccesses = tot;
        self.totalAttempts = tot;
    //NSLog(@"this is self.%@",self);
    return self;
}


- (id)initWithCoder:(NSKeyedUnarchiver *)aDecoder{
    if ((self = [super init])) {
        self.totalAttempts = [aDecoder decodeIntegerForKey:@"attempts"];
        self.totalSuccesses = [aDecoder decodeIntegerForKey:@"success"];
        //   [self setText:[aDecoder decodeObjectForKey:@"theText"]];
    }
    return self;

}
- (void)encodeWithCoder:(NSCoder *)aCoder{
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

/*- (void) setTotalAttempts:(NSInteger)totalAttempts {
    self.totalAttempts = totalAttempts;
}

- (void) setTotalSuccesses:(NSInteger)totalSuccesses {
    self.totalSuccesses = totalSuccesses;
}*/
@end
