//
//  DetailsViewController.h
//  RecordingApp
//
//  Created by Mitul on 05/01/16.
//  Copyright (c) 2016 Om Info. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "DBConnection.h"
#import <sqlite3.h>
#import <MessageUI/MessageUI.h>
#import <Social/Social.h>
#import <Accounts/Accounts.h>

@interface DetailsViewController : UIViewController
{
    NSString *file;
}

@property (strong, nonatomic) IBOutlet UILabel *details_Date;

@property (strong, nonatomic) IBOutlet UILabel *details_Title;

@property (strong, nonatomic) IBOutlet UITextView *details_Text;



@property (nonatomic, retain)NSDictionary *detailsinput;

@property (nonatomic, retain)NSDictionary *detailsindex;

@property (nonatomic, retain)NSDictionary *detailssearch;

@property (nonatomic, retain)NSDictionary *detailshistory;

@property (strong, nonatomic) IBOutlet UIView *txv_Share_TextView;


/* Share Button */
@property (strong, nonatomic) IBOutlet UIButton *btn_Facebook;

@property (strong, nonatomic) IBOutlet UIButton *btn_Twitter;

@property (strong, nonatomic) IBOutlet UIButton *btn_Chat;

@property (strong, nonatomic) IBOutlet UIButton *btn_Mail;

- (IBAction)Facebook_Share:(id)sender;

- (IBAction)Twitter_Share:(id)sender;

- (IBAction)Chat_Share:(id)sender;

- (IBAction)Mail_Share:(id)sender;




@end
