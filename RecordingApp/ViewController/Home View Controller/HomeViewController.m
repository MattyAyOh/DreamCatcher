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

@property (strong, nonatomic) IBOutlet UISwitch *startAudioSwitch;
@property (strong, nonatomic) IBOutlet UILabel *startAudioLabel;
@property AVAudioPlayer *audioPlayer;
@property BOOL muteInPressedState;
@property NSArray *availableAudioArray;

@end

@implementation HomeViewController

- (void)viewDidLoad
{
   [super viewDidLoad];
   
   self.chooseAudioButton.layer.cornerRadius= 4;
   self.tableview.layer.cornerRadius=8;
   
   
   /* NAVIGATIOM TITLE NAD NAVIGATION IMAGE */
   self.title = @"Dreamcatcher";
   UIImage *img = [UIImage imageNamed:@"Cloud"];
   UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
   [imgView setImage:img];
   [imgView setContentMode:UIViewContentModeCenter];
   
   self.navigationItem.titleView = imgView;
   self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
   self.navigationController.navigationBar.translucent = NO;
   
   
   NSString *defaultAudioPath = [NSString stringWithFormat:@"%@/Buzzer.mp3", [[NSBundle mainBundle] resourcePath]];
   NSURL *defaultSoundURL = [NSURL fileURLWithPath:defaultAudioPath];
   self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:defaultSoundURL error:nil];
   self.audioPlayer.numberOfLoops = -1;
 
   self.availableAudioArray = @[@"Buzzer", @"DreamSpace"];
   
   [self.tableview reloadData];
   
   UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
   [longPress setMinimumPressDuration:0.1];
   [self.muteButtonImageView addGestureRecognizer:longPress];
   [self.muteButtonImageView setUserInteractionEnabled:YES];
   
   [self hideControls];
}

- (IBAction)startAudioValueChanged:(id)sender
{
   if( [self.startAudioSwitch isOn] )
   {
      [self.startAudioLabel setHidden:YES];
      [self.muteButtonImageView setHidden:NO];
      [self.chooseAudioButton setHidden:NO];
      [self.audioPlayer play];
   }
   else
   {
      [self hideControls];
   }
}

- (void)hideControls
{
   [self.startAudioLabel setHidden:NO];
   [self.muteButtonImageView setHidden:YES];
   [self.chooseAudioButton setHidden:YES];
   [self.tableview setHidden:YES];
   [self.audioPlayer pause];
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

- (IBAction)chooseAudioButtonPressed:(id)sender
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
   return [self.availableAudioArray count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   static NSString *cellId = @"TableViewCellId";
   
   UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
   
   if (cell == nil)
   {
      cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
   }
   cell.textLabel.text = [self.availableAudioArray objectAtIndex:indexPath.row];
   
   return cell;
}

/* DETAILS VIEW ENTRY */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
   NSString *path = [NSString stringWithFormat:@"%@/%@.mp3", [[NSBundle mainBundle] resourcePath],[self.availableAudioArray objectAtIndex:indexPath.row]];
   NSURL *soundUrl = [NSURL fileURLWithPath:path];
   
   [self.audioPlayer stop];
   
   self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil];
   
   self.audioPlayer.numberOfLoops = -1;
   [self.audioPlayer play];
}


@end
