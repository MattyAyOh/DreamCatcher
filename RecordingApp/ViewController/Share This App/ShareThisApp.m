//
//  ShareThisApp.m
//  RecordingApp
//
//  Created by Mitul on 24/12/15.
//  Copyright (c) 2015 Om Info. All rights reserved.
//

#import "ShareThisApp.h"
#import "DDMenuController.h"

@interface ShareThisApp () <MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate>


@end

@implementation ShareThisApp

@synthesize btn_Facebook,btn_Twitter,btn_Mail,btn_Message, txv_Sharing;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    txv_Sharing.layer.cornerRadius=8;
   
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)Facebook_Sharing:(id)sender
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
    [controller setInitialText:@"My test post"];
    //Adding the URL to the facebook post value from iOS
    [controller addURL:[NSURL URLWithString:@"http://www.google.com"]];
    //Adding the Text to the facebook post value from iOS
    [self presentViewController:controller animated:YES completion:nil];
    
}

- (IBAction)Twitter_Sharing:(id)sender
{
    SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    [tweetSheet setInitialText:@"My test tweet"];
    [self presentViewController:tweetSheet animated:YES completion:NULL];
    
}

- (IBAction)Mail_Sharing:(id)sender
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

#pragma mark - mail compose delegate
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

- (IBAction)Message_Sharing:(id)sender
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
        controller.body = @"Hello from Mugunth";
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


@end
