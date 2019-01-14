//
//  NSDateFormatter+StaticInstance.h
//  BOW
//
//  Created by A101 on 7/31/16.
//  Copyright © 2016 A101. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDateFormatter (StaticInstance)

/**
 *  Returns a single instance of NSDateFormatter object, ceating if necessary
 *
 *  @return Single instance of NSDateFormatter object.
 */
+ (NSDateFormatter *)dateFormatter;

@end
