//
//  AppDelegate.m
//  RecordingApp
//
//  Created by Mitul on 21/12/15.
//  Copyright (c) 2015 Om Info. All rights reserved.
//

#import "AppDelegate.h"
#import "DDMenuController.h"
#import "DBConnection.h"
@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize navCon1,navCon2,navCon3,navCon4, menu;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [UIApplication sharedApplication].idleTimerDisabled = YES;
    
    [DBConnection sharedConnection];
    
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    
    UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"Main" bundle:nil];
   
        /* CUSTOM NAVIGATION AND TAB BAR SETTING*/
    HomeViewController *mainview = [storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
    navCon1 = [[UINavigationController alloc] initWithRootViewController:mainview];
   /* homeview.tabBarItem.title = @"Search";
    homeview.tabBarItem.image = [UIImage imageNamed:@"Search"];
    homeview.navigationItem.title = @"Dreamcatcher";
    navCon1.viewControllers = [NSArray arrayWithObjects:homeview, nil];*/
    
    
    CalendarViewController *calview = [storyboard instantiateViewControllerWithIdentifier:@"CalendarViewController"];
    navCon2 = [[UINavigationController alloc] initWithRootViewController:calview];
    calview.tabBarItem.title = @"Journal";
    calview.tabBarItem.image = [UIImage imageNamed:@"Journal"];
    calview.navigationItem.title = @"";
    navCon2.viewControllers = [NSArray arrayWithObjects:calview, nil];

    
    HistoryViewController *history = [storyboard instantiateViewControllerWithIdentifier:@"HistoryViewController"];
    navCon3 = [[UINavigationController alloc] initWithRootViewController:history];
    history.tabBarItem.title = @"History";
    history.tabBarItem.image = [UIImage imageNamed:@"History"];
    history.navigationItem.title = @"";
    navCon3.viewControllers = [NSArray arrayWithObjects:history, nil];
    
    IndexViewController *index = [storyboard  instantiateViewControllerWithIdentifier:@"IndexViewController"];
    navCon4 = [[UINavigationController alloc] initWithRootViewController:index];
    index.tabBarItem.title = @"Index";
    index.tabBarItem.image = [UIImage imageNamed:@"Index"];
    index.navigationItem.title = @"";
    navCon4.viewControllers = [NSArray arrayWithObjects:index, nil];
    
    /* NAVIGATION BAR TITLE IMAGE AND COLOR */
    
    //[[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"Cloud"] forBarMetrics:UIBarMetricsDefault];
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:0/255.0 green:172/255.0 blue:237/255.0 alpha:1]];
    
    DDMenuController *rootController = [[DDMenuController alloc] initWithRootViewController:navCon1];
    
    menu =rootController;
    
    rootController.leftViewController = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
    
    navCon1.navigationBar.translucent=NO;
    
    [navCon1.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    navCon2.navigationBar.translucent=NO;
    
    [navCon2.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    navCon3.navigationBar.translucent=NO;
    
    [navCon3.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    navCon4.navigationBar.translucent=NO;
    
    [navCon4.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    rootController.rightViewController = nil;
    
    [_tabcon setSelectedIndex:0];
    
    
    rootController.tabBarItem.title = @"Home";
    rootController.tabBarItem.image = [UIImage imageNamed:@"Home"];
    rootController.navigationItem.title = @"";
    
    _tabcon = [[UITabBarController alloc] init];
    _tabcon.viewControllers = [NSArray arrayWithObjects:rootController,navCon2,navCon3,navCon4, nil];
     self.window.rootViewController = _tabcon;

    
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
