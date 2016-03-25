//
//  ShareThisApp.h
//  RecordingApp
//
//  Created by Mitul on 24/12/15.
//  Copyright (c) 2015 Om Info. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <MessageUI/MessageUI.h>
#import <Social/Social.h>
#import <Accounts/Accounts.h>

@interface ShareThisApp : UIViewController
{
    NSString *file;
}

@property (strong, nonatomic) IBOutlet UIButton *btn_Facebook;

@property (strong, nonatomic) IBOutlet UIButton *btn_Twitter;

@property (strong, nonatomic) IBOutlet UIButton *btn_Mail;

@property (strong, nonatomic) IBOutlet UIButton *btn_Message;

@property (strong, nonatomic) IBOutlet UIView *txv_Sharing;


- (IBAction)Facebook_Sharing:(id)sender;

- (IBAction)Twitter_Sharing:(id)sender;

- (IBAction)Mail_Sharing:(id)sender;

- (IBAction)Message_Sharing:(id)sender;



@end
