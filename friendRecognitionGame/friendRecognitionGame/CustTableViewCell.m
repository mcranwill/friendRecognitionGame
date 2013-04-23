//
//  CustTableViewCell.m
//  friendRecognitionGame
//
//  Created by Mike Cranwill on 3/28/13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import "CustTableViewCell.h"

@implementation CustTableViewCell
@synthesize submitButton;
@synthesize texLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setTexLabelText:(NSString*) text {
    texLabel.text= text;
    
}

@end
