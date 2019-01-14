//
//  UIColor+More.h
//  Globe Boost
//
//  Created by Michael Ugale on 9/14/15.
//  Copyright (c) 2015 Michael Ugale. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (More)

+ (UIColor *)randomColor;

+ (UIColor *)colorWithHex:(NSString *)hexString;

+ (UIColor*)colorWithHex:(NSString*)hexString alpha:(CGFloat)alpha;

+ (UIColor*)colorWithRGB: (CGFloat)red
                   green: (CGFloat)green
                    blue: (CGFloat)blue;

+ (UIColor*)colorWithStatus: (NSString *)status;

@end
