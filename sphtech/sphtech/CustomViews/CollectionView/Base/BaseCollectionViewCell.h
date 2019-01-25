//
//  BaseCollectionViewCell.h
//  sphtech
//
//  Created by Michael Ugale on 1/15/19.
//  Copyright © 2019 Michael Ugale. All rights reserved.
//

#import <UIKit/UIKit.h>

//Vendor
#import <SDWebImage/UIImageView+WebCache.h>

//Utilities
#import "Utilities.h"
#import "Cache.h"

//Categories
#import "UIColor+More.h"

//Objects
#import "RecordsManager.h"
#import "QuarterManager.h"

#import "Constant.h"

@interface BaseCollectionViewCell : UICollectionViewCell

+ (NSString *)cellIdentifier;
+ (instancetype)dequeueForTableView:(UICollectionView *)tableView indexPath:(NSIndexPath *)indexPath;

+ (CGFloat)cellHeight;
+ (CGFloat)estimatedCellHeight;

- (UIColor *)selectedBackgroundViewColor;

@end
