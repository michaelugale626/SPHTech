//
//  NSObject+Cast.h
//  BOW
//
//  Created by A101 on 7/21/16.
//  Copyright © 2016 A101. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Cast)

/**
 *  Converts NSNumber or NSString objects such as @"true", @"false", @"yes", @"no", @"1", @"0" to BOOL.
 *  Returns NO if the object cannot be converted.
 *
 *  @return The converted value from NSNumber or NSString to BOOL.
 */
- (BOOL)safeBoolValue;

/**
 *  Converts NSString to NSNumber if the string contains a valid number.
 *  Returns nil if the string is not a valid number.
 *
 *  @return The converted value of NSString to NSNumber.
 */
- (NSNumber *)safeNumberValue;

/**
 *  Converts NSNumber to NSString. Returns nil if the object cannot be converted.
 *
 *  @return The converted value of NSNumber to NSString.
 */
- (NSString *)safeStringValue;

/**
 *  Checks if the object is a dictionary.
 *
 *  @return Returns nil if the object's class is not an dictionary.
 */
- (NSDictionary *)safeDictionaryValue;

/**
 *  Checks if the object is a dictionary.
 *
 *  @return Returns nil if the object is not an array.
 */
- (NSArray *)safeArrayValue;

@end
