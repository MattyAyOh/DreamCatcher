//
//  Contact.m
//  RecordingApp
//
//  Created by Mitul on 24/12/15.
//  Copyright (c) 2015 Om Info. All rights reserved.
//

#import "Contact.h"
#import "DDMenuController.h"
#import <MessageUI/MFMailComposeViewController.h>

@interface Contact ()

@end

@implementation Contact
@synthesize fname_Contact, lname_Contact, btn_Send, text_Contact, contact_view;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    contact_view.layer.cornerRadius=8;
    btn_Send.layer.cornerRadius=4;
    text_Contact.layer.cornerRadius=8;
    
    /*
    UIImage *img = [UIImage imageNamed:@"Cloud"];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [imgView setImage:img];
    //setContent mode aspect fit
    [imgView setContentMode:UIViewContentModeCenter];
    self.navigationItem.titleView = imgView;
   */
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)sendBtn_Contact:(id)sender
{
    
    if ([self isValid])
    {
       if ([MFMailComposeViewController canSendMail]) {
          MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
          controller.mailComposeDelegate = self;
          [controller setToRecipients:@[@"josh@dreamcatcherproject.net"]];
          [controller setSubject:@"Dream Catcher Project Feedback"];
          [controller setMessageBody:text_Contact.text isHTML:NO];
          if( controller )
          {
             [self presentViewController:controller animated:YES completion:nil];
          }
       } else {
          // Handle the error
       }
        
    }
    
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
   if (result == MFMailComposeResultSent) {
      NSLog(@"It's away!");
   }
   [self dismissViewControllerAnimated:YES completion:nil];
}

/*STARTS TEXTFIELD VALIDATION METHOD.*/
#pragma validation method.

-(BOOL) isValid
{
    BOOL isValidBool = YES;
    
    UIAlertView *validationAlert = [[UIAlertView alloc]initWithTitle:@"Error !!" message:@"" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    
    if (((fname_Contact.text == nil) || ([fname_Contact.text length] == 0)) &&
        ((lname_Contact.text == nil) || ([lname_Contact.text length] == 0)) &&
        ((text_Contact.text == nil) || ([text_Contact.text length] == 0)))
    {
        validationAlert.message = @"All Fields are mandatory.";
        [validationAlert show];
        isValidBool = NO;
        
    }else if ((fname_Contact == nil) || ([fname_Contact.text length] < 2 ))
    {
        validationAlert.message = @"Please Enter Your First Name.";
        [validationAlert show];
        isValidBool = NO;
        
    }else if ((lname_Contact.text == nil) || ([lname_Contact.text length] < 3))
    {
        validationAlert.message = @"Please Enter Your Last Name.";
        [validationAlert show];
        isValidBool = NO;
        
    }else if ((text_Contact.text == nil) || ([text_Contact.text length] < 6))
    {
        validationAlert.message = @"Please Enter some text into the message body";
        [validationAlert show];
        isValidBool = NO;
        
    }else if (!(text_Contact.text == nil) || ([text_Contact.text length] < 6))
    {
        isValidBool = YES;
    }
    
    return isValidBool;
    
}
/*END TEXTFIELD VALIDATION METHOD.*/


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    UITouch *touch = [[event allTouches] anyObject];
    
    if (([fname_Contact isFirstResponder] && [touch view] != fname_Contact) &&
        ([lname_Contact isFirstResponder] && [touch view] != lname_Contact) &&
        ([text_Contact isFirstResponder] && [touch view] != text_Contact))
    {
        [fname_Contact resignFirstResponder];
        [lname_Contact resignFirstResponder];
        [text_Contact resignFirstResponder];
    }
    [super touchesBegan:touches withEvent:event];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [fname_Contact resignFirstResponder];
    [lname_Contact resignFirstResponder];
    [text_Contact resignFirstResponder];
    
    return YES;
}





@end
