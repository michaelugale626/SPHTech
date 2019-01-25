//
//  QuarterManager.m
//  sphtech
//
//  Created by Michael Ugale on 1/23/19.
//  Copyright © 2019 Michael Ugale. All rights reserved.
//

#import "QuarterManager.h"

@implementation QuarterManager

#pragma mark - Encoder

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:_quarterID                            forKey:@"quarterID"];
    [coder encodeObject:_quarterList                          forKey:@"quarterList"];
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        _quarterID                              = [coder decodeObjectForKey:@"quarterID"];
        _quarterList                            = [coder decodeObjectForKey:@"quarterList"];
    }
    return self;
}

@end
