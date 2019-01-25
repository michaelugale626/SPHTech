//
//  RecordCollectionViewCell.m
//  sphtech
//
//  Created by Michael Ugale on 1/15/19.
//  Copyright © 2019 Michael Ugale. All rights reserved.
//

#import "RecordCollectionViewCell.h"
#import <DSBarChart/DSBarChart.h>

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

- (void)setvalue:(QuarterManager *)quarter set:(Boolean)isActive
{
    NSMutableArray *qList = [[NSMutableArray alloc] initWithArray:[[Cache shared] getCachedObjectForKey:DATA_INFORMATION]];
    NSMutableArray *list = [[NSMutableArray alloc] initWithArray:[qList valueForKey:[NSString stringWithFormat:@"%@",quarter]]];
    [list removeObjectIdenticalTo:[NSNull null]];
    NSString *imageURL = API_MEDIA_BASE_URL;
    
    [self.image sd_setImageWithURL:[NSURL URLWithString:imageURL]
                  placeholderImage:[UIImage imageNamed:@"default_grid"]];
    
    [self.imageOverlay setHidden:isActive];
    [self.image setHidden:YES];
    
    NSMutableArray *vals = [[NSMutableArray alloc] init];
    NSMutableArray *refs = [[NSMutableArray alloc] init];
    
    for (int i = 0; i <= [list count] - 1; i++) {
        RecordsManager *record    = list[i];
        
        [vals addObject:[NSNumber numberWithFloat:[record.recordVolume floatValue]]];
        [refs addObject:record.recordQuarter];
    }
    
    
    DSBarChart *chrt = [[DSBarChart alloc] initWithFrame:self.imageContainer.bounds
                                                   color:[UIColor blueColor]
                                              references:refs
                                               andValues:vals];
    [chrt setBackgroundColor:[UIColor whiteColor]];
    chrt.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    chrt.bounds = self.imageContainer.bounds;
    [self.imageContainer addSubview:chrt];
}

@end
