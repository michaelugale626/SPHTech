//
//  UILabel+Format.m
//  Globe Boost
//
//  Created by Michael Ugale on 9/18/15.
//  Copyright (c) 2015 Michael Ugale. All rights reserved.
//

#import "UILabel+Format.h"

//Categories
#import "UIColor+More.h"

//Resources
#import "Constant.h"

@implementation UILabel (Format)

+ (UILabel *)navigationTitleLabelWithFontSize :(float)size
                                      setTitle:(NSString *)title
                                       setFont:(UIFont *)font
{
    CGRect frame                = CGRectMake(0.0f, 0.0f, size/2, 30.0f);
    UILabel *titleLabel         = [[UILabel alloc] initWithFrame:frame];
    titleLabel.textAlignment    = NSTextAlignmentCenter;
    titleLabel.textColor        = [UIColor whiteColor];
    titleLabel.font             = font;
    titleLabel.text             = title;
    
    return titleLabel;
}

+ (UILabel *)navigationTitleLabel :(float)size setTitle:(NSString *)title
{
    CGRect frame                = CGRectMake(0.0f, 0.0f, size/2, 30.0f);
    UILabel *titleLabel         = [[UILabel alloc] initWithFrame:frame];
    titleLabel.textAlignment    = NSTextAlignmentCenter;
    titleLabel.textColor        = [UIColor whiteColor];
    titleLabel.font             = FONT_UI_Text_Light(18.0f);
    titleLabel.text             = title;
    
    return titleLabel;
}

+ (UILabel *)navigationHeader:(float)width
                        title:(NSString *)title {
    
    CGRect frame                = CGRectMake(0.0f, 0.0f, width, 30.0f);
    UILabel *titleLabel         = [[UILabel alloc] initWithFrame:frame];
    titleLabel.textAlignment    = NSTextAlignmentCenter;
    titleLabel.textColor        = [UIColor colorWithHex:THEME_COLOR_BLACK];
    titleLabel.font             = FONT_UI_Text_Light(16);
    titleLabel.text             = title;
    
    return titleLabel;
    
    
}

+ (UILabel *)formLabelFormat:(UIFont *)setFont
                 setNumLines:(int)numLines
{
    UILabel *label          = [[UILabel alloc] init];
    label.backgroundColor   = [UIColor clearColor];
    label.font              = setFont;
    label.textAlignment     = NSTextAlignmentLeft;
    label.textColor         = [UIColor colorWithHex:THEME_COLOR_GRAY];
    label.lineBreakMode     = NSLineBreakByWordWrapping;
    label.numberOfLines     = numLines;
    return label;
}

+ (UILabel *)messageLabel:(UIFont *)setFont
                  message:(NSString *)message
                    frame:(CGRect)frame{
    
    UILabel *label = [[UILabel alloc]init];
    [label setText:message];
    [label setNumberOfLines:99];
    
    CGSize original = CGSizeMake(frame.size.width, frame.size.height);
    
    CGSize size = [message sizeWithAttributes:
                   @{NSFontAttributeName:
                         setFont}];
    size = [message boundingRectWithSize:original options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: setFont} context:nil].size;
    
    CGRect newFrame = frame;
    newFrame.size.height = size.height;
    label.frame = newFrame;
    
    
    return label;
    
}

@end
