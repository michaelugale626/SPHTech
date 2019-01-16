//
//  BaseViewController.h
//  sphtech
//
//  Created by Michael Ugale on 1/15/19.
//  Copyright © 2019 Michael Ugale. All rights reserved.
//

#import <UIKit/UIKit.h>

//Categories
#import "UIColor+More.h"
#import "UILabel+Format.h"
#import "UIButton+Format.h"
#import "NSObject+Cast.h"
#import "NSString+Additions.h"

//Vendor
#import <MBProgressHUD/MBProgressHUD.h>
#import <Masonry/Masonry.h>
#import <SDVersion/SDVersion.h>

@interface BaseViewController : UIViewController
    
@property (weak, nonatomic) IBOutlet UIBarButtonItem *leftBarButtonItem;
    
- (UIColor *)navigationBarTintColor;
    
- (void)setNavigationTitle:(NSString*)title;
- (void)removeNavigationButtons;

@end
