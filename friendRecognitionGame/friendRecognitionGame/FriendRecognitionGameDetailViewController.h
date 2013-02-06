//
//  FriendRecognitionGameDetailViewController.h
//  friendRecognitionGame
//
//  Created by Mike Cranwill on 2/6/13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendRecognitionGameDetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
