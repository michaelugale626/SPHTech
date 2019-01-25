//
//  Cache.m
//  sphtech
//
//  Created by Michael Ugale on 1/14/19.
//  Copyright © 2019 Michael Ugale. All rights reserved.
//

#import "Cache.h"

@implementation Cache
    
NSString *const ACCESS_TOKEN                                 = @"com.data_access_token.www";
NSString *const DATA_LIST_KEY                                 = @"com.data_list_keys.www";
NSString *const DATA_INFORMATION                              = @"com.data_information.www";

static Cache *shared = nil;
    
+ (instancetype)shared
    {
        @synchronized(self) {
            if (!shared) {
                shared = (Cache *)[[self alloc] init];
            }
        }
        return shared;
    }
    
- (instancetype)init
    {
        self = [super init];
        if (self) {
            
        }
        return self;
    }
    
- (void)setCachedObject:(id)object forKey:(NSString *)key
    {
        NSUserDefaults *defaults    = [NSUserDefaults standardUserDefaults];
        NSData *data                = [NSKeyedArchiver archivedDataWithRootObject:object];
        [defaults setObject:data forKey:key];
        [defaults synchronize];
    }
    
- (id)getCachedObjectForKey:(NSString *)key
    {
        NSUserDefaults *defaults    = [NSUserDefaults standardUserDefaults];
        NSData *data                = [defaults objectForKey:key];
        
        if (data == nil) {
            return nil;
        }
        
        @try {
            id obj = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            return obj;
        }
        @catch (NSException *exception) {
            if ([exception.name isEqualToString:@"NSInvalidUnarchiveOperationException"] ||
                [exception.name isEqualToString:@"NSInvalidArchiveOperationException"]) {
                [self removeCachedObjectWithKey:key];
            }
            return nil;
        }
        @finally {
            
        }
    }
    
- (void)removeCachedObjectWithKey:(NSString *)key
    {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults removeObjectForKey:key];
        [defaults synchronize];
    }
    
- (void)clearAllCache
    {
        [[Cache shared] removeCachedObjectWithKey:ACCESS_TOKEN];
        [[Cache shared] removeCachedObjectWithKey:DATA_LIST_KEY];
        [[Cache shared] removeCachedObjectWithKey:DATA_INFORMATION];
    }

@end
