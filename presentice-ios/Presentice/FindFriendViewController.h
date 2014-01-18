//
//  FindFriendViewController.h
//  Presentice
//
//  Created by PhuongNQ on 1/18/14.
//  Copyright (c) 2014 Presentice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MFSideMenu.h"
#import <Parse/Parse.h>
#import "FindFriendCell.h"
#import "PresenticeCache.h"
#import "PresenticeUtitily.h"

@interface FindFriendViewController : PFQueryTableViewController <UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource>
- (IBAction)showLeftMenu:(id)sender;
- (IBAction)showRightMenu:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *followAllBtn;

@end