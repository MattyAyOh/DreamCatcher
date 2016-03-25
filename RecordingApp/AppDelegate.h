//
//  AppDelegate.h
//  RecordingApp
//
//  Created by Mitul on 21/12/15.
//  Copyright (c) 2015 Om Info. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDMenuController.h"
#import "MenuViewController.h"
#import "HomeViewController.h"
#import "CalendarViewController.h"
#import "HistoryViewController.h"
#import "IndexViewController.h"
#import "InputDreamViewController.h"
#import "RecordViewController.h"
#import "DetailsViewController.h"
#import "SearchViewController.h"

#define ApplicationDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)


@interface AppDelegate : UIResponder <UIApplicationDelegate>


@property (strong, nonatomic) UIWindow *window;

@property (nonatomic,strong) UINavigationController *navCon1, *navCon2, *navCon3, *navCon4;

@property (nonatomic, strong) UITabBarController *tabcon;

@property(strong,nonatomic)DDMenuController *menu;

@end

