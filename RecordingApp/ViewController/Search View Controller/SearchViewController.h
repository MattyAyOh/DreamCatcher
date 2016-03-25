//
//  HomeViewController.h
//  RecordingApp
//
//  Created by Mitul on 30/12/15.
//  Copyright (c) 2015 Om Info. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "DBConnection.h"
#import "DDMenuController.h"
#import <sqlite3.h>

@interface SearchViewController : UIViewController <UISearchBarDelegate,UITableViewDelegate, UITableViewDataSource>


@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
 
