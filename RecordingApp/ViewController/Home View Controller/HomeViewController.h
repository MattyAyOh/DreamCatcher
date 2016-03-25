//
//  MainViewController.h
//  RecordingApp
//
//  Created by Om Infowave on 09/01/16.
//  Copyright © 2016 Om Info. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface HomeViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITableView *tableview;

@property (strong, nonatomic) IBOutlet UIButton *toneButton;

@property IBOutlet UIImageView *muteButtonImageView;

@end
