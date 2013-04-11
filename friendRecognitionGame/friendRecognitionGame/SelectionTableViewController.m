//
//  SelectionTableViewController.m
//  friendRecognitionGame
//
//  Created by Mike Cranwill on 3/22/13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import "SelectionTableViewController.h"
#import "CustTableViewCell.h"

@interface SelectionTableViewController ()

@end

@implementation SelectionTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.arrayOptions = [[NSMutableArray alloc] init];
    self.lastRow = 10;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 4;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = [NSString stringWithFormat:@"s%i-r%i", indexPath.section, indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] ;
    }
    
    [_arrayOptions objectAtIndex:[indexPath row]];
    cell.textLabel.text =[_arrayOptions objectAtIndex:[indexPath row]];
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    /*NSInteger i=0;
    while (i < views.count) {
        NSLog(@"%d",i);
        NSLog(@"%@",views[i]);
        i++;
    }*/
    
    
    return cell;
}

-(void) onBtnchild:(id) sender{
    NSLog(@"HI");
}

- (void) setGameWithOptions{
    
   
    
    if([_arrayOptions count] > 0){
        [_arrayOptions removeAllObjects];
    }
   
    
    for(int i=0; i<3;i++){
        [_arrayOptions addObject:[self.fbDController getRandomFriendName]];
    }
    
    self.blessedFriend = [_fbDController getChosenFriend];
    [_arrayOptions addObject:[self.blessedFriend name]];
    
    [self shuffleOptions];
    [self.tableView reloadData];
}

- (void) shuffleOptions {
    for (NSInteger i=0; i< [_arrayOptions count];i++){
        int elementsLeft = [_arrayOptions count] -i;
        int n = arc4random_uniform(elementsLeft) + i;
        [_arrayOptions exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%d  and ip is %d",self.lastRow,[indexPath row]);
    
    if(self.lastRow == (NSInteger *)[indexPath row])
    {
        NSLog(@"was previously selected.");
    //[self.tableView ]
    }else{
    
        NSIndexPath *pass = [NSIndexPath indexPathForRow:self.lastRow inSection:0];
        UITableViewCell *prevCell = [self.tableView cellForRowAtIndexPath:pass];
        NSArray *prevViews = [prevCell subviews];
        /*NSInteger i=0;
        while (i < prevViews.count) {
            NSLog(@"%d",i);
            NSLog(@"%@",prevViews[i]);
            i++;
        }*/

        [prevViews[2] removeFromSuperview];
        
        
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button setTitle:@"Submit" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(submitFromButton:) forControlEvents:UIControlEventTouchUpInside];
        //[button setBackgroundColor:[UIColor whiteColor]];
        [button setFrame:CGRectMake(250, 2, 60,40)];
        [cell addSubview:button];
        //NSArray *views = [cell subviews];
        //[views[1] setHidden:true];
    
        
        NSLog(@"%d", self.lastRow);
    
        self.lastRow = [indexPath row];
    }
    
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

#pragma mark - Table view delegate


- (void)submitFromButton:(id)sender {
    
    NSIndexPath *ip = [[self tableView] indexPathForSelectedRow];
    
    //UITableViewCell *prevCell = ;
    NSInteger i=0;
    
    
    NSArray *prevViews = [[self.tableView cellForRowAtIndexPath:ip] subviews];
    
    [prevViews[3] removeFromSuperview];
    self.lastRow= 10;
    
    NSMutableString *msg = [[NSMutableString alloc] init];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Result" message:msg delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    
   
    if([[self blessedFriend] name] == [[self arrayOptions] objectAtIndex:[ip row]]){
        [msg appendString:@"You got it right! \n"];
        [msg appendString:@"Congratulations "];
        [alert setMessage:msg];
        
        [self.fbDController incrementSuccesses];
    }else{
        NSString *correctAns = [[NSString alloc] initWithString:[[self blessedFriend] name]];
        [msg appendString:@"The correct answer was \n"];
        [msg appendString:correctAns];
        [msg appendString:@"\n Better luck next time." ];
        
        [alert setMessage:msg];
    }
    
    [self.gwindow setLoading];
    [self.fbDController incrementAttempts];
    
    [self.fbDController writeResultsToFile];
    [alert show];
    
    [self setGameWithOptions];
    [self.gwindow setImage];
}
@end
