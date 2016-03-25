//
//  PasswordSetting.m
//  RecordingApp
//
//  Created by Mitul on 24/12/15.
//  Copyright (c) 2015 Om Info. All rights reserved.
//

#import "PasswordSetting.h"
#import "DDMenuController.h"
@interface PasswordSetting ()

@end

@implementation PasswordSetting

@synthesize passOnOff;
@synthesize enterPass;
@synthesize confirmPass;
@synthesize passView, setview,btn_Setpass;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    setview.layer.cornerRadius=8;
    passView.layer.cornerRadius=8;
    btn_Setpass.layer.cornerRadius=4;
    
    /*
    UIImage *img = [UIImage imageNamed:@"Cloud"];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [imgView setImage:img];
    //setContent mode aspect fit
    [imgView setContentMode:UIViewContentModeCenter];
    self.navigationItem.titleView = imgView;
    */
    
    // Get the stored data before the view loads
    
     NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
     NSString *password = [defaults objectForKey:@"Password"];
    
     NSString *re_password = [defaults objectForKey:@"conf_Password"];
    
    
    // Update the UI elements with the saved data
    enterPass.text = password;
    
    confirmPass.text = re_password;
  
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)passOnOff:(id)sender
{
    if (passOnOff.on)
    {
        enterPass.enabled = YES;
        confirmPass.enabled = YES;
        passView.hidden = NO;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration: 0.9];
        [UIView commitAnimations];
    }
    else
    {
        enterPass.enabled = NO;
        confirmPass.enabled = NO;
        passView.hidden = YES;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration: 0.9];
        [UIView commitAnimations];
    }
}

- (IBAction)setPass:(id)sender
{
    if ([self isValid])
    {
        // Store the data
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        [defaults setObject:enterPass.text forKey:@"Password"];
        
        [defaults setObject:confirmPass.text forKey:@"Conf_Password"];
        
        [defaults synchronize];
        [self isSaveSuccess];
        
    }
}

-(void) isSaveSuccess
{
    enterPass.text = nil;
    confirmPass.text = nil;
   
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Password Saved" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
    [alert show];
    
}

-(BOOL) isValid
{
    BOOL isValidBool = YES;
    
    UIAlertView *validationAlert = [[UIAlertView alloc]initWithTitle:@"Oopss !!" message:@"" delegate:nil cancelButtonTitle:@"Ok." otherButtonTitles:nil];
    
    if (((enterPass.text == nil) || ([enterPass.text length] == 0)) &&
        ((confirmPass.text == nil) || ([confirmPass.text length] == 0)))
    {
        validationAlert.message = @"All Fields are mandatory.";
        [validationAlert show];
        isValidBool = NO;
        
    }else if ((enterPass == nil) || ([enterPass.text length] < 6))
    {
        validationAlert.message = @"Please Enter Your Password.";
        [validationAlert show];
        isValidBool = NO;
        
    }else if ((confirmPass.text == nil) || ([confirmPass.text length] < 6))
    {
        validationAlert.message = @"Please Enter Your Confirm Password.";
        [validationAlert show];
        isValidBool = NO;
        
    }else if (![enterPass.text isEqualToString:confirmPass.text])
    {
        validationAlert.message = @"Password Did Not Match...Please Re-Enter Password.";
        [validationAlert show];
        isValidBool = NO;
        //return FALSE;
    }
    
    return isValidBool;
    
}


//keyboard retun
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    UITouch *touch = [[event allTouches] anyObject];
    if ([enterPass isFirstResponder] && [touch view] != enterPass)
        ([confirmPass isFirstResponder] && [touch view] != confirmPass);
    
    {
        [enterPass resignFirstResponder];
        [confirmPass resignFirstResponder];
        
    }
    [super touchesBegan:touches withEvent:event];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
