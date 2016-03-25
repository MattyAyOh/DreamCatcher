//
//  DetailsViewController.m
//  RecordingApp
//
//  Created by Mitul on 05/01/16.
//  Copyright (c) 2016 Om Info. All rights reserved.
//

#import "DetailsViewController.h"

@interface DetailsViewController () <MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate>


@end

@implementation DetailsViewController

@synthesize detailsinput,detailsindex,detailssearch, detailshistory, details_Date, details_Text, details_Title, btn_Facebook, btn_Twitter,btn_Chat,btn_Mail, txv_Share_TextView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    details_Date.layer.cornerRadius=4;
    details_Text.layer.cornerRadius=8;
    details_Title.layer.cornerRadius=4;
    txv_Share_TextView.layer.cornerRadius=8;
    
    if (detailsinput)
    {
        details_Date.text = [detailsinput objectForKey:@"input_date"];
        
        details_Title.text = [detailsinput objectForKey:@"input_title"];
        
        details_Text.text = [detailsinput objectForKey:@"input_details"];
        //    NSLog(@"%@", detailsinput);
    }
    
    else if(detailsindex)
    {
        btn_Facebook.hidden = YES;
        btn_Twitter.hidden = YES;
        btn_Mail.hidden = YES;
        btn_Chat.hidden = YES;
        txv_Share_TextView.hidden = YES;
        
        CGRect frame = details_Text.frame;
        frame.origin.y=100;//pass the cordinate which you want
        frame.origin.x= 10;//pass the cordinate which you want
        details_Text.frame= frame;
        
    details_Date.text = [detailsindex objectForKey:@"brouse_title"];
        
    details_Title.hidden = YES;
        
    details_Text.text = [detailsindex objectForKey:@"brouse_details"];
        //    NSLog(@"%@", detailsindex);
        
        /* Insert Brouse data To History Data Table */
        
        NSString *insertData = [NSString stringWithFormat: @"INSERT INTO history_dreams ('history_title','history_details') VALUES (\"%@\", \"%@\")", details_Date.text, details_Text.text];
        
        [DBConnection executeQuery:insertData];
        
    }
    
    else if (detailssearch)
    {
        btn_Facebook.hidden = YES;
        btn_Twitter.hidden = YES;
        btn_Mail.hidden = YES;
        btn_Chat.hidden = YES;
        txv_Share_TextView.hidden = YES;
        
        CGRect frame = details_Text.frame;
        frame.origin.y=100;//pass the cordinate which you want
        frame.origin.x= 10;//pass the cordinate which you want
        details_Text.frame= frame;
        
    details_Date.text = [detailssearch objectForKey:@"brouse_title"];
        
    details_Title.hidden = YES;
        
    details_Text.text = [detailssearch objectForKey:@"brouse_details"];
        //    NSLog(@"%@", detailssearch);
    }
    else
    {
        btn_Facebook.hidden = YES;
        btn_Twitter.hidden = YES;
        btn_Mail.hidden = YES;
        btn_Chat.hidden = YES;
        txv_Share_TextView.hidden = YES;
        
        CGRect frame = details_Text.frame;
        frame.origin.y=100;//pass the cordinate which you want
        frame.origin.x= 10;//pass the cordinate which you want
        details_Text.frame= frame;
        
        details_Date.text = [detailshistory objectForKey:@"history_title"];
        
        details_Title.hidden = YES;
        
        details_Text.text = [detailshistory objectForKey:@"history_details"];
        //    NSLog(@"%@", detailshistory);
        
    }
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.translucent = NO;
    // Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/* ==================                 FACEBOOK SHARING               ===================================*/

- (IBAction)Facebook_Share:(id)sender
{
    SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    SLComposeViewControllerCompletionHandler myBlock = ^(SLComposeViewControllerResult result)
    {
        if (result == SLComposeViewControllerResultCancelled)
        {
            NSLog(@"Cancelled");
        }
        else
        {
            NSLog(@"Done");
        }
        [controller dismissViewControllerAnimated:YES completion:nil];
    };
    
    controller.completionHandler =myBlock;
    
    //Adding the Text to the facebook post value from iOS
    [controller setInitialText:details_Title.text = [detailsinput objectForKey:@"input_title"]];
    [controller setInitialText:details_Text.text = [detailsinput objectForKey:@"input_details"]];
    
    //Adding the URL to the facebook post value from iOS
    [controller addURL:[NSURL URLWithString:@"http://www.google.com"]];
    
    //Adding the IMAGE to the facebook post value from iOS
    [controller addImage:[UIImage imageNamed:@"Cloud1"]];
    
    //Adding the Text to the facebook post value from iOS
    [self presentViewController:controller animated:YES completion:nil];
    
}

/* ==================                 TWITTER SHARING               ===================================*/

- (IBAction)Twitter_Share:(id)sender
{
    SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    
    //Adding the Text to the Twitter post value from iOS
    [tweetSheet setInitialText:details_Title.text = [detailsinput objectForKey:@"input_title"]];
    [tweetSheet setInitialText:details_Text.text = [detailsinput objectForKey:@"input_details"]];
    
    //Adding the URL to the Twitter post value from iOS
    [tweetSheet addURL:[NSURL URLWithString:@"http://www.google.com"]];
    
    //Adding the IMAGE to the Twitter post value from iOS
    [tweetSheet addImage:[UIImage imageNamed:@"Cloud1"]];
    
    
    [self presentViewController:tweetSheet animated:YES completion:NULL];
    
}

/* ==================                 MESSAGE SHARING               ===================================*/

- (IBAction)Chat_Share:(id)sender
{
//    if(![MFMessageComposeViewController canSendText])
//    {
//        UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Your device doesn't support SMS!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [warningAlert show];
//        return;
//    }
//    
//    NSArray *recipents = @[@"12345678", @"72345524"];
//    NSString *message = [NSString stringWithFormat:@"Just sent the %@ file to your email. Please check!", sender];
//    
//    MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init];
//    messageController.messageComposeDelegate = self;
//    [messageController setRecipients:recipents];
//    [messageController setBody:message];
//    
//    // Present message view controller on screen
//    [self presentViewController:messageController animated:YES completion:nil];
    
    MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
    if([MFMessageComposeViewController canSendText])
    {
        controller.body = [detailsinput objectForKey:@"input_title"];
        controller.body = [detailsinput objectForKey:@"input_details"];
        controller.recipients = [NSArray arrayWithObjects:@"12345678", @"87654321", nil];
        controller.messageComposeDelegate = self;
        [self presentViewController:controller animated:YES completion:nil];
    }
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    switch (result)
    {
        case MessageComposeResultCancelled:
            NSLog(@"Message was cancelled");
            break;
            
        case MessageComposeResultFailed:
        {
            UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to send SMS!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [warningAlert show];
            NSLog(@"Message failed");
            break;
        }
        case MessageComposeResultSent:
            NSLog(@"Message was sent");
            
            break;
            
        default:             
            break;     
    }
    [self dismissViewControllerAnimated:YES completion:NULL];
}

/* ==================                 MAIL SHARING               ===================================*/

- (IBAction)Mail_Share:(id)sender
{
    // Email Subject
    NSString *emailTitle = @"Send Email";
    // Email Content
    NSString *messageBody = @"iOS programming is so fun!";
    // To address
    NSArray *toRecipents = [NSArray arrayWithObject:@"Test@gmail.com"];
    
    MFMailComposeViewController *mailCompose = [[MFMailComposeViewController alloc] init];
    mailCompose.mailComposeDelegate = self;
    [mailCompose setSubject:emailTitle];
    [mailCompose setMessageBody:messageBody isHTML:NO];
    [mailCompose setToRecipients:toRecipents];
    
    // Present mail view controller on screen
    [self presentViewController:mailCompose animated:YES completion:NULL];

    
    // Determine the file name and extension
    NSArray *filepart = [file componentsSeparatedByString:@"."];
    NSString *filename = [filepart objectAtIndex:0];
    NSString *extension = [filepart objectAtIndex:1];
    
    // Get the resource path and read the file using NSData
    NSString *filePath = [[NSBundle mainBundle] pathForResource:filename ofType:extension];
    NSData *fileData = [NSData dataWithContentsOfFile:filePath];
    
    // Determine the MIME type
    NSString *mimeType;
    if ([extension isEqualToString:@"jpg"])
    {
        mimeType = @"image/jpeg";
    } else if ([extension isEqualToString:@"png"])
    {
        mimeType = @"image/png";
    } else if ([extension isEqualToString:@"doc"])
    {
        mimeType = @"application/msword";
    } else if ([extension isEqualToString:@"ppt"])
    {
        mimeType = @"application/vnd.ms-powerpoint";
    } else if ([extension isEqualToString:@"html"])
    {
        mimeType = @"text/html";
    } else if ([extension isEqualToString:@"pdf"])
    {
        mimeType = @"application/pdf";
    }
    
    // Add attachment
    [mailCompose addAttachmentData:fileData mimeType:mimeType fileName:filename];
    
    // Present mail view controller on screen
    [self presentViewController:mailCompose animated:YES completion:NULL];
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
