//
//  Contact.h
//  RecordingApp
//
//  Created by Mitul on 24/12/15.
//  Copyright (c) 2015 Om Info. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface Contact : UIViewController <MFMailComposeViewControllerDelegate>


@property (strong, nonatomic) IBOutlet UITextField *fname_Contact;

@property (strong, nonatomic) IBOutlet UITextField *lname_Contact;

@property (strong, nonatomic) IBOutlet UITextView *text_Contact;

@property (strong, nonatomic) IBOutlet UIView *contact_view;

@property (strong, nonatomic) IBOutlet UIButton *btn_Send;

- (IBAction)sendBtn_Contact:(id)sender;

@end
