//
//  GoToWebsite.m
//  RecordingApp
//
//  Created by Mitul on 24/12/15.
//  Copyright (c) 2015 Om Info. All rights reserved.
//

#import "GoToWebsite.h"
#import "DDMenuController.h"
@interface GoToWebsite ()

@end

@implementation GoToWebsite

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.dreamcatcherproject.net"]];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
