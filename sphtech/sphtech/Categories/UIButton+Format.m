//
//  UIButton+Format.m
//  Globe Boost
//
//  Created by Michael Ugale on 9/14/15.
//  Copyright (c) 2015 Michael Ugale. All rights reserved.
//

#import "UIButton+Format.h"

//Resources
#import "Constant.h"

//Categories
#import "UIColor+More.h"

@implementation UIButton (Format)

+ (UIButton *)setNavFilterButton
{
    UIButton *setbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [setbutton setFrame:CGRectMake(0, 0, 25, 25)];
    
    /*
     SET THEME COLOR
     */
    UIImage *image = [[UIImage imageNamed:@"ic_filter"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [setbutton setImage:image forState:UIControlStateNormal];
    [setbutton setImage:image forState:UIControlStateHighlighted];
    [setbutton setTintColor:[UIColor colorWithHex:THEME_COLOR_BLACK]];
    
    return setbutton;
}

+ (UIButton *)setNavDrawerButton
{
    UIButton *setbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [setbutton setFrame:CGRectMake(0, 0, 25, 25)];
    
    /*
     SET THEME COLOR
     */
    UIImage *image = [[UIImage imageNamed:@"menuIcon"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [setbutton setImage:image forState:UIControlStateNormal];
    [setbutton setImage:image forState:UIControlStateHighlighted];
    [setbutton setTintColor:[UIColor colorWithHex:THEME_COLOR_BLACK]];
    
    return setbutton;
}

+ (UIButton *)setNavSearchButton
{
    UIButton *setbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [setbutton setFrame:CGRectMake(0, 0, 25, 25)];
    
    /*
     SET THEME COLOR
     */
    UIImage *image = [[UIImage imageNamed:@"ic_magnify_white"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [setbutton setImage:image forState:UIControlStateNormal];
    [setbutton setImage:image forState:UIControlStateHighlighted];
    [setbutton setTintColor:[UIColor whiteColor]];
    
    return setbutton;
}

+ (UIButton *) setNavBackButton
{
    UIButton *setbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [setbutton setFrame:CGRectMake(0, 0, 30, 30)];
    
    /*
     SET THEME COLOR
     */
    UIImage *image = [[UIImage imageNamed:@"icn_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [setbutton setImage:image forState:UIControlStateNormal];
    [setbutton setImage:image forState:UIControlStateHighlighted];
    [setbutton setTintColor:[UIColor colorWithHex:THEME_COLOR_DARK_GRAY]];
    
    return setbutton;
}

+ (UIButton *)setNavBackButtonArabic
{
    UIButton *setbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [setbutton setFrame:CGRectMake(0, 0, 25, 25)];
    [setbutton setImage:[UIImage imageNamed:@"backIcon"] forState:UIControlStateNormal];
    [setbutton setImage:[UIImage imageNamed:@"backIcon"] forState:UIControlStateHighlighted];
    setbutton.transform = CGAffineTransformMakeScale(-1, 1);
    
    return setbutton;
}

+ (UIButton *) setNavTitleLeftButton :(NSString *)setTitle
{
    UIButton *setbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [setbutton setFrame:CGRectMake(0, 0,250, 30)];
    [setbutton setTitle:setTitle forState:UIControlStateNormal];
    setbutton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [setbutton setBackgroundColor:[UIColor clearColor]];
    return setbutton;
}

+ (UIButton *)buttonWithRoundedCornersSize:(float)cornerRadius setButton:(UIButton *)button
{
    button.layer.cornerRadius    = cornerRadius;
    button.clipsToBounds         = YES;
    button.layer.borderWidth     = 3.0f;
    button.layer.borderColor     = [UIColor whiteColor].CGColor;
    
    return button;
}

+ (UIButton *)buttonWithRoundedCornersWithColor:(float)cornerRadius
                                      setButton:(UIButton *)button
                                  setbuttonColor:(UIColor *)buttonColor
{
    
    button.layer.cornerRadius    = cornerRadius;
    button.clipsToBounds         = YES;
    button.layer.borderWidth     = 1.0f;
    button.layer.borderColor     = buttonColor.CGColor;
    
    return button;
}
@end
