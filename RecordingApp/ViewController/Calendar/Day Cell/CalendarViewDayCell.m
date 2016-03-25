//
//  CalendarViewDayCell.m
//  RecordingApp
//
//  Created by Mitul on 28/12/15.
//  Copyright (c) 2015 Om Info. All rights reserved.
//

#import "CalendarViewDayCell.h"

@implementation CalendarViewDayCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        
        // setup label
        
        UIFont* font = [UIFont fontWithName:@"Helvetica Neue" size:14.0f];
        
        CGFloat labelSideLength = MIN(frame.size.width, frame.size.height);
        
        CGRect labelFrame = CGRectZero;
        
        labelFrame.size = CGSizeMake(labelSideLength, labelSideLength);
        
        self.label = [[UILabel alloc] initWithFrame:labelFrame];
        
        self.label.textAlignment = NSTextAlignmentCenter;
        
        self.label.font = font;
        
        self.label.backgroundColor = [UIColor clearColor];
        
        self.label.center = CGPointMake(frame.size.width * 0.5f, frame.size.height * 0.5f);
        
        self.label.minimumScaleFactor = 10.0f;
        
        self.label.adjustsFontSizeToFitWidth = YES;
        
        labelFrame = self.label.frame;
        
        // This marks the selected day with a circle
        
        _selectedMarkView = [[UIView alloc] initWithFrame:CGRectInset(labelFrame, 3.0f, 3.0f)];

        _selectedMarkView.clipsToBounds = YES;
        
        _selectedMarkView.layer.cornerRadius = _selectedMarkView.frame.size.width * 0.5f;
        
        _selectedMarkView.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:_selectedMarkView];
        
        [self addSubview:self.label];
        
        
        // This marks the day as being today
        
        
        _todayMarkView = [[UIView alloc] initWithFrame:CGRectMake(5.0f, self.frame.size.height - 22.0f, 3.0f, 3.0f)];
        
        _todayMarkView.center = CGPointMake(self.bounds.size.width * 0.5 + 1.0f, _todayMarkView.center.y);
        
        _todayMarkView.backgroundColor = [UIColor redColor];
        
        _todayMarkView.layer.cornerRadius = _todayMarkView.frame.size.width * 0.5f;
        
        [self addSubview:_todayMarkView];
        
        CGFloat height = 5.0;
        
        CGFloat width = self.frame.size.height - 5.0;
        
        _eventsMarksView = [[UIView alloc] initWithFrame:CGRectMake(5.0f, 5.0f, width, height)];
        
        _eventsMarksView.backgroundColor = [UIColor clearColor];
        
        CGFloat xpos = 0.0f;
        
        CGFloat third = width / 3.0;
        
        for (int i = 0; i < 3; i++)
        {
            UIView* eventCircleView = [[UIView alloc] initWithFrame:CGRectMake(xpos, 0.0, height, height)];
            eventCircleView.layer.cornerRadius = height * 0.5;
            
            eventCircleView.clipsToBounds = YES;
            
            eventCircleView.tag = 100 + i;
            
            eventCircleView.backgroundColor = [UIColor clearColor];
            
            xpos += third;
            
            [_eventsMarksView addSubview:eventCircleView];
        }
        
        [self addSubview:_eventsMarksView];
        
        self.isDaySelected = NO;
    }
    return self;
}


#pragma mark - Accessors

// suport for later synch with iOS calendar

-(void)setEvents:(NSArray *)events
{
    _events = events;
    
    for (int i = 0; i < _events.count; i++)
    {
        UIView* circleEventView = [_eventsMarksView viewWithTag:(100 + i)];
        
        circleEventView.backgroundColor = [UIColor redColor];
    }
}


-(void)setIsCurrentMonth:(BOOL)isCurrentMonth
{
    _isCurrentMonth = isCurrentMonth;
    
    if (_isCurrentMonth)
    {
        _todayMarkView.backgroundColor = [UIColor redColor];
        
        self.label.textColor = [UIColor darkGrayColor];
    }
    else
    {
        _todayMarkView.backgroundColor = [UIColor lightGrayColor];
        
        self.label.textColor = [UIColor lightGrayColor];
    }
    
    if(_isDaySelected)
    {
        self.label.textColor = [UIColor blueColor];
    }
    
}


-(void)prepareForReuse
{
    [super prepareForReuse];
    
    for (UIView* circleEventMark in _eventsMarksView.subviews)
    {
        circleEventMark.backgroundColor = [UIColor clearColor];
        
    }
    
}


-(void)setIsToday:(BOOL)isToday
{
    _isToday = isToday;
    
    if (_isToday)
    {
        _todayMarkView.hidden = NO;
    }
    else
    {
        _todayMarkView.hidden = YES;
    }
    
}


- (void) setIsDaySelected:(BOOL)isDaySelected
{
    
    _isDaySelected = isDaySelected;
    
    if (isDaySelected)
    {
        
        _selectedMarkView.hidden = NO;
        
        _todayMarkView.hidden = YES;
        
        self.label.textColor = [UIColor whiteColor];
    }
    else
    {
        self.label.textColor = [UIColor darkGrayColor];
        
        _selectedMarkView.hidden = YES;
        
        self.isToday = _isToday;
        // * Pass value to call setter which defines the opacity of the Today label
    }
    
}


-(NSString*)description
{
    return [NSString stringWithFormat:@"<CalendarViewDayCell %p (date:%@)>", self, self.date];
}
@end
