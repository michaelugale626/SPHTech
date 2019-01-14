//
//  UIButton+Format.h
//  Globe Boost
//
//  Created by Michael Ugale on 9/14/15.
//  Copyright (c) 2015 Michael Ugale. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Format)

+ (UIButton *)setNavFilterButton;
+ (UIButton *)setNavDrawerButton;
+ (UIButton *)setNavSearchButton;
+ (UIButton *)setNavBackButton;
+ (UIButton *)setNavBackButtonArabic;
+ (UIButton *)setNavTitleLeftButton :(NSString *)setTitle;

+ (UIButton *)buttonWithRoundedCornersSize:(float)cornerRadius setButton:(UIButton *)button;
+ (UIButton *)buttonWithRoundedCornersWithColor:(float)cornerRadius
                                      setButton:(UIButton *)button
                                  setbuttonColor:(UIColor *)buttonColor;

@end
