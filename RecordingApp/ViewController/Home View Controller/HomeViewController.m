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
   NSArray *rows;
}
@property AVAudioPlayer *audioPlayer;
@property BOOL muteInPressedState;
@end

@implementation HomeViewController
@synthesize tableview;

- (void)viewDidLoad
{
   [super viewDidLoad];
   
   self.toneButton.layer.cornerRadius= 4;
   
   tableview.layer.cornerRadius=8;
   
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
   self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil];
   
   rows = @[@"Buzzer", @"DreamSpace"];
   
   [tableview reloadData];
   
   UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
   [longPress setMinimumPressDuration:0.1];
   [self.muteButtonImageView addGestureRecognizer:longPress];
   [self.muteButtonImageView setUserInteractionEnabled:YES];
}



- (void)longPress:(UILongPressGestureRecognizer*)gesture
{
   if( !self.muteInPressedState )
   {
      self.muteInPressedState = YES;
      [self.audioPlayer pause];
      [self.muteButtonImageView setImage:[UIImage imageNamed:@"geometric-red"]];
   }
   
   if ( gesture.state == UIGestureRecognizerStateEnded )
   {
      if( self.muteInPressedState )
      {
         self.muteInPressedState = NO;
         [self.muteButtonImageView setImage:[UIImage imageNamed:@"geometric"]];
         [self.audioPlayer play];
      }
   }
}


- (IBAction)toneButtonPressed:(id)sender
{
   [self.tableview setHidden:!self.tableview.hidden];
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
