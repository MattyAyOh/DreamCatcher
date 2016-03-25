//
//  HistoryViewController.m
//  RecordingApp
//
//  Created by Mitul on 30/12/15.
//  Copyright (c) 2015 Om Info. All rights reserved.
//

#import "HistoryViewController.h"


@interface HistoryViewController () <UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *arr_sections;
    NSMutableArray *arr_histary;
    NSMutableArray *arr_detail;
}

@end

@implementation HistoryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
   
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    arr_sections=[[NSMutableArray alloc] init];
    arr_histary=[[NSMutableArray alloc] init];
    arr_detail=[[NSMutableArray alloc] init];
    
    NSString *getData = [NSString stringWithFormat: @"SELECT * FROM history_dreams "];
    NSLog(@"%@",getData);
    
    arr_histary = [DBConnection fetchResults:getData];
    NSLog(@"%@",arr_histary);
  //  SELECT DISTINCT history_date FROM history_dreams ORDER BY history_date ASC
    
    
    NSString *date_data = [NSString stringWithFormat: @"SELECT DISTINCT history_date FROM history_dreams ORDER BY history_date ASC"];
    NSLog(@"%@",date_data);
    
    arr_sections = [DBConnection fetchResults:date_data];
    NSLog(@"%@",arr_sections);
    

    [self loadTable];
    
    
}

- (void)loadTable
{
    for (int i = 0; i < [arr_sections count]; i++)
    {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
        NSMutableArray *tempArray = [[NSMutableArray alloc] init];
        for (int k = 0; k < [arr_histary count]; k++)
        {
            NSString *currentName = [[arr_histary objectAtIndex:k]valueForKey:@"history_date"];
            if ([currentName isEqualToString:[[arr_sections objectAtIndex:i] valueForKey:@"history_date"]])
            {
                [tempArray addObject:[arr_histary objectAtIndex:k]];
            }
        }
        if ([tempArray count] > 0)
        {
            [dict setObject:tempArray forKey:@"rowValues"];
            [dict setObject:[arr_sections objectAtIndex:i] forKey:@"headerTitle"];
            [arr_detail addObject:dict];
        }
    }
    [_tableView reloadData];
    
   
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
    return [arr_detail count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
     return [[[arr_detail objectAtIndex:section] objectForKey:@"rowValues"] count];
    
    //return [[[rows objectAtIndex:sections] objectForKey:@"brouse_title"] count];
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [[[arr_detail objectAtIndex:section] objectForKey:@"headerTitle"] valueForKey:@"history_date"];
    //return [[rows objectAtIndex:sections] valueForKey:sections];
    
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"TableViewCellId";
    
    NSArray *data;
    data = [[arr_detail objectAtIndex:indexPath.section] objectForKey:@"rowValues"];
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    
    cell.textLabel.text =[[data objectAtIndex:indexPath.row]objectForKey:@"history_title"];
   
    return cell;
}

/* DETAILS VIEW ENTRY */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    
    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    
    UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DetailsViewController *recordview = [storyboard instantiateViewControllerWithIdentifier:@"DetailsViewController"];
    
    recordview.detailshistory = [arr_histary objectAtIndex:indexPath.section];
    
    [self.navigationController pushViewController:recordview animated:YES];
}

-(NSString *)getCreationDate
{
    NSDate *today = [[NSDate alloc] init];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //dateFormatter.dateStyle = NSDateIntervalFormatterMediumStyle;
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSString *dateStr = [dateFormatter stringFromDate:today];
    //Set the required date format
    NSLog(@"creation date = =%@",dateStr);
    return dateStr;
}


@end
