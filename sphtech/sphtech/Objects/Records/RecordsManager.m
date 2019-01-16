//
//  RecordsManager.m
//  sphtech
//
//  Created by Michael Ugale on 1/15/19.
//  Copyright © 2019 Michael Ugale. All rights reserved.
//

#import "RecordsManager.h"

@implementation RecordsManager
    
#pragma mark - Encoder
    
- (void)encodeWithCoder:(NSCoder *)coder
    {
        [coder encodeObject:_recordID                               forKey:@"recordID"];
        [coder encodeObject:_recordQuarter                          forKey:@"recordQuarter"];
        [coder encodeObject:_recordVolume                           forKey:@"recordVolume"];
    }

- (instancetype)initWithCoder:(NSCoder *)coder
    {
        self = [super init];
        if (self) {
            _recordID                               = [coder decodeObjectForKey:@"recordID"];
            _recordQuarter                          = [coder decodeObjectForKey:@"recordQuarter"];
            _recordVolume                           = [coder decodeObjectForKey:@"recordVolume"];
        }
        return self;
    }

@end
