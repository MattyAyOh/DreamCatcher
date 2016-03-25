//
//  Help.m
//  RecordingApp
//
//  Created by Mitul on 24/12/15.
//  Copyright (c) 2015 Om Info. All rights reserved.
//

#import "Help.h"
#import "DDMenuController.h"
@interface Help ()

@end

@implementation Help
@synthesize txv_How, txv_insp;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    txv_insp.layer.cornerRadius=8;
    txv_How.layer.cornerRadius=8;
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
