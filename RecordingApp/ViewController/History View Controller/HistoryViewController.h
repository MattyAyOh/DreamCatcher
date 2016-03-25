//
//  HistoryViewController.h
//  RecordingApp
//
//  Created by Mitul on 30/12/15.
//  Copyright (c) 2015 Om Info. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "DBConnection.h"
#import <sqlite3.h>
#import "IndexViewController.h"

@interface HistoryViewController : UIViewController

@property (nonatomic, retain)NSDictionary *detailsindex;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
