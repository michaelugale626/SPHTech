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

//Object
#import "RecordsSetter.h"
#import "QuarterSetter.h"

//Categories
#import "UIColor+More.h"

//CustomViews
#import "RecordCollectionViewCell.h"

#define PAGE_LIMIT @"20"

@interface ViewController ()

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
    
    [self.collectionView setAccessibilityIdentifier: @"collectionView"];
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
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    float width = self.view.frame.size.width - 20;
    return CGSizeMake(width, 300);
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

    Reachability *reachability                       = [Reachability reachabilityForInternetConnection];
    [reachability startNotifier];
    
    NetworkStatus status       = [reachability currentReachabilityStatus];
    
    if (!(status == NotReachable)) {
        [[RecordModel sharedManager] deleteAllItem];
        [[YearModel sharedManager] deleteAllItem];
    }
    
    [[Cache shared] clearAllCache];
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
        [dictionary setObject:[NSString stringWithFormat:@"%i", self.offset] forKey:@"offset"];
        
        [[ServerManager sharedManager] getDataList:dictionary
                                           success:^(NSDictionary *responseObject) {
                                               SPLOG_DEBUG(@"DATA LIST: %@",responseObject);
                                              
                                               self.offset = self.offset + [PAGE_LIMIT intValue] + 1;
                                               [self setProductListValue:responseObject[@"result"][@"records"]];
                                               [self hasLoadingItem];
                                               [self.refreshControl endRefreshing];
                                               [self.hud hideAnimated:YES afterDelay:0.25f];
                                               
                                           } failure:^(NSError *error) {
                                               SPLOG_DEBUG(@"DATA LIST: %@",error);
                                               [Utilities showSimpleAlert:self setTitle:[error localizedDescription]];
                                               
                                               if ([error.localizedDescription  isEqual: @"No internet connection.  Please try again."]) {
                                                   [self setListItems];
                                               }
                                               
                                               [self.refreshControl endRefreshing];
                                               [self.hud hideAnimated:YES afterDelay:0.25f];
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
        
        if ([self.listProducts count] == 0) {
            [self setListItems];
        }
        
        self.totalItemLoaded = (int)[self.listProducts count];
        [self.collectionView reloadData];
    } else if (!self.isLoadMore) {
        self.listProducts = [[NSMutableArray alloc] init];
        [self.collectionView reloadData];
    }
}

- (void)setListItems
{
    self.listProducts = [[NSMutableArray alloc] init];
    [self.listProducts addObjectsFromArray:[[YearModel sharedManager] getAllItems]];
    [self.collectionView reloadData];
}

@end
