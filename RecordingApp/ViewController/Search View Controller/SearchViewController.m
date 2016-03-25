//
//  HomeViewController.m
//  RecordingApp
//
//  Created by Mitul on 30/12/15.
//  Copyright (c) 2015 Om Info. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()
{
    //NSArray *sections;
    NSArray *rows;
    NSArray *searchResults;
}

@end

@implementation SearchViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    self.title = @"Dreamcatcher";
//    
//    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
//    
//    self.navigationController.navigationBar.translucent = NO;
//    
    NSString *getData = [NSString stringWithFormat: @"SELECT * FROM brouse_dreams"];
    
    NSLog(@"%@",getData);
    
    rows = [DBConnection fetchResults:getData];
    
    NSLog(@"%@",rows);
    
    searchResults = rows;
    
    [_tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Search Functionality

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [self.searchBar setShowsCancelButton:YES animated:YES];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [self.searchBar setShowsCancelButton:NO animated:YES];
    searchBar.text=@"";
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
    if (searchText.length > 0)
    {
        searchText = [searchText stringByReplacingOccurrencesOfString:@" " withString:@""];
        //NSLog(@"its pincode");
        NSPredicate *predicate = [NSPredicate predicateWithFormat: @"SELF CONTAINS[cd] %@", searchText];
        searchResults= [rows filteredArrayUsingPredicate:predicate];
        [_tableView reloadData];
    }
   /*
    else if (!(searchText.length > 0))
    {
        searchText = [searchText stringByReplacingOccurrencesOfString:@" " withString:@""];
        //NSLog(@"its pincode");
        NSPredicate *predicate = [NSPredicate predicateWithFormat: @"SELF CONTAINS[cd] %@", searchText];
        searchResults= [rows filteredArrayUsingPredicate:predicate];
        
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Ooops !" message:@" Search Data Not Found." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        //[_tableView reloadData];
    }*/
    
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Ooops !" message:@" Search Data Not Found." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    
        searchResults=rows;
        [_tableView reloadData];
        
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.searchBar resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.searchBar resignFirstResponder];
    searchResults=rows;
    [self.tableView reloadData];
}



-(void) showDetailsForIndexPath:(NSIndexPath*)indexPath
{
    [self.searchBar resignFirstResponder];
    
    DetailsViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailsViewController"];
    
    [self.navigationController pushViewController:vc animated:true];
}
 

#pragma mark - UITableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [searchResults count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID=@"CellID";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==Nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    cell.textLabel.text=[[searchResults objectAtIndex:indexPath.row] objectForKey:@"brouse_title"];
    return cell;
}

/* DETAILS VIEW ENTRY */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    
    UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DetailsViewController *recordview = [storyboard instantiateViewControllerWithIdentifier:@"DetailsViewController"];
    
    recordview.detailssearch = [rows objectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:recordview animated:YES];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    UITouch *touch = [[event allTouches] anyObject];
    
    if ([_searchBar isFirstResponder] && [touch view] != _searchBar)
        
    {
        [_searchBar resignFirstResponder];
        
    }
    [super touchesBegan:touches withEvent:event];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


@end
