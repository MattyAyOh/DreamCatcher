//
//  PasswordSetting.h
//  RecordingApp
//
//  Created by Mitul on 24/12/15.
//  Copyright (c) 2015 Om Info. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface PasswordSetting : UIViewController
{
    
    IBOutlet UISwitch *passOnOff;
    
    IBOutlet UITextField *enterPass;
    
    IBOutlet UITextField *confirmPass;
    
    IBOutlet UIButton *setPass;
    
    IBOutlet UIView *passView;
    
}

@property (nonatomic, retain) UISwitch *passOnOff;
@property (nonatomic, retain) UITextField *enterPass;
@property (nonatomic, retain) UITextField *confirmPass;
@property (nonatomic, retain) UIView *passView;
@property (strong, nonatomic) IBOutlet UIView *setview;
@property (strong, nonatomic) IBOutlet UIButton *btn_Setpass;


- (IBAction)passOnOff:(id)sender;

- (IBAction)setPass:(id)sender;

@end
