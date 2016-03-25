//
//  CalendarViewDayCell.h
//  RecordingApp
//
//  Created by Mitul on 28/12/15.
//  Copyright (c) 2015 Om Info. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalendarViewDayCell : UICollectionViewCell

{
    UIView* _selectedMarkView;
    
    UIView* _todayMarkView;
    
    UIView* _eventsMarksView;
}

@property (nonatomic, strong) UILabel* label;

@property (nonatomic) BOOL isToday;

@property (nonatomic) BOOL isCurrentMonth;

@property (nonatomic) BOOL isDaySelected;

@property (nonatomic, weak) NSArray* events;

@property (nonatomic, strong) NSDate* date;

@end
