//
//  BaseCollectionViewCell.m
//  sphtech
//
//  Created by Michael Ugale on 1/15/19.
//  Copyright © 2019 Michael Ugale. All rights reserved.
//

#import "BaseCollectionViewCell.h"

@implementation BaseCollectionViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    UIView *selectedBackgroundView = [UIView new];
    selectedBackgroundView.layer.backgroundColor = [self selectedBackgroundViewColor].CGColor;
    self.selectedBackgroundView = selectedBackgroundView;
    
    self.clipsToBounds = YES;
}

+ (NSString *)cellIdentifier
{
    return [NSStringFromClass([self class]) stringByAppendingString:@"_cellID"];
}

+ (instancetype)dequeueForTableView:(UICollectionView *)tableView indexPath:(NSIndexPath *)indexPath
{
    return [tableView dequeueReusableCellWithReuseIdentifier:[self cellIdentifier] forIndexPath:indexPath];
}

+ (CGFloat)cellHeight
{
    NSAssert(NO, @"This method must be overridden in the subclass!");
    return 0;
}

+ (CGFloat)estimatedCellHeight
{
    return 100.0;
}

- (UIColor *)selectedBackgroundViewColor
{
    return [UIColor colorWithWhite:0.9 alpha:1];
}

@end
