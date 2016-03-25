//
//  CalendarHeaderView.m
//  RecordingApp
//
//  Created by Mitul on 28/12/15.
//  Copyright (c) 2015 Om Info. All rights reserved.
//

#import "CalendarHeaderView.h"

@implementation CalendarHeaderView

-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
      
        self.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1];
        
        // Day labels
        CGFloat xpos = 0.0f;
        
        CGFloat lwidth = frame.size.width / 7.0f;
        
        CGFloat lheight = frame.size.height;
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        
        for (NSString* weekday in dateFormatter.weekdaySymbols)
        {
            
            UILabel* dayLabel = [[UILabel alloc] initWithFrame:CGRectMake(xpos, 0.0f, lwidth, lheight)];
            
            dayLabel.backgroundColor = [UIColor clearColor];
            
            dayLabel.textColor = [UIColor colorWithRed:80/255.0 green:90/255.0 blue:90/255.0 alpha:1];
            
            dayLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:12.0f];
            
            dayLabel.textAlignment = NSTextAlignmentCenter;
            
            dayLabel.text = [weekday substringToIndex:3];
            
            [self addSubview:dayLabel];
            
            xpos += lwidth;
            
        }
        
        
    }
    return self;
}



+ (CGFloat) height
{
    return 25.0f; // override
}

@end
