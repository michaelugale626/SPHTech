//
//  YearSetter.m
//  sphtech
//
//  Created by Michael Ugale on 1/26/19.
//  Copyright © 2019 Michael Ugale. All rights reserved.
//

#import "YearSetter.h"

//Categories
#import "NSObject+Cast.h"
#import "NSString+Additions.h"

@implementation YearSetter

static YearSetter *shared = nil;

+ (instancetype)shared
{
    @synchronized(self) {
        if (!shared) {
            shared = (YearSetter *)[[self alloc] init];
        }
    }
    return shared;
}

- (YearManager *) setInfo: (NSString *)rows
{
    YearManager *year           = [[YearManager alloc] init];
    year.yearID                 = [rows safeStringValue];
    year.year                   = [rows safeStringValue];
    
    return year;
}

@end
