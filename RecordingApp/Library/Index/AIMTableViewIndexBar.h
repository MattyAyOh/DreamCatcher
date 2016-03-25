//
//  AIMTableViewIndexBar.h
//  RecordingApp
//
//  Created by Mitul on 30/12/15.
//  Copyright (c) 2015 Om Info. All rights reserved.
//


#import <UIKit/UIKit.h>

@class AIMTableViewIndexBar;

@protocol AIMTableViewIndexBarDelegate <NSObject>

- (void)tableViewIndexBar:(AIMTableViewIndexBar*)indexBar didSelectSectionAtIndex:(NSInteger)index;

@end

@interface AIMTableViewIndexBar : UIView

@property (nonatomic, strong) NSArray *indexes;
@property (nonatomic, weak) id <AIMTableViewIndexBarDelegate> delegate;

@end
