//
//  InputDreamViewController.m
//  RecordingApp
//
//  Created by Mitul on 31/12/15.
//  Copyright (c) 2015 Om Info. All rights reserved.
//

#import "InputDreamViewController.h"
#import "DBConnection.h"
#import <sqlite3.h>
@interface InputDreamViewController ()

@end

@implementation InputDreamViewController
@synthesize txt_Dob, txt_DreamTitle, datePick,txt_View, txv_Main;

- (void)viewDidLoad
{
    datePick.hidden = YES;
    txv_Main.layer.cornerRadius=8;
    txt_View.layer.cornerRadius=8;
    
    [super viewDidLoad];
    /*
    UIImage *img = [UIImage imageNamed:@"Cloud"];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [imgView setImage:img];
    //setContent mode aspect fit
    [imgView setContentMode:UIViewContentModeCenter];
    self.navigationItem.titleView = imgView;
    */
    /* NAVIGATION BAR AND BUTTON COLOR */
    
    UIButton *btn_save = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 44)];
    
    //[backImageBtn setBackgroundImage:@"" forState:UIControlStateNormal];
    
    [btn_save setTitle:@"Save" forState:UIControlStateNormal];
    
    [btn_save addTarget:self action:@selector(saveDream) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *savebtn = [[UIBarButtonItem alloc]initWithCustomView:btn_save];
    
    self.navigationItem.rightBarButtonItem = savebtn;
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
 
    self.navigationController.navigationBar.translucent = NO;
    
    /* END NAVIGATION BAR AND BUTTON COLOR */
   
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)saveDream
{

    if ([self isValid])
    {
        // Insert your data
        NSString *insertData = [NSString stringWithFormat: @"INSERT INTO recording_input_dreams ('isdreams','input_date','input_title','input_details') VALUES (\"0\", \"%@\", \"%@\", \"%@\")", txt_Dob.text, txt_DreamTitle.text, txt_View.text];
        
        [DBConnection executeQuery:insertData];
        
        [self isSaveSuccess];
    }
    
}

-(void) isSaveSuccess
{
    txt_Dob.text = nil;
    txt_DreamTitle.text = nil;
    txt_View.text = nil;
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Dream Saved" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
    [alert show];
    
}



 /*     date picker.. set date selection in insert dreams view controller*/
- (IBAction)dateSelection:(id)sender
{
    NSDateFormatter *dateselection = [[NSDateFormatter alloc] init];
    
    
    dateselection.dateStyle = NSDateIntervalFormatterMediumStyle;
    
    txt_Dob.text = [NSString stringWithFormat:@"%@", [dateselection stringFromDate:[NSDate date]]];
    
    datePick = nil;
    
    datePick = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 250, 0, 0)];
    
    datePick.datePickerMode = UIDatePickerModeDate;
    
    datePick.hidden = NO;
    
    datePick.date = [NSDate date];
    
    txt_Dob.inputView = datePick;
    
    [datePick addTarget:self action:@selector(DateChange:) forControlEvents:UIControlEventValueChanged];
    
    [txt_Dob setInputView:datePick];
}

-(void)DateChange:(id)sender
{
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"dd/MM/yyyy"];
    dateFormat.dateStyle=NSDateIntervalFormatterMediumStyle;
    
    NSString *str=[NSString stringWithFormat:@"%@",[dateFormat  stringFromDate:datePick.date]];
    
    //assign text to label
    txt_Dob.text=str;
}
/*     date picker.. set date selection in insert dreams view controller*/

/*STARTS TEXTFIELD VALIDATION METHOD.*/
#pragma validation method.

-(BOOL) isValid
{
    BOOL isValidBool = YES;
    
    UIAlertView *validationAlert = [[UIAlertView alloc]initWithTitle:@"Ooops !!" message:@"" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    
    if (((txt_Dob.text == nil) || ([txt_Dob.text length] == 0)) &&
        ((txt_DreamTitle.text == nil) || ([txt_DreamTitle.text length] == 0)) &&
        ((txt_View.text == nil) || ([txt_View.text length] == 0)))
    {
        validationAlert.message = @"All Fields are mandatory.";
        [validationAlert show];
        isValidBool = NO;
    
    }else if ((txt_Dob == nil) || ([txt_Dob.text length] < 6))
    {
        validationAlert.message = @"Please Enter Your Dreame Date.";
        [validationAlert show];
        isValidBool = NO;
        
    }else if ((txt_DreamTitle.text == nil) || ([txt_DreamTitle.text length] < 3))
    {
        validationAlert.message = @"Please Enter Your Dream Title.";
        [validationAlert show];
        isValidBool = NO;
        
    }else if ((txt_View.text == nil) || ([txt_View.text length] < 6))
    {
        validationAlert.message = @"Please Enter Your Dream Details.";
        [validationAlert show];
        isValidBool = NO;
        
    }else if (!(txt_View.text == nil) || ([txt_View.text length] < 6))
    {
        isValidBool = YES;
    }
    
    return isValidBool;
    
}
/*END TEXTFIELD VALIDATION METHOD.*/


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    
    if (([txt_Dob isFirstResponder] && [touch view] != txt_Dob) &&
        ([txt_DreamTitle isFirstResponder] && [touch view] != txt_DreamTitle) &&
        ([txt_View isFirstResponder] && [touch view] != txt_View))
    {
        [txt_DreamTitle resignFirstResponder];
        [txt_View resignFirstResponder];
        [txt_Dob resignFirstResponder];
    }
    [super touchesBegan:touches withEvent:event];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [txt_Dob resignFirstResponder];
    [txt_DreamTitle resignFirstResponder];
    [txt_View resignFirstResponder];
    return YES;
}


@end
