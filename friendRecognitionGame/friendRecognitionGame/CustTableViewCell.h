//
//  CustTableViewCell.h
//  friendRecognitionGame
//
//  Created by Mike Cranwill on 3/28/13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustTableViewCell : UITableViewCell
@property UILabel *texLabel;
@property UIButton *submitButton;

-(void) setTexLabelText:(NSString*) text;

@end
