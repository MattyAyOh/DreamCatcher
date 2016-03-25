//
//  MonthCollectionViewFlowLayout.m
//  RecordingApp
//
//  Created by Mitul on 28/12/15.
//  Copyright (c) 2015 Om Info. All rights reserved.
//

#import "MonthCollectionViewFlowLayout.h"
#import "CalendarLineReusableView.h"

static NSInteger CalendarColumns = 7; // days in week

static CGFloat DecorationViewHeight = 1.0;

@implementation MonthCollectionViewFlowLayout


- (instancetype) initWithCollectionViewSize:(CGSize)size andHeaderHeight:(CGFloat)height
{
    if (self = [super init])
    {
        
        self.itemSize = CGSizeMake(floor(size.width / (CGFloat)CalendarColumns), (size.height - height) / 6.0f);
        
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        self.minimumLineSpacing = 0.0f;
        
        self.minimumInteritemSpacing = 0.0f;
        
        self.sectionInset = UIEdgeInsetsZero;
        
        self.headerReferenceSize = CGSizeMake(size.width, height);
        
        self.footerReferenceSize = CGSizeZero;
        
        [self registerClass:[CalendarLineReusableView class] forDecorationViewOfKind:NSStringFromClass([CalendarLineReusableView class])];
        
    }
    return self;
}


-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    
    
    NSMutableArray* layoutAttributesMutableArray = [super layoutAttributesForElementsInRect:rect].mutableCopy;
    
    NSMutableArray* decorationLayoutAttributesMutableArray = @[].mutableCopy;
    
    for (UICollectionViewLayoutAttributes* layoutAttributes in layoutAttributesMutableArray)
    {
        if(layoutAttributes.indexPath.item % CalendarColumns == 0)
        {
            UICollectionViewLayoutAttributes* decorationLayoutAttributes = [self layoutAttributesForDecorationViewOfKind:NSStringFromClass([CalendarLineReusableView class])atIndexPath:layoutAttributes.indexPath];
            
            [decorationLayoutAttributesMutableArray addObject:decorationLayoutAttributes];
        }
    }
    
    // Combine Arrays
    [layoutAttributesMutableArray addObjectsFromArray:decorationLayoutAttributesMutableArray];
    
    return layoutAttributesMutableArray;
}


// layout attributes for a specific decoration view

- (UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString *)decorationViewKind atIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionViewLayoutAttributes *layoutAttributes = [UICollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:decorationViewKind withIndexPath:indexPath];
    
    NSInteger rowIndex = indexPath.item / CalendarColumns;
    
    CGFloat bottomOfCell = self.headerReferenceSize.height + self.itemSize.height - DecorationViewHeight;
    
    CGFloat yPosition = (rowIndex * self.itemSize.height) + bottomOfCell;
    
    
    layoutAttributes.frame = CGRectIntegral( CGRectMake(0.0, yPosition, self.collectionView.frame.size.width, rowIndex == 2 ? DecorationViewHeight + 1.0 : DecorationViewHeight) );
    
    return layoutAttributes;
}
@end
