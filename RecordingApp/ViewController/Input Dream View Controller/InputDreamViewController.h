//
//  InputDreamViewController.h
//  RecordingApp
//
//  Created by Mitul on 31/12/15.
//  Copyright (c) 2015 Om Info. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "DBConnection.h"
#import "TPKeyboardAvoidingScrollView.h"
@interface InputDreamViewController : UIViewController <UITextFieldDelegate, UIScrollViewDelegate,
UIActionSheetDelegate, UINavigationBarDelegate>


@property (strong, nonatomic) IBOutlet UIScrollView *scrollview;

@property (strong, nonatomic) IBOutlet UIDatePicker *datePick;

@property (strong, nonatomic) IBOutlet UITextField *txt_Dob;
@property (strong, nonatomic) IBOutlet UITextField *txt_DreamTitle;

@property (strong, nonatomic) IBOutlet UITextView *txt_View;

@property (strong, nonatomic) IBOutlet UIView *txv_Main;

- (IBAction)dateSelection:(id)sender;

@end
