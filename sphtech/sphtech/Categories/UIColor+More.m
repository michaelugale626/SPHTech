//
//  UIColor+More.m
//  Globe Boost
//
//  Created by Michael Ugale on 9/14/15.
//  Copyright (c) 2015 Michael Ugale. All rights reserved.
//

#import "UIColor+More.h"

@implementation UIColor (More)

+ (UIColor *)randomColor
{
    CGFloat comps[3];
    for (int i = 0; i < 3; i++) {
        NSUInteger r = arc4random_uniform(256);
        comps[i] = (CGFloat)r/255.f;
    }
    return [UIColor colorWithRed:comps[0] green:comps[1] blue:comps[2] alpha:1.0];
}

+ (UIColor *)colorWithHex:(NSString *)hexString
{
    return [self colorWithHex:hexString alpha:1.0f];
}

+ (UIColor*)colorWithHex:(NSString*)hexString alpha:(CGFloat)alpha
{
    
    
    if (hexString.length == 6) {
        hexString = [NSString stringWithFormat:@"#%@",hexString];
    }
    if(hexString.length == 7 && [[hexString substringToIndex:1] isEqualToString:@"#"]) {
        NSString *lowerCase = [hexString lowercaseString];
        const char *colorUTF8String = [lowerCase UTF8String];
        int r, g, b;
        sscanf(colorUTF8String, "#%2x%2x%2x", &r, &g, &b);
        return [UIColor colorWithRed:(r / 255.0) green:(g / 255.0) blue:(b / 255.0) alpha:alpha];
    }
    return [UIColor clearColor];
}

+ (UIColor *)colorWithRGB:(CGFloat)red
                    green:(CGFloat)green
                     blue:(CGFloat)blue {
    
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1];
    
}

+ (UIColor *)colorWithStatus:(NSString *)status {
    
//    NSLog(@"Status = %@",status);
    /*
     color -> status codes (status display)
     #ee285a - '17','18','19','53', '21', '52' (declined/rejected/cancelled)
     #765bdb - '11','15', 3015','5015' (for approval/pending/awaiting requirements)
     #f39431 - '12','14','20','22','30','40','50' (for processing/ongoing)
     #7ebe36 - '51' (completed by agent)
     */
    NSString *colorHex = @"";
    
    if ([status isEqualToString:@"17"] ||
        [status isEqualToString:@"18"] ||
        [status isEqualToString:@"19"] ||
        [status isEqualToString:@"53"] ||
        [status isEqualToString:@"21"] ||
        [status isEqualToString:@"52"]) {
        
        colorHex = @"#ee285a";
        
    }else if ([status isEqualToString:@"11"] ||
              [status isEqualToString:@"15"] ||
              [status isEqualToString:@"3015"] ||
              [status isEqualToString:@"5015"]) {
        
        colorHex = @"#765bdb";
    
    }else if ([status isEqualToString:@"12"] ||
              [status isEqualToString:@"14"] ||
              [status isEqualToString:@"20"] ||
              [status isEqualToString:@"22"] ||
              [status isEqualToString:@"30"] ||
              [status isEqualToString:@"40"] ||
              [status isEqualToString:@"50"]) {
        
        colorHex = @"#f39431";
        
    }else if ([status isEqualToString:@"51"]) {
        
        colorHex = @"#7ebe36";
        
    }
    
    
    /*
    if (IS_IOS8_OR_NEWER) {
        if ([status containsString:@"Cancelled"] ||
            [status containsString:@"Declined"]) {
            colorHex = STATUS_COLOR_DECLINE;
        }else if ([status containsString:@"For Processing"] ||
                  [status containsString:@"For processing"] ||
                  [status containsString:@"Awaiting"] ||
                  [status containsString:@"awaiting"]) {
            colorHex = STATUS_COLOR_PROCESSING;
        }else if ([status containsString:@"Approval"] ||
                  [status containsString:@"approval"]) {
            colorHex = STATUS_COLOR_APPROVAL;
        }else {
            colorHex = STATUS_COLOR_COMPLETED;
        }
    } else {
        if ([status rangeOfString:@"Declined"].location != NSNotFound ||
            [status rangeOfString:@"Cancelled"].location != NSNotFound) {
            colorHex = STATUS_COLOR_DECLINE;
        }else if ([status rangeOfString:@"For Processing"].location != NSNotFound ||
                  [status rangeOfString:@"processing"].location != NSNotFound ||
                  [status rangeOfString:@"Awaiting"].location != NSNotFound ||
                  [status rangeOfString:@"awaiting"].location != NSNotFound) {
            colorHex = STATUS_COLOR_PROCESSING;
        }else if ([status rangeOfString:@"Approval"].location != NSNotFound ||
                  [status rangeOfString:@"approval"].location != NSNotFound) {
            colorHex = STATUS_COLOR_APPROVAL;
        }else {
            colorHex = STATUS_COLOR_COMPLETED;
        }
    }*/
    
    return [self colorWithHex:colorHex];
    
}

@end
