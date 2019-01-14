//
//  RecordsSetter.m
//  sphtech
//
//  Created by Michael Ugale on 1/15/19.
//  Copyright © 2019 Michael Ugale. All rights reserved.
//

#import "RecordsSetter.h"

//Categories
#import "NSObject+Cast.h"
#import "NSString+Additions.h"

@implementation RecordsSetter
    
static RecordsSetter *shared = nil;
    
+ (instancetype)shared
{
    @synchronized(self) {
        if (!shared) {
            shared = (RecordsSetter *)[[self alloc] init];
        }
    }
    return shared;
}
    
- (RecordsManager *) setInfo: (NSDictionary *)rows
{
    RecordsManager *record      = [[RecordsManager alloc] init];
    record.recordID             = [rows[@"_id"] safeStringValue];
    record.recordVolume         = [rows[@"quarter"] safeStringValue];
    record.recordQuarter        = [rows[@"volume_of_mobile_data"] safeStringValue];
    
    return record;
}

@end
