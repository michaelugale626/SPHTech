//
//  NSString+Additions.h
//  BOW
//
//  Created by A101 on 7/21/16.
//  Copyright © 2016 A101. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Additions)

/**
 *  Returns YES if string is a valid email address. E.g. harold.rasco@gmail.com
 */
- (BOOL)isValidEmailAddress;

/**
 *  Returns YES if string contains alpha characters only. E.g. thisIsAString
 */
- (BOOL)containsAlphaCharactersOnly;

/**
 *  Returns YES if string contains numeric characters only. E.g. 123456
 */
- (BOOL)containsNumericCharactersOnly;

/**
 *  Returns YES if string contains alpha or numeric characters only. E.g. 1234, qwerty, qwerty1234
 */
- (BOOL)containsAlphaNumericCharactersOnly;

/**
 *  Returns YES if string contains both alpha and numeric characters. E.g. qwerty1234
 */
- (BOOL)containsBothAlphaAndNumericCharacters;

/**
 *  Return YES if string contains number and + sign only.
 */
- (BOOL)areValidPhoneNumberCharacters;

/**
 *  Returns a new string made by removing new line and whitespace characters from both ends of the string.
 */
- (NSString *)trim;

/**
 *  Returns YES if string contains no characters or containes whitespace characters only.
 */
- (BOOL)isEmpty;

/**
 *  Get the substring from string from a given start index and end index.
 */
- (NSString *)substringFromIndex:(NSUInteger)from toIndex:(NSUInteger)to;


@end
