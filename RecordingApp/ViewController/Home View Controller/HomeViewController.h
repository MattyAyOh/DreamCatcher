//
//  MainViewController.h
//  RecordingApp
//
//  Created by Om Infowave on 09/01/16.
//  Copyright © 2016 Om Info. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <MediaPlayer/MediaPlayer.h>

@interface HomeViewController : UIViewController <MPMediaPickerControllerDelegate>

@property IBOutlet UIButton *chooseAudioButton;
@property IBOutlet UIImageView *muteButtonImageView;
@property IBOutlet UITableView *tableview;

@end
