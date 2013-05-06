//
//  ResultsObj.h
//  friendRecognitionGame
//
//  Created by Mike Cranwill on 3/21/13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResultsObj : NSObject

@property (nonatomic) NSString *userName;
@property (nonatomic) NSInteger totalAttempts;
@property (nonatomic) NSInteger totalSuccesses;

//- (id) initWithValue:(NSInteger *) num;
- (id) initWithValue:(NSString *) userName:(NSInteger *) tot;
- (id)initWithCoder:(NSKeyedUnarchiver *)aDecoder;
- (void)encodeWithCoder:(NSCoder *)aCoder;
- (NSInteger) returnAttempts;
- (NSInteger) returnSuccesses;
- (void) incrementResultAttempts;
- (void) incrementResultSuccesses;
@end
