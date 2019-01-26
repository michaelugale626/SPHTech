//
//  YearSetter.h
//  sphtech
//
//  Created by Michael Ugale on 1/26/19.
//  Copyright © 2019 Michael Ugale. All rights reserved.
//

#import <Foundation/Foundation.h>

//Objects
#import "YearManager.h"

//Utilities
#import "Cache.h"

NS_ASSUME_NONNULL_BEGIN

@interface YearSetter : NSObject

+ (YearSetter *)shared;

- (YearManager *) setInfo: (NSString *)rows;

@end

NS_ASSUME_NONNULL_END
