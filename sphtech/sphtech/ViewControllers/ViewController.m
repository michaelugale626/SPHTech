//
//  ViewController.m
//  sphtech
//
//  Created by Michael Ugale on 1/14/19.
//  Copyright © 2019 Michael Ugale. All rights reserved.
//

#import "ViewController.h"

//Utilities
#import "Utilities.h"

//Vendor
#import <MBProgressHUD/MBProgressHUD.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <ImageZoomViewer/ImageZoomViewer.h>

//Object
#import "RecordsSetter.h"

//Categories
#import "UIColor+More.h"

//CustomViews
#import "RecordCollectionViewCell.h"

#define PAGE_LIMIT @"30"

@interface ViewController () {
    
    //Vendor
    __weak IBOutlet UIImageView *thumbImageView;
    NSMutableArray *images;
    NSInteger currentIndex;
}

//Vendor
@property (strong, nonatomic) MBProgressHUD *hud;

@property (nonatomic, strong) NSMutableArray            *listProducts;
@property (weak, nonatomic) IBOutlet UICollectionView   *collectionView;
@property UIRefreshControl                              *refreshControl;

@property Boolean isLoadMore;
@property Boolean isLoading;
@property Boolean hasInternet;
@property int loaderCtr;
@property int totalItemLoaded;
@property int offset;
@property float previous;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initializeObjects];
    [self configureView];
    [self getData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Methods

/**
 Set varables values
 */
- (void)initializeObjects
{
    self.offset         = 0;
    self.loaderCtr      = 0;
    self.isLoading      = false;
    self.hasInternet    = true;
    self.isLoadMore     = false;
}

/**
 Set Collection View Layout and set pull to refresh
 */
- (void) cofigureCollectionView
{
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [self.collectionView setBackgroundColor:[UIColor clearColor]];
    self.collectionView.backgroundColor  = [UIColor colorWithHex:THEME_BACKGROUND_COLOR];
    self.refreshControl = [[UIRefreshControl alloc]init];
    [self.refreshControl setBackgroundColor: [UIColor clearColor]];
    [self.collectionView addSubview:self.refreshControl];
    [self.refreshControl addTarget:self
                            action:@selector(pullToRefresh)
                  forControlEvents:UIControlEventValueChanged];
}

- (void)configureView
{
    [self cofigureCollectionView];
}


/**
 Set Navigation Title and design
 */
- (void) configureNavigationBar
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark - UICollectionViewDataSource / UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.listProducts count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RecordCollectionViewCell *cell = [RecordCollectionViewCell dequeueForTableView:collectionView indexPath:indexPath];
    [cell setvalue:self.listProducts[indexPath.row] set:false];
    
    RecordsManager *record = self.listProducts[indexPath.row];
    
    if (self.previous > [record.recordVolume floatValue]) {
        [cell.imageOverlay addTarget:self action:@selector(enlargeImage) forControlEvents:UIControlEventTouchUpInside];
        [cell.imageOverlay setUserInteractionEnabled:YES];
        [cell.imageOverlay setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0]];
        
    } else {
        [cell.imageOverlay setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1]];
        [cell.imageOverlay setUserInteractionEnabled:NO];
    }
    
    self.previous = [record.recordVolume floatValue];
    
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    float width = (self.collectionView.frame.size.width / 2) - 15;
    return CGSizeMake(width, 270);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ( (indexPath.row == [self.listProducts count] - 1 ) && (self.hasInternet) ) {
        [self loadMoreItems];
    }
}

#pragma mark - API Action

/**
 Check if API call is still loading if not start loading animation
 */
- (void)checkIsLoading
{
    self.loaderCtr++;
    
    self.isLoading = true;
    
    if (!self.refreshControl.refreshing) {
        if (self.loaderCtr == 1) {
            [self.refreshControl endRefreshing];
            [self.hud hideAnimated:YES afterDelay:0.25f];
            self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        }
    } else {
        self.isLoadMore = false;
    }
}

/**
 Reset all initial objects and get product list
 */
- (void)pullToRefresh
{
    [self initializeObjects];
    [self getData];
}

/**
 Set true to load more variable and get more product list
 */
- (void)loadMoreItems
{
    self.isLoadMore = true;
    [self getData];
}

/**
 Check API call ends and stop animation loader
 */
- (void)hasLoadingItem
{
    self.isLoading        = false;
    self.hasInternet      = true;
    self.isLoadMore       = false;
    self.loaderCtr--;
    
    if (self.loaderCtr <= 0) {
        [self.refreshControl endRefreshing];
        [self.hud hideAnimated:YES afterDelay:0.25f];
    }
}

/**
 Get the record list from the API
 */
- (void)getData
{
    if (!self.isLoading) {
        
        [self checkIsLoading];
        
        NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
        [dictionary setObject:PAGE_LIMIT forKey:@"limit"];
        
        [[ServerManager sharedManager] getDataList:dictionary
                                           success:^(NSDictionary *responseObject) {
                                               SPLOG_DEBUG(@"DATA LIST: %@",responseObject);
                                               
                                               self.offset = self.offset + 1;
                                               [self setProductListValue:responseObject[@"result"][@"records"]];
                                               [self hasLoadingItem];
                                               [self.refreshControl endRefreshing];
                                               [self.hud hideAnimated:YES afterDelay:0.25f];
                                               
                                           } failure:^(NSError *error) {
                                               SPLOG_DEBUG(@"DATA LIST: %@",error);
                                               
                                               [self hasLoadingItem];
                                               [self.refreshControl endRefreshing];
                                               [Utilities showSimpleAlert:self setTitle:[error localizedDescription]];
                                           }];
        
    } else {
        [self.refreshControl endRefreshing];
        [self.hud hideAnimated:YES afterDelay:0.25f];
    }
}

/**
 Parse API returned values and set to Product object
 */
-(void)setProductListValue: (NSDictionary *)response
{
    if ([response count] != 0) {
        
        if ( !self.isLoadMore ) {
            self.listProducts = [[NSMutableArray alloc] init];
        }
        
        [self.listProducts addObjectsFromArray:[[RecordsSetter shared] setObject: response]];
        self.totalItemLoaded = (int)[self.listProducts count];
        [self.collectionView reloadData];
    } else if (!self.isLoadMore) {
        self.listProducts = [[NSMutableArray alloc] init];
        [self.collectionView reloadData];
    }
}


#pragma mark - NYTPhotos Gallery

- (void) enlargeImage
{
    images = [[NSMutableArray alloc]init];
    [images addObject:API_MEDIA_BASE_URL];
    
    thumbImageView.layer.borderWidth = 1.0;
    [thumbImageView.layer setBorderColor:[UIColor orangeColor].CGColor];
    currentIndex = 0;
    [thumbImageView sd_setImageWithURL:[NSURL URLWithString:[images firstObject]]];
    
    ImageZoomViewer *zoomImageView = [[ImageZoomViewer alloc]initWithBottomCollectionBorderColor:[UIColor orangeColor]];
    [zoomImageView.closeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    zoomImageView.delegate = (id)self;
    CGPoint point = [self.view convertPoint:thumbImageView.frame.origin toView:self.view];
    CGRect animFrame = CGRectMake(point.x, point.y, thumbImageView.frame.size.width, thumbImageView.frame.size.height);
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:animFrame];
    [imgView sd_setImageWithURL:[NSURL URLWithString:[images firstObject]]];
    [zoomImageView showWithPageIndex:currentIndex andImagesCount:images.count withInitialImageView:imgView andAnimType:AnimationTypePop];
}

# pragma Mark - ImageZoomViewer Delegates

- (void)initializeImageviewWithImages:(UIImageView *)imageview withIndexPath:(NSIndexPath *)indexPath withCollection:(int)collectionReference
{
    NSString *urlString = [images objectAtIndex:indexPath.row];
    [imageview sd_setImageWithURL:[NSURL URLWithString:urlString]];
}

- (void)imageIndexOnChange:(NSInteger)index
{
    currentIndex = index;
    [thumbImageView sd_setImageWithURL:[NSURL URLWithString:[images objectAtIndex:currentIndex]]];
}


@end
