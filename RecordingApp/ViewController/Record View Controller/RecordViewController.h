//
//  RecordViewController.h
//  RecordingApp
//
//  Created by Mitul on 28/12/15.
//  Copyright (c) 2015 Om Info. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "DBConnection.h"
#import "AppDelegate.h"
#import "RecordViewController.h"

@interface RecordViewController : UIViewController <AVAudioRecorderDelegate, AVAudioPlayerDelegate>
{
    BOOL isrecording;
    BOOL isplaying;
    NSTimer *timer_title;
    int first;
    int min;
    
}

@property(nonatomic,strong) AVAudioRecorder *recorder;
@property(nonatomic,strong) NSMutableDictionary *recorderSettings;
@property(nonatomic,strong) NSString *recorderFilePath;
@property(nonatomic,strong) AVAudioPlayer *audioPlayer;
@property(nonatomic,strong) NSString *audioFileName;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) IBOutlet UIImageView *imgRec;

@property (strong, nonatomic) IBOutlet UIImageView *img_Play;

@property (strong, nonatomic) IBOutlet UILabel *lblCell;

- (IBAction)startRecording:(id)sender;

- (IBAction)startPlaying:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *lblTimer;

@property (assign)NSInteger Second;


@end
