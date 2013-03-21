//
//  ResultsObj.h
//  friendRecognitionGame
//
//  Created by Mike Cranwill on 3/21/13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResultsObj : NSObject
@property (nonatomic) NSInteger totalAttempts;
@property (nonatomic) NSInteger totalSuccesses;

//- (id) initWithValue:(NSInteger *) num;
- (id) initWithValue:(NSInteger *) tot;
- (id)initWithCoder:(NSKeyedUnarchiver *)aDecoder;
- (void)encodeWithCoder:(NSCoder *)aCoder;
- (void) incrementResultAttempts;
- (void) incrementResultSuccesses;
@end
