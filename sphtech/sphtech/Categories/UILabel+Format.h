//
//  UILabel+Format.h
//  Globe Boost
//
//  Created by Michael Ugale on 9/18/15.
//  Copyright (c) 2015 Michael Ugale. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Format)

+ (UILabel *)navigationTitleLabelWithFontSize :(float)size
                                      setTitle:(NSString *)title
                                       setFont:(UIFont *)font;

+ (UILabel *)navigationTitleLabel :(float)size
                          setTitle:(NSString *)title;

+ (UILabel *)navigationHeader: (float)width
                        title: (NSString *)title;

+ (UILabel *)formLabelFormat:(UIFont *)setFont
                 setNumLines:(int)numLines;

+ (UILabel *)messageLabel: (UIFont *)setFont
                  message: (NSString *)message
                    frame: (CGRect)frame;


@end
