//
//  RecordCollectionViewCell.m
//  sphtech
//
//  Created by Michael Ugale on 1/15/19.
//  Copyright © 2019 Michael Ugale. All rights reserved.
//

#import "RecordCollectionViewCell.h"

//Vendor
#import <DSBarChart/DSBarChart.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <ImageZoomViewer/ImageZoomViewer.h>

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

- (void)setvalue:(YearManager *)year set:(Boolean)isActive
{
    NSMutableArray *list = [[NSMutableArray alloc] initWithArray:[[RecordModel sharedManager] getItemByID:year.yearID]];
    NSString *imageURL = API_MEDIA_BASE_URL;
    
    [self.image sd_setImageWithURL:[NSURL URLWithString:imageURL]
                  placeholderImage:[UIImage imageNamed:@"default_grid"]];
    
    [self.image setHidden:YES];
    
    float previous = 0.0;
    Boolean changed = false;
    NSMutableArray *vals = [[NSMutableArray alloc] init];
    NSMutableArray *refs = [[NSMutableArray alloc] init];
    
    for (int i = 0; i <= [list count] - 1; i++) {
        RecordsManager *record    = list[i];
        float volume = [[record valueForKey:@"volume"] floatValue];
        
        [vals addObject:[NSNumber numberWithFloat:volume]];
        [refs addObject:[record valueForKey:@"quarter"]];
        
        if (previous > volume) {
            changed = true;
        }
        
        previous = volume;
    }
    
    [self setQuaterValue:list[0] setValue:list[[list count] - 1]];
    
    DSBarChart *chrt = [[DSBarChart alloc] initWithFrame:self.imageContainer.bounds
                                                   color:[UIColor blueColor]
                                              references:refs
                                               andValues:vals];
    [chrt setBackgroundColor:[UIColor whiteColor]];
    chrt.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    chrt.bounds = self.imageContainer.bounds;
    [self.imageContainer addSubview:chrt];
    
    if (changed) {
        [self addButton];
    }
}

- (void) setQuaterValue: (RecordsManager *)fisrt setValue:(RecordsManager *) last
{
    self.volumeValue.text = [NSString stringWithFormat:@"%@ - %@",[fisrt valueForKey:@"volume"], [last valueForKey:@"volume"]];
    self.quarterValue.text = [NSString stringWithFormat:@"%@ - %@",[fisrt valueForKey:@"quarter"], [last valueForKey:@"quarter"]];
}

- (void) addButton
{
    [self.imageContainer addSubview:self.imageOverlay];
    
    [self.imageOverlay addTarget:self action:@selector(enlargeImage) forControlEvents:UIControlEventTouchUpInside];
    [self.imageOverlay setUserInteractionEnabled:YES];
}


#pragma mark - NYTPhotos Gallery

- (void) enlargeImage
{
    self.images = [[NSMutableArray alloc]init];
    [self.images addObject:API_MEDIA_BASE_URL];
    
    self.thumbImageView.layer.borderWidth = 1.0;
    [self.thumbImageView.layer setBorderColor:[UIColor orangeColor].CGColor];
    self.currentIndex = 0;
    [self.thumbImageView sd_setImageWithURL:[NSURL URLWithString:[self.images firstObject]]];
    
    ImageZoomViewer *zoomImageView = [[ImageZoomViewer alloc]initWithBottomCollectionBorderColor:[UIColor orangeColor]];
    [zoomImageView.closeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    zoomImageView.delegate = (id)self;
    CGPoint point = [self convertPoint:self.thumbImageView.frame.origin toView:self];
    CGRect animFrame = CGRectMake(point.x, point.y, self.thumbImageView.frame.size.width, self.thumbImageView.frame.size.height);
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:animFrame];
    [imgView sd_setImageWithURL:[NSURL URLWithString:[self.images firstObject]]];
    [zoomImageView showWithPageIndex:self.currentIndex andImagesCount:self.images.count withInitialImageView:imgView andAnimType:AnimationTypePop];
}

# pragma Mark - ImageZoomViewer Delegates

- (void)initializeImageviewWithImages:(UIImageView *)imageview withIndexPath:(NSIndexPath *)indexPath withCollection:(int)collectionReference
{
    NSString *urlString = [self.images objectAtIndex:indexPath.row];
    [imageview sd_setImageWithURL:[NSURL URLWithString:urlString]];
}

- (void)imageIndexOnChange:(NSInteger)index
{
    self.currentIndex = index;
    [self.thumbImageView sd_setImageWithURL:[NSURL URLWithString:[self.images objectAtIndex:self.currentIndex]]];
}
@end
