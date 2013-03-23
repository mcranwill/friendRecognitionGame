//
//  SelectionTableViewController.h
//  friendRecognitionGame
//
//  Created by Mike Cranwill on 3/22/13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBDataController.h"

@interface SelectionTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>
//@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) FBDataController *fbDController;
@property (strong, nonatomic) NSMutableArray *arrayOptions;
@property id blessedFriend;

- (void) setGameWithOptions;
- (void) shuffleOptions;

@end
