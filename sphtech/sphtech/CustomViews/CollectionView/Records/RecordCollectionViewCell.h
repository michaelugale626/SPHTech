//
//  RecordCollectionViewCell.h
//  sphtech
//
//  Created by Michael Ugale on 1/15/19.
//  Copyright © 2019 Michael Ugale. All rights reserved.
//

#import "BaseCollectionViewCell.h"

@interface RecordCollectionViewCell : BaseCollectionViewCell

@property (weak, nonatomic) IBOutlet UIView *mainContainer;
@property (weak, nonatomic) IBOutlet UIView *imageContainer;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *quarterLabel;
@property (weak, nonatomic) IBOutlet UILabel *quarterValue;
@property (weak, nonatomic) IBOutlet UILabel *volumeLabel;
@property (weak, nonatomic) IBOutlet UILabel *volumeValue;
@property (weak, nonatomic) IBOutlet UIButton *imageOverlay;

@property (strong, nonatomic) IBOutlet UIImageView *thumbImageView;
@property (strong, nonatomic) NSMutableArray *images;
@property NSInteger currentIndex;

- (void)setvalue:(QuarterManager *)quarter set:(Boolean)isActive;

@end
