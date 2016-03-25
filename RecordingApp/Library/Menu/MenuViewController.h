//
//  MenuViewController.h
//  RecordingApp
//
//  Created by Mitul Patel on 30/12/15.
//  Copyright (c) 2015 Om Info. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#define ApplicationDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

@interface MenuViewController : UIViewController
{
    
    NSMutableArray *list;
    NSMutableArray *list_image;
    
    UIStoryboard *storyboard;
    
}
@property (strong,nonatomic) IBOutlet UITableView *tableview;

@end
