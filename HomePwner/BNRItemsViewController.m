//
//  BNRItemsViewController.m
//  HomePwner
//
//  Created by William Kong on 2014-05-17.
//  Copyright (c) 2014 William Kong. All rights reserved.
//

#import "BNRItemsViewController.h"
#import "BNRDetailViewController.h"
#import "BNRItemStore.h"
#import "BNRItem.h"
#import "BNRItemCell.h"


@interface BNRItemsViewController ()

@property (nonatomic, strong) IBOutlet UIView *headerView;

@end


@implementation BNRItemsViewController

#pragma mark - Controller life cycle
- (instancetype)init
{
    // call the superclass' designated initializer
    self = [super initWithStyle:UITableViewStylePlain];
    
    if (self) {
        UINavigationItem *navItem = self.navigationItem;
        navItem.title = @"Homepwner";
        
        // Create new bar button item that will send addNewItem to BNRItemsViewController
        UIBarButtonItem *bbi = [[UIBarButtonItem alloc]
                                initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                target:self action:@selector(addNewItem:)];
        
        navItem.rightBarButtonItem = bbi;
        
        navItem.leftBarButtonItem = self.editButtonItem;
    }
    
    return self;
}

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    return [self init];
}

#pragma mark - View life cycle
-(void)viewDidLoad
{
    [super viewDidLoad];
    
    // Load the NIB file
    UINib *nib = [UINib nibWithNibName:@"BNRItemCell" bundle:nil];
    
    // Note: Beginning in iOS 5, clients could only register NIBs.
    // In iOS 6, clients could register a nib or class for each cell.
    [self.tableView registerNib:nib
         forCellReuseIdentifier:@"BNRItemCell"];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
    
}

#pragma mark - Actions
- (IBAction)addNewItem:(id)sender
{
    // Create new BNRItem and add it to store
    BNRItem *newItem = [[BNRItemStore sharedStore] createItem];
    
    BNRDetailViewController *detailViewController = [[BNRDetailViewController alloc] initForNewItem:YES];
    
    detailViewController.item = newItem;
    detailViewController.dismissBlock = ^{
        [self.tableView reloadData];
    };
    
    UINavigationController *navController = [[UINavigationController alloc]
                                             initWithRootViewController:detailViewController];
    
    
    navController.modalPresentationStyle = UIModalPresentationFormSheet;
    navController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    [self presentViewController:navController animated:YES completion:nil];
}

#pragma mark - TableViewDataSource delegates
// implementation required UITableViewDataSource method
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[BNRItemStore sharedStore] allItems] count];
}

// implement required UITableViewDataSource method
-(UITableViewCell*) tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // get a cell from data pool
    BNRItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BNRItemCell" forIndexPath:indexPath];
    
    
    // set text
    NSArray *items = [[BNRItemStore sharedStore] allItems];
    BNRItem *item = items[indexPath.row];
    
//    cell.textLabel.text = [item description];
    
    // configure cell with BNRItem
    cell.nameLabel.text = item.itemName;
    cell.serialNumberLabel.text = item.serialNumber;
    cell.valueLabel.text = [NSString stringWithFormat:@"$%d", item.valueInDollars];

    
    return cell;
}

#pragma mark - TableView delegates
// tableView handler for deleting or inserting rows.
-(void)tableView:(UITableView *)tableView
    commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
     forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // if table view is asking to commit a delete command...
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSArray *items = [[BNRItemStore sharedStore] allItems];
        BNRItem *item = items[indexPath.row];
        [[BNRItemStore sharedStore] removeItem:item];
        
        // also, remove that row from the table view with an animation
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    // TBD the other editing style is Inserting a Row.
} 

// tableView handler for moving rows 
- (void) tableView:(UITableView *)tableView
moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath
       toIndexPath:(NSIndexPath *)destinationIndexPath
{
    [[BNRItemStore sharedStore] moveItemAtIndex:sourceIndexPath.row
                                        toIndex:destinationIndexPath.row];
}

// Called after the user makes the selection.
- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BNRDetailViewController *dvc = [[BNRDetailViewController alloc] initForNewItem:NO];
    
    
    NSArray *items = [[BNRItemStore sharedStore] allItems];
    BNRItem *selectedItem = items[indexPath.row];
    
    // give Detail View Controller a pointer ot the item object in row
    dvc.item = selectedItem;
    
    // push to top of nav controller's stack
    [self.navigationController pushViewController:dvc
                                         animated:YES];
    
}

@end
