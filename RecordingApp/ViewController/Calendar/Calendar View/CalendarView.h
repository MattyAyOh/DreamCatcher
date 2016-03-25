//
//  CalendarView.h
//  RecordingApp
//
//  Created by Mitul on 28/12/15.
//  Copyright (c) 2015 Om Info. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalendarViewMonthCell.h"

@protocol CalendarDelegate;
@protocol CalendarDataSource;

@interface CalendarView : UIView

@property (nonatomic, strong) NSDate* dateSelected;

@property (nonatomic, strong) NSDate* monthDisplayed;
// a date representing the first of the month



@property (nonatomic) BOOL showsEvents;

@property (nonatomic) BOOL showsWholeMonthsOnStartAndEnd;


@property (nonatomic, weak) id <CalendarDelegate> delegate;

@property (nonatomic, weak) id <CalendarDataSource> dataSource;


- (void) setDateSelected:(NSDate *)dateSelected animated:(BOOL)animated;

- (void)setMonthDisplayed:(NSDate *)monthDisplayed animated:(BOOL)animated;


@end



@protocol CalendarDelegate <NSObject>

@optional

-(void)calendarController:(CalendarView*)calendarViewController didSelectDay:(NSDate*)date;

-(void)calendarController:(CalendarView*)calendarViewController didScrollToMonth:(NSDate*)date;


/* YES by default */
-(BOOL)calendarController:(CalendarView*)calendarViewController canSelectDate:(NSDate*)date;


@end


@protocol CalendarDataSource <NSObject>

@required

-(NSDate*)startDate;


@optional

-(NSDate*)endDate;
@end
