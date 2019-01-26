//
//  QuarterSetter.h
//  sphtech
//
//  Created by Michael Ugale on 1/23/19.
//  Copyright © 2019 Michael Ugale. All rights reserved.
//

#import <Foundation/Foundation.h>

//Objects
#import "QuarterManager.h"

//Utilities
#import "Cache.h"

NS_ASSUME_NONNULL_BEGIN

@interface QuarterSetter : NSObject

+ (QuarterSetter *)shared;

- (NSArray *) setObject: (NSDictionary *)response;
- (QuarterManager *) setInfo: (NSDictionary *)rows;

@end

NS_ASSUME_NONNULL_END
