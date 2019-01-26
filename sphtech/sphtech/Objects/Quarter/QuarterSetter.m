//
//  QuarterSetter.m
//  sphtech
//
//  Created by Michael Ugale on 1/23/19.
//  Copyright © 2019 Michael Ugale. All rights reserved.
//

#import "QuarterSetter.h"

//Categories
#import "NSObject+Cast.h"
#import "NSString+Additions.h"

//Objects
#import "RecordsSetter.h"

//Model
#import "RecordModel.h"
#import "YearModel.h"

@implementation QuarterSetter

static QuarterSetter *shared = nil;

+ (instancetype)shared
{
    @synchronized(self) {
        if (!shared) {
            shared = (QuarterSetter *)[[self alloc] init];
        }
    }
    return shared;
}

- (NSArray *) setObject: (NSDictionary *)response
{
    NSMutableArray *list = [[NSMutableArray alloc] init];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    NSMutableArray *qList = [[NSMutableArray alloc] initWithArray:[[Cache shared] getCachedObjectForKey:DATA_INFORMATION]];
    
    for (NSDictionary *rows in response) {
        
        NSMutableArray *mylist = [[NSMutableArray alloc] init];
        NSString *item = [rows[@"quarter"] safeStringValue];
        NSString *temp = [item substringToIndex:[item length]-1];
        
        if ([[dict allKeys] containsObject:temp]) {
            mylist = [dict objectForKey:temp];
        }
        
        [mylist addObject:[[RecordsSetter shared] setInfo: rows]];
        [dict setObject:mylist forKey:temp];
        
        [qList addObject:@{ temp : [[RecordsSetter shared] setInfo: rows]}];
    }
    
    for (NSString *key in dict) {
        
        QuarterManager *quarter     = [[QuarterManager alloc] init];
        quarter.quarterID           = key;
        quarter.quarterList         = [dict objectForKey:key];
        
        [list addObject:quarter];
        
    }
    
    NSArray *sortedKeys = [dict.allKeys sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"self" ascending:YES]]];
    [[Cache shared] setCachedObject:sortedKeys forKey:DATA_LIST_KEY];
    [[Cache shared] setCachedObject:qList forKey:DATA_INFORMATION];
    
    
    return [[Cache shared] getCachedObjectForKey:DATA_LIST_KEY];
}

- (QuarterManager *) setInfo: (NSDictionary *)rows
{
    QuarterManager *quarter     = [[QuarterManager alloc] init];
    quarter.quarterID           = [rows[@"quarter"] safeStringValue];
    
    return quarter;
}

@end
