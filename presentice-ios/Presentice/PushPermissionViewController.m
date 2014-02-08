//
//  PushPermissionViewController.m
//  Presentice
//
//  Created by レー フックダイ on 1/10/14.
//  Copyright (c) 2014 Presentice. All rights reserved.
//

#import "PushPermissionViewController.h"

@interface PushPermissionViewController ()


@end

@implementation PushPermissionViewController {
    NSArray *pushType;
}

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    pushType = @[@"viewed", @"reviewed", @"answered", @"messaged", @"followed", @"registered"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.pushPermission count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    NSString *type = [pushType objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ :%@", NSLocalizedString([type capitalizedString], nil), NSLocalizedString([self.pushPermission objectForKey:type], nil)];
    
    // Add a switch
    UISwitch *switchView = [[UISwitch alloc] initWithFrame:CGRectZero];
    cell.accessoryView = switchView;
    if ([[self.pushPermission objectForKey:type] isEqualToString:@"yes"]) {
        [switchView setOn:YES animated:YES];
    } else {
        [switchView setOn:NO animated:YES];
    }
    switchView.tag = indexPath.row;
    NSLog(@"fuck switchView = %hhd",[switchView isOn]);
    [switchView addTarget:self action:@selector(updateSwitch:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (void)updateSwitch:(UISwitch *)switchView {
    if ([switchView isOn]) {
        [self.pushPermission setObject:@"yes" forKey:[pushType objectAtIndex:switchView.tag]];
    } else {
        [self.pushPermission setObject:@"no" forKey:[pushType objectAtIndex:switchView.tag]];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if (self.isMovingFromParentViewController) {
        [self.delegate receiveData:self.pushPermission];
        NSLog(@"currentUser = %@", [[PFUser currentUser] objectForKey:kUserNameKey]);
        [[PFUser currentUser] setObject:self.pushPermission forKey:kUserPushPermission];
        [[PFUser currentUser] saveInBackground];
    }
}

@end
