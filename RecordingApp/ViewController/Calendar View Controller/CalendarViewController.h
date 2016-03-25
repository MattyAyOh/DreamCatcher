//
//  Calendar.h
//  RecordingApp
//
//  Created by Mitul on 28/12/15.
//  Copyright (c) 2015 Om Info. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "CalendarView.h"
#import "DBConnection.h"
#import "DetailsViewController.h"


@interface CalendarViewController : UIViewController<CalendarDelegate,CalendarDataSource>


@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UILabel *lblCell;
@property (strong, nonatomic) IBOutlet UIImageView *imgCell;
@property (strong, nonatomic) IBOutlet UIView *txv_Header;


@end
