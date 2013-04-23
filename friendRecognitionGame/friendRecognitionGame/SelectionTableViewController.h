//
//  SelectionTableViewController.h
//  friendRecognitionGame
//
//  Created by Mike Cranwill on 3/22/13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBDataController.h"
#import "GameWindow.h"

@interface SelectionTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>
//@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property NSInteger *lastRow;
- (void)submitFromButton:(id)sender;
//- (IBAction)submitFromButton:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) FBDataController *fbDController;
@property (strong,nonatomic) GameWindow *gwindow;
@property (strong, nonatomic) NSMutableArray *arrayOptions;
@property id blessedFriend;

- (void) removeSubmitButton:(NSIndexPath *) curIp;
- (void) setGameWithOptions;
- (void) shuffleOptions;

@end
