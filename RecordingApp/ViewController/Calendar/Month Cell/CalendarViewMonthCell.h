//
//  CalendarViewMonthCell.h
//  RecordingApp
//
//  Created by Mitul on 28/12/15.
//  Copyright (c) 2015 Om Info. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalendarViewMonthCell : UICollectionViewCell

@property (nonatomic, copy) NSDate* displayMonthDate;

@property (nonatomic, copy) NSDate* dateSelected;

@property (nonatomic) NSInteger firstDayActive;

@property (nonatomic) NSInteger lastDayActive;

@property (nonatomic, strong) UICollectionView* collectionView;

@property (nonatomic, weak) NSArray* events;

@property (nonatomic, weak) id<UICollectionViewDelegate> delegate;

@end
