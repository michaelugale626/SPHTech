//
//  YearManager.m
//  sphtech
//
//  Created by Michael Ugale on 1/26/19.
//  Copyright © 2019 Michael Ugale. All rights reserved.
//

#import "YearManager.h"

@implementation YearManager

#pragma mark - Encoder

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:_yearID                        forKey:@"yearID"];
    [coder encodeObject:_year                          forKey:@"year"];
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        _yearID                             = [coder decodeObjectForKey:@"yearID"];
        _year                               = [coder decodeObjectForKey:@"year"];
    }
    return self;
}

@end
