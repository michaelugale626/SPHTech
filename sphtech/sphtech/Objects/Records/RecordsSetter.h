//
//  RecordsSetter.h
//  sphtech
//
//  Created by Michael Ugale on 1/15/19.
//  Copyright © 2019 Michael Ugale. All rights reserved.
//

#import <Foundation/Foundation.h>

//Objects
#import "RecordsManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface RecordsSetter : NSObject
    
+ (RecordsSetter *)shared;

- (NSArray *) setObject: (NSDictionary *)response;
- (RecordsManager *) setInfo: (NSDictionary *)response;
    
@end

NS_ASSUME_NONNULL_END
