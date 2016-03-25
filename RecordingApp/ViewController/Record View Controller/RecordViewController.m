//
//  RecordViewController.m
//  RecordingApp
//
//  Created by Mitul on 28/12/15.
//  Copyright (c) 2015 Om Info. All rights reserved.
//

#import "RecordViewController.h"
#import "DBConnection.h"
#import <sqlite3.h>
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

#define DOCUMENTS_FOLDER [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]


@interface RecordViewController () <UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *rows;
}
@end

@implementation RecordViewController

@synthesize recorder,recorderSettings,recorderFilePath;
@synthesize audioPlayer,audioFileName;


- (void)viewDidLoad
{
    _tableView.layer.cornerRadius=8;
    
    [super viewDidLoad];
    /* DID SELECT ROW RECORDING PLAY FROM PRIVIOUS VIEW CONTROLLER */
    if (recorderSettings)
    {
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        NSLog(@"playRecording");
        
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
        
        NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@.caf", DOCUMENTS_FOLDER,[recorderSettings objectForKey:@"recording_date_time"]]];
        
        NSError *error;
        audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
        audioPlayer.numberOfLoops = 0;
        [audioPlayer play];
    }
    
    isrecording = YES;
    
    isplaying = YES;
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.translucent = NO;
    
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    _imgRec.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Startbtn"]];
    
    _img_Play.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"PlayingStart"]];
    //[self.view addSubview:_img_Play];
    
    NSString *getData = [NSString stringWithFormat: @"SELECT recording_date_time, recording_duration,recording_path FROM recording_input_dreams WHERE isdreams = 1 "];
    NSLog(@"%@",getData);
    
    rows = [DBConnection fetchResults:getData];
    NSLog(@"%@",rows);
    
    
    [_tableView reloadData];
    
}

#pragma mark - Audio Recording

- (IBAction)startRecording:(id)sender
{
    if (isrecording)
    {
        
        /* RECORDING AUDIO FILE */
        isrecording = NO;
        
        _imgRec.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Startbtn"]];
        
        _img_Play.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"PlayingStart"]];
        
        timer_title = nil;
        
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        
        NSError *err = nil;
        
        [audioSession setCategory :AVAudioSessionCategoryPlayAndRecord error:&err];
        
        [audioSession setMode:AVAudioSessionModeVoiceChat error:&err];
        
        if(err)
        {
            NSLog(@"audioSession: %@ %ld %@", [err domain], (long)[err code], [[err userInfo] description]);
            
            return;
        }
        
        [audioSession setActive:YES error:&err];
        
        err = nil;
        
        if(err)
        {
            NSLog(@"audioSession: %@ %ld %@", [err domain], (long)[err code], [[err userInfo] description]);
            
            return;
        }
        
        recorderSettings = [[NSMutableDictionary alloc] init];
        
        [recorderSettings setValue :[NSNumber numberWithInt:kAudioFormatLinearPCM] forKey:AVFormatIDKey];
        
        [recorderSettings setValue:[NSNumber numberWithFloat:44100.0] forKey:AVSampleRateKey];
        
        [recorderSettings setValue:[NSNumber numberWithInt: 2] forKey:AVNumberOfChannelsKey];
        
        [recorderSettings setValue :[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
        
        [recorderSettings setValue :[NSNumber numberWithBool:NO] forKey:AVLinearPCMIsBigEndianKey];
        
        [recorderSettings setValue :[NSNumber numberWithBool:NO] forKey:AVLinearPCMIsFloatKey];
        
        
        // Create a new audio file
        
        audioFileName = [self getCreationDate];
        
        recorderFilePath = [NSString stringWithFormat:@"%@/%@.caf", DOCUMENTS_FOLDER, audioFileName] ;
        
        NSURL *url = [NSURL fileURLWithPath:recorderFilePath];
        
        err = nil;
        
        recorder = [[ AVAudioRecorder alloc] initWithURL:url settings:recorderSettings error:&err];
        
        if(!recorder)
        {
            NSLog(@"recorder: %@ %ld %@", [err domain], (long)[err code], [[err userInfo] description]);
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Warning" message: [err localizedDescription] delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            [alert show];
            return;
        }
        
        //prepare to record
        [recorder setDelegate:self];
        [recorder prepareToRecord];
        recorder.meteringEnabled = YES;
        
        BOOL audioHWAvailable = audioSession.inputAvailable;
        
        if (! audioHWAvailable)
        {
            UIAlertView *cantRecordAlert =
            [[UIAlertView alloc] initWithTitle: @"Warning"message: @"Audio input hardware not available"
                                      delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [cantRecordAlert show];
            return;
        }
        
        first=0;
        min =0;
        
        timer_title = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(showTimer) userInfo:nil repeats:YES];
        
        // start recording
        [recorder recordForDuration:(NSTimeInterval) 60];//Maximum recording time : 60 seconds default
        NSLog(@"Recroding Started");
    }
    else
    {
        /* SAVE RECORDING AUDIO FILE TO DATABASE */
        isrecording = YES;
        
       
        
        _imgRec.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Stopbtn"]];
        
        [recorder stop];
        
        /* INSERT RECORDING DETAILS IN DATABASE */
        NSString *insertData = [NSString stringWithFormat: @"INSERT INTO recording_input_dreams ('isdreams','recording_date_time','recording_path','recording_duration') VALUES (\"1\", \"%@\", \"%@\",\"%@\")",audioFileName, audioFileName,_lblTimer.text];
        
        [DBConnection executeQuery:insertData];
        
        
        first=0;
        min =0;
        
        [timer_title invalidate];
        
        _lblTimer.text=[NSString stringWithFormat:@"0:00 Sec"];
        
        NSString *getData = [NSString stringWithFormat: @"SELECT recording_date_time, recording_duration,recording_path FROM recording_input_dreams WHERE isdreams = 1 "];
        NSLog(@"%@",getData);
        
        [rows removeAllObjects];
        
        rows = [DBConnection fetchResults:getData];
        NSLog(@"%@",rows);
        
        [_tableView reloadData];
        
        
        NSLog(@"Recording Stopped");
        
        
    }

}

#pragma mark - Audio Playing
- (IBAction)startPlaying:(id)sender
{
    if (isplaying)
    {
        isplaying = NO;
        
        _img_Play.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"PlayingStop"]];
       // [self.view addSubview:_img_Play];
        
        NSLog(@"Stop Recording");
        
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
        
        NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@.caf", DOCUMENTS_FOLDER, audioFileName]];
        NSError *error;
        audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
        audioPlayer.numberOfLoops = 0;
        
    }
    else
    {
        isplaying = YES;
        _img_Play.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"PlayingStop"]];
        //[self.view addSubview:_img_Play];
        
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
        
        NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@.caf", DOCUMENTS_FOLDER, audioFileName]];
        NSError *error;
        audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
        audioPlayer.numberOfLoops = 0;
        
        [audioPlayer stop];
        NSLog(@"stopped");
        
    }
}

-(NSString *)getCreationDate
{
    NSDate *today = [[NSDate alloc] init];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //dateFormatter.dateStyle = NSDateIntervalFormatterMediumStyle;
    [dateFormatter setDateFormat:@"dd-MM-yyyy hh:mm:ss"];
    NSString *dateStr = [dateFormatter stringFromDate:today];
    //Set the required date format
    NSLog(@"creation date = =%@",dateStr);
    return dateStr;
}

#pragma mark - UITableViewDelegate && UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //[indexBar setIndexes:sections];
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [rows count];
    
    //return [[[rows objectAtIndex:sections] objectForKey:@"brouse_title"] count];
}


- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict = [rows objectAtIndex:indexPath.row];
    
    [[dict objectForKey:@"isdreams"] isEqualToString:@"1"];
    
    UITableViewCell *cellData = [tableView dequeueReusableCellWithIdentifier:@"CellRec"];
    
    UILabel *lblCellData = (UILabel *)[cellData viewWithTag:302];
    
    [lblCellData setText:[NSString stringWithFormat:@"%@ %@",[dict valueForKey:@"recording_path"],[dict valueForKey:@"recording_duration"]]];
    
    return cellData;
}

/* DETAILS VIEW ENTRY */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    NSLog(@"playRecording");
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@.caf", DOCUMENTS_FOLDER, [[rows objectAtIndex:indexPath.row] valueForKey:@"recording_date_time"]]];

    NSError *error;
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    audioPlayer.numberOfLoops = 0;
    _imgRec.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Startbtn"]];
    _img_Play.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"PlayingStart"]];
    [audioPlayer play];
    NSLog(@"playing");
}

- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *) aRecorder successfully:(BOOL)flag
{
    NSLog (@"audioRecorderDidFinishRecording:successfully:");
}

-(void)showTimer
{
   
    if(first<=59)
    {
        first=0;
        min ++;
        _lblTimer.text=[NSString stringWithFormat:@" %d Sec",min];
    }
}

@end
