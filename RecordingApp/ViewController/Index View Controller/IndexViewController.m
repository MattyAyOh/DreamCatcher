//
//  IndexViewController.m
//  RecordingApp
//
//  Created by Mitul on 30/12/15.
//  Copyright (c) 2015 Om Info. All rights reserved.
//

#import "IndexViewController.h"
#import "AIMTableViewIndexBar.h"
#import <sqlite3.h>
#import "DBConnection.h"
@interface IndexViewController () <UITableViewDataSource, UITableViewDelegate, AIMTableViewIndexBarDelegate>

{
    __weak IBOutlet AIMTableViewIndexBar    *indexBar;

    NSArray *sections;
    NSArray *rows;
}

@end

@implementation IndexViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *getData = [NSString stringWithFormat: @"SELECT * FROM brouse_dreams"];
        NSLog(@"%@",getData);
    
    rows = [DBConnection fetchResults:getData];
    NSLog(@"%@",rows);
    
    
    sections = @[@"A", @"B", @"C", @"D", @"E"];

    
    [_tableView reloadData];
    
    
    indexBar.delegate = self;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate && UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //[indexBar setIndexes:sections];
    return [rows count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  
    return 1;
    
    //return [[[rows objectAtIndex:sections] objectForKey:@"brouse_title"] count];
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return sections[section];
    //return [[rows objectAtIndex:sections] valueForKey:sections];
    
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"TableViewCellId";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }


    cell.textLabel.text = [[rows objectAtIndex:indexPath.section] valueForKey:@"brouse_title"];
    
    
    
   // [cell.textLabel setText:rows[indexPath.section][indexPath.row]];
    
    return cell;
}

           /* DETAILS VIEW ENTRY */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    
    UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DetailsViewController *recordview = [storyboard instantiateViewControllerWithIdentifier:@"DetailsViewController"];
    
    recordview.detailsindex = [rows objectAtIndex:indexPath.section];
    
    [self.navigationController pushViewController:recordview animated:YES];
}

#pragma mark - AIMTableViewIndexBarDelegate

- (void)tableViewIndexBar:(AIMTableViewIndexBar *)indexBar didSelectSectionAtIndex:(NSInteger)index
{
    if ([_tableView numberOfSections] > index && index > -1)
    {
        // for safety, should always be YES
        [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index]atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}




@end
