//
//  BaseViewController.m
//  sphtech
//
//  Created by Michael Ugale on 1/15/19.
//  Copyright © 2019 Michael Ugale. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()
    
@property (strong, nonatomic) UIImageView *backgroundImageView;
@property (strong, nonatomic) UIImageView *backgroundLayerImageView;
@property (strong, nonatomic) UITapGestureRecognizer *dismissKeyboardTapGesture;

@end

@implementation BaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self updateNavigationBarStyle];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
}

- (void)dealloc
{
    _dismissKeyboardTapGesture.delegate = nil;
}

#pragma mark - Private Methods

- (void)updateNavigationBarStyle
{
    UIImage *emptyImage = [[UIImage alloc] init];
    
    NSDictionary *attributes = @{NSFontAttributeName : FONT_UI_Text_Light(16),
                                 NSForegroundColorAttributeName : [self navigationBarTintColor]};
    self.navigationController.navigationBar.titleTextAttributes = attributes;
    self.navigationController.navigationBar.tintColor = [self navigationBarTintColor];
    self.navigationController.navigationBar.shadowImage = emptyImage;
    
    [self.navigationController.navigationBar setBackgroundImage:emptyImage
                                                  forBarMetrics:UIBarMetricsDefault];
    
    
    self.navigationController.navigationBar.barTintColor    = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor       = [UIColor colorWithHex:THEME_COLOR_BLACK];
    self.navigationController.navigationBar.translucent     = NO;
}

#pragma mark - Public Methods

- (void)setNavigationTitle:(NSString*)title
{
    UIFont *font    = FONT_UI_Text_Light(14);
    
    UILabel *label                  = [UILabel navigationTitleLabelWithFontSize:self.navigationController.view.frame.size.width
                                                                       setTitle:title
                                                                        setFont:font];
    label.textColor                 = [UIColor colorWithHex:THEME_COLOR_BLACK];
    self.navigationItem.titleView   = label;
}

- (void)removeNavigationButtons
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationItem.leftBarButtonItem   = nil;
    self.navigationItem.rightBarButtonItem  = nil;
    self.navigationItem.hidesBackButton     = YES;
}

- (UIEdgeInsets)backgroundImageInsets
{
    return UIEdgeInsetsZero;
}

- (UIEdgeInsets)backgroundImageLayerInsets
{
    return UIEdgeInsetsZero;
}

- (UIColor *)navigationBarTintColor
{
    return [UIColor whiteColor];
}

#pragma mark - Action Methods

- (void)backButton: (id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
