//
//  Calendar.m
//  RecordingApp
//
//  Created by Mitul on 28/12/15.
//  Copyright (c) 2015 Om Info. All rights reserved.
//

#import "CalendarViewController.h"
#import "DBConnection.h"
#import <sqlite3.h>

@interface CalendarViewController () <UITableViewDataSource, UITableViewDelegate>
{
    NSArray *sections;
    NSMutableArray *rowsData;
    NSMutableArray *rowsRecording;
    UITextField *txt_Editname;
    NSString *EditRecordingName;
}


@property (strong, nonatomic) IBOutlet CalendarView *CalendarView;

@property (strong, nonatomic) IBOutlet UILabel *monthDisplayedDayLabel;

@property (nonatomic) CGFloat originalHeightOfConstaint;

@property (strong, nonatomic) IBOutlet UIButton *previousMonthButton;

@property (strong, nonatomic) IBOutlet UIButton *nextMonthButton;

@property (nonatomic, strong) NSDateFormatter* formatter;

@property (strong, nonatomic) IBOutlet UITextField *inputTextField;


@end

@implementation CalendarViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _tableView.layer.cornerRadius=8;
    _CalendarView.layer.cornerRadius=8;
    _monthDisplayedDayLabel.layer.cornerRadius=8;
    _txv_Header.layer.cornerRadius=4;
  

    [_tableView reloadData];
    
    /*
    UIImage *img = [UIImage imageNamed:@"Cloud"];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [imgView setImage:img];
    //setContent mode aspect fit
    [imgView setContentMode:UIViewContentModeCenter];
    self.navigationItem.titleView = imgView;
    */
}

- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    NSString *getData = [NSString stringWithFormat: @"SELECT * FROM recording_input_dreams"];
    NSLog(@"%@",getData);
    
    rowsData = [DBConnection fetchResults:getData];
    NSLog(@"%@",rowsData);
    
    [_tableView reloadData];
    
    self.formatter = [[NSDateFormatter alloc] init];
    self.formatter.dateFormat = @"dd.MM.yyyy";
    self.CalendarView.delegate = self;
    self.CalendarView.dataSource = self;
    self.CalendarView.showsEvents = NO;
    
}

-(IBAction)SelectRecoring:(id)sender
{
    
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    
    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    
    UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    RecordViewController *recordview = [storyboard instantiateViewControllerWithIdentifier:@"RecordViewController"];
    
    [self.navigationController pushViewController:recordview animated:YES];

}

-(IBAction)AddnewDreams:(id)sender
{
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    
    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    
    UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    InputDreamViewController *addDreamview = [storyboard instantiateViewControllerWithIdentifier:@"InputDreamViewController"];
    
    [self.navigationController pushViewController:addDreamview animated:YES];
}

#pragma mark - UITableViewDelegate && UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [rowsData count];
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict = [rowsData objectAtIndex:indexPath.row];
    
    if ([[dict objectForKey:@"isdreams"] isEqualToString:@"0"])
    {
        UITableViewCell *cellData = [tableView dequeueReusableCellWithIdentifier:@"DataCell"];
        
        UILabel *lblCellData = (UILabel *)[cellData viewWithTag:101];
        
        [lblCellData setText:[NSString stringWithFormat:@"%@",[dict valueForKey:@"input_title"]]];
        
        return cellData;
        
    } else
    {
        UITableViewCell *cellRecording = [tableView dequeueReusableCellWithIdentifier:@"RecordingCell"];
        
        UILabel *lblCellRecording = (UILabel *)[cellRecording viewWithTag:103];
        
        [lblCellRecording setText:[NSString stringWithFormat:@"%@ %@",[dict valueForKey:@"recording_path"],[dict valueForKey:@"recording_duration"]]];
        
        return cellRecording;
    }
    
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
    /*  DREAMS & RECORDING EDIT NAME ACTION AND DELETE ACTION CODE */
 -(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict = [rowsData objectAtIndex:indexPath.row];
    
         /* DREAMS DELETE ACTION  */
    if ([[dict objectForKey:@"isdreams"] isEqualToString:@"0"])
    {
        UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"Delete"  handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
        {
            NSString *deleteData = [NSString stringWithFormat: @"DELETE FROM recording_input_dreams WHERE recording_id = '%@' ",[[rowsData objectAtIndex:indexPath.row] valueForKey:@"recording_id"]];
            
            NSLog(@"%@",deleteData);
            
            [DBConnection executeQuery:deleteData];
            
            [rowsData removeObjectAtIndex:indexPath.row];
            [_tableView reloadData];
        }];
        deleteAction.backgroundColor = [UIColor colorWithRed:1.0f green:0.231f blue:0.188 alpha:1.0f];  /* DELETE BUTTON COLOR  */
        
        return @[deleteAction];
    }
    
        /*  RECORDING SAVE US & DELETE ACTION  */
    else
    {
        EditRecordingName = [[rowsData objectAtIndex:indexPath.row] valueForKey:@"recording_id"];
        
        UITableViewRowAction *editAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"Edit" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
        {
            /* RECORDING ROW EDIT NAME ACTION USINGH UIALERTVIEW  */
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Save Us" message:@"Enter Recording Name" delegate:self cancelButtonTitle:@"Cancel"otherButtonTitles:@"OK", nil];
            
            alert.alertViewStyle = UIAlertViewStylePlainTextInput;
            [alert show];
            [_tableView reloadData];
        }];
        
        editAction.backgroundColor = [UIColor colorWithRed:0.78f green:0.78f blue:0.8f alpha:1.0]; /* EDIT BUTTON COLOR  */
        
        UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"Delete"  handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
        {
            /* RECORDING ROW DELETE ACTION  */
            
            NSString *deleteData = [NSString stringWithFormat: @"DELETE FROM recording_input_dreams WHERE recording_id = '%@' ", EditRecordingName];
            
            NSLog(@"%@",deleteData);
            
            [DBConnection executeQuery:deleteData];
            
            [rowsData removeObjectAtIndex:indexPath.row];
            
            [_tableView reloadData];
        }];
        
        deleteAction.backgroundColor = [UIColor colorWithRed:1.0f green:0.231f blue:0.188 alpha:1.0f];  /* DELETE BUTTON COLOR  */
        
        return @[deleteAction,editAction];
        
    }
}

    /* EDIT RECORDING NAME ALERTVIEW METHOD ACTION  */
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        NSString *editName = [NSString stringWithFormat:@"UPDATE recording_input_dreams SET recording_path = '%@' WHERE recording_id = '%@'",[alertView textFieldAtIndex:0].text, EditRecordingName];
        
        NSLog(@"%@",editName);
        
        [DBConnection executeQuery:editName];
        [_tableView reloadData];
    }
}

            /* DETAILS VIEW ENTRY */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([[[rowsData objectAtIndex:indexPath.row] objectForKey:@"isdreams"] isEqualToString:@"0"])
    {
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        DetailsViewController *recordview = [storyboard instantiateViewControllerWithIdentifier:@"DetailsViewController"];
        recordview.detailsinput = [rowsData objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:recordview animated:YES];
    }
else
    {
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        RecordViewController *recordview = [storyboard instantiateViewControllerWithIdentifier:@"RecordViewController"];
        recordview.recorderSettings = [rowsData objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:recordview animated:YES];
    }
}


#pragma mark - CalendarDataSource
-(NSDate*)startDate
{
    
    NSDateComponents *offsetDateComponents = [[NSDateComponents alloc] init];
    
   //offsetDateComponents.month = -1;
    
    NSDate *threeMonthsBeforeDate = [[NSCalendar currentCalendar]dateByAddingComponents:offsetDateComponents toDate:[NSDate date] options:0];
    
    return threeMonthsBeforeDate;
}


-(NSDate*)endDate
{
    NSDateComponents *offsetDateComponents = [[NSDateComponents alloc] init];
    
   //offsetDateComponents.year = 4;
    offsetDateComponents.month = 12;
    
    NSDate *yearLaterDate = [[NSCalendar currentCalendar] dateByAddingComponents:offsetDateComponents toDate:[NSDate date] options:0];
    
    return yearLaterDate;
}

#pragma mark - KDCalendarDelegate

-(void)calendarController:(CalendarView*)calendarViewController didSelectDay:(NSDate*)date
{
    if(!date)
    {
        self.inputTextField.text = @"";
    }
    else
    {
        
        self.inputTextField.text = [self.formatter stringFromDate:date];
    }
}


-(void)calendarController:(CalendarView*)calendarViewController didScrollToMonth:(NSDate*)date
{
    
    NSDateFormatter* headerFormatter = [[NSDateFormatter alloc] init];
    headerFormatter.dateFormat = @"MMMM - yyyy";
    
    self.monthDisplayedDayLabel.text = [headerFormatter stringFromDate:date];
    
    [self enableButtons:YES];
}


#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    self.inputTextField.text = @"";
    
    [self.inputTextField resignFirstResponder];
    
    return YES;
}


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.inputTextField.text = @"";
}


- (void) textFieldDidEndEditing:(UITextField *)textField
{
    if(self.CalendarView.dateSelected)
    {
        self.inputTextField.text = [self.formatter stringFromDate:self.CalendarView.dateSelected];
    }
    else
    {
        self.inputTextField.text = @"";
    }
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    NSMutableString* mutableTextString = self.inputTextField.text.mutableCopy;
    
    [mutableTextString replaceCharactersInRange:range withString:string];
    
    if(range.length == 0) // we are adding a sinlge digit
    {
        NSCharacterSet* numericCharacterSet = [NSCharacterSet decimalDigitCharacterSet];
        
        if ([string rangeOfCharacterFromSet:numericCharacterSet].location == NSNotFound)
        {
            return NO;
        }
        
        if([string isEqualToString:@"."])
        {
            return NO;
        }
        
        if((range.location == 1 || range.location == 4) && range.location == self.inputTextField.text.length)
            // if we are appending at the end, help by putting the '.' dots
        {
            [mutableTextString appendString:@"."];
        }
    }
    
    self.inputTextField.text = mutableTextString;
    
    return NO;
}


- (IBAction)previousMonthButton:(id)sender
{
    [self stepMonthInCalendarByValue:-1];
}



- (IBAction)nextMonthButton:(id)sender
{
    [self stepMonthInCalendarByValue:1];
}


-(void)enableButtons:(BOOL)enable
{
    
    for (UIButton* button in @[self.previousMonthButton, self.nextMonthButton])
    {
        
        button.enabled = enable;
        
    }
}

- (void)stepMonthInCalendarByValue:(NSInteger)value
{
    
    
    [self enableButtons:NO];
    
    NSCalendar* calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents* oneMonthAheadDateComponents = [[NSDateComponents alloc] init];oneMonthAheadDateComponents.month = value;
    
    NSDate* monthDisplayed = self.CalendarView.monthDisplayed;
    
    NSDate* oneMonthLaterDate = [calendar dateByAddingComponents:oneMonthAheadDateComponents toDate:monthDisplayed options:0];
    
    [self.CalendarView setMonthDisplayed:oneMonthLaterDate animated:YES];
}
@end
