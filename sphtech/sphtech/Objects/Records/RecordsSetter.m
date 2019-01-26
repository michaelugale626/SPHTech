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

//Model
#import "YearModel.h"
#import "RecordModel.h"

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

- (NSArray *) setObject: (NSDictionary *)response
{
    NSMutableArray *list = [[NSMutableArray alloc] init];
    
    for (NSDictionary *rows in response) {
        RecordsManager *record = [self setInfo:rows];
        [self insertRecord:record];
        
        NSString *temp = [record.recordQuarter substringToIndex:[record.recordQuarter length]-1];
        if (![[YearModel sharedManager] checkIfExist:temp]) {
            [[YearModel sharedManager] insertItem:temp];
            [list addObject:[[YearSetter shared] setInfo:temp]];
        }
    }
    
    return list;
}
    
- (RecordsManager *) setInfo: (NSDictionary *)rows
{
    RecordsManager *record      = [[RecordsManager alloc] init];
    record.recordID             = [rows[@"_id"] safeStringValue];
    record.recordVolume         = [rows[@"volume_of_mobile_data"] safeStringValue];
    record.recordQuarter        = [rows[@"quarter"] safeStringValue];
    
    return record;
}

- (void) insertRecord: (RecordsManager *) record
{
    
    if (![[RecordModel sharedManager] checkIfExist:record.recordQuarter]) {
        [[RecordModel sharedManager] insertItem:record];
    }
    
}

@end
