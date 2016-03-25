//
//  MainViewController.m
//  RecordingApp
//
//  Created by Om Infowave on 09/01/16.
//  Copyright © 2016 Om Info. All rights reserved.
//

#import "HomeViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface HomeViewController () <UITableViewDataSource, UITableViewDelegate>
{
   AVAudioPlayer *_audioPlayer;
   NSArray *rows;
}
@end

@implementation HomeViewController
@synthesize tableview,toneButton;

- (void)viewDidLoad
{
   [super viewDidLoad];
   
   toneButton.layer.cornerRadius= 4;
   
   tableview.layer.cornerRadius=8;
   
   ismute = NO;
   tableview.hidden = YES;
   
   /* NAVIGATIOM TITLE NAD NAVIGATION IMAGE */
   self.title = @"Dreamcatcher";
   UIImage *img = [UIImage imageNamed:@"Cloud"];
   UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
   [imgView setImage:img];
   //setContent mode aspect fit
   [imgView setContentMode:UIViewContentModeCenter];
   
   self.navigationItem.titleView = imgView;
   
   self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
   
   self.navigationController.navigationBar.translucent = NO;
   
   
   /*  CONSTRUCT URL TO SEND FILE  */
   
   
   NSString *path = [NSString stringWithFormat:@"%@/Tone/Tone 2.mp3", [[NSBundle mainBundle] resourcePath]];
   NSURL *soundUrl = [NSURL fileURLWithPath:path];
   
   /*CREATE AUDIO PLAYER OBJECT AND INITIALIZE WITH URL TO SOUND   */
   _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil];
   
   rows = @[@"Buzzer", @"DreamSpace"];
   
   [tableview reloadData];
   
   UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
   [self.muteButtonImageView addGestureRecognizer:longPress];
   [self.muteButtonImageView setUserInteractionEnabled:YES];
}

- (IBAction)toneButton:(id)sender
{
   [self.tableview setHidden:!self.tableview.hidden];
}

- (void)longPress:(UILongPressGestureRecognizer*)gesture
{
   if ( gesture.state == UIGestureRecognizerStateEnded )
   {
      if (ismute == NO)
      {
         [self.muteButtonImageView setImage:[UIImage imageNamed:@"geometric"]];
         [_audioPlayer play];
         NSLog(@"Long Press PLAY BTN ON");
      }else
      {
         [self.muteButtonImageView setImage:[UIImage imageNamed:@"geometric-red"]];
         [_audioPlayer stop];
         NSLog(@"Long Press STOP BTN OFF");
      }
      
   }
   else if(ismute == NO)
   {
      
      [self.muteButtonImageView setImage:[UIImage imageNamed:@"geometric-red"]];
      [_audioPlayer pause];
      NSLog(@"Long Press 2 PAUSE");
      
   }else if(ismute == YES)
   {
      
      tableview.hidden = YES;
      [self.muteButtonImageView setImage:[UIImage imageNamed:@"geometric-red"]];
      [_audioPlayer stop];
      NSLog(@" OFF");
   }
}

#pragma mark - UITableViewDelegate && UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
   return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   return [rows count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   static NSString *cellId = @"TableViewCellId";
   
   UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
   
   if (cell == nil)
   {
      cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
   }
   cell.textLabel.text = [rows objectAtIndex:indexPath.row];
   
   return cell;
}

/* DETAILS VIEW ENTRY */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
   [[UIApplication sharedApplication] endIgnoringInteractionEvents];
   
   NSString *path = [NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath],[rows objectAtIndex:indexPath.row]];
   NSURL *soundUrl = [NSURL fileURLWithPath:path];
   
   [_audioPlayer stop];
   
   /*CREATE AUDIO PLAYER OBJECT AND INITIALIZE WITH URL TO SOUND   */
   _audioPlayer = [_audioPlayer initWithContentsOfURL:soundUrl error:nil];
   
   _audioPlayer.numberOfLoops=1;
   [_audioPlayer play];
}


@end
