//
//  RecordCollectionViewCell.m
//  sphtech
//
//  Created by Michael Ugale on 1/15/19.
//  Copyright © 2019 Michael Ugale. All rights reserved.
//

#import "RecordCollectionViewCell.h"

@implementation RecordCollectionViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.mainContainer.layer.cornerRadius   = 5;
    self.mainContainer.layer.masksToBounds  = YES;
    
    self.imageContainer.layer.cornerRadius   = 5;
    self.imageContainer.layer.masksToBounds  = YES;
    
    [self.quarterValue setFont:FONT_UI_Text_Light(16)];
    [self.quarterValue setTextColor:[UIColor colorWithHex:THEME_COLOR_BLACK]];
    
    [self.volumeValue setFont:FONT_UI_Text_Regular(16)];
    [self.volumeValue setTextColor:[UIColor colorWithHex:THEME_COLOR_BLACK]];
    
}

- (void)setvalue:(RecordsManager *)record set:(Boolean)isActive
{
    NSString *imageURL = API_MEDIA_BASE_URL;
    
    self.quarterValue.text    = record.recordQuarter;
    self.volumeValue.text     = record.recordVolume;
    
    SPLOG_DEBUG(@"imageURL: %@",imageURL);
    
    [self.image sd_setImageWithURL:[NSURL URLWithString:imageURL]
                  placeholderImage:[UIImage imageNamed:@"default_grid"]];
    
    [self.imageOverlay setHidden:isActive];
}

@end
