//
//  NSString+Additions.m
//  BOW
//
//  Created by A101 on 7/21/16.
//  Copyright © 2016 A101. All rights reserved.
//

#import "NSString+Additions.h"

@implementation NSString (Additions)

- (BOOL)isValidEmailAddress {
	NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}";
	NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
	
	return [emailTest evaluateWithObject:self];
}

- (BOOL)containsAlphaCharactersOnly {
	if (self.length == 0) {
		return NO;
	}
	
	NSCharacterSet *characterSet = [[NSCharacterSet letterCharacterSet] invertedSet];
	
	if ([self rangeOfCharacterFromSet:characterSet].location != NSNotFound) {
		return NO;
	}
	return YES;
}

- (BOOL)containsNumericCharactersOnly {
	if (self.length == 0) {
		return NO;
	}
	
	NSCharacterSet *characterSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
	
	if ([self rangeOfCharacterFromSet:characterSet].location != NSNotFound) {
		return NO;
	}
	return YES;
}

- (BOOL)containsAlphaNumericCharactersOnly {
	if (self.length == 0) {
		return NO;
	}
	
	NSCharacterSet *characterSet = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
	
	if ([self rangeOfCharacterFromSet:characterSet].location != NSNotFound) {
		return NO;
	}
	return YES;
}

- (BOOL)containsBothAlphaAndNumericCharacters {
	NSCharacterSet *decimalCharacterSet = [NSCharacterSet decimalDigitCharacterSet];
	NSCharacterSet *alphaCharacterSet   = [NSCharacterSet letterCharacterSet];
	NSCharacterSet *illegalCharacterSet = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
	
	if ([self rangeOfCharacterFromSet:decimalCharacterSet].location != NSNotFound &&
		[self rangeOfCharacterFromSet:alphaCharacterSet].location != NSNotFound &&
		[self rangeOfCharacterFromSet:illegalCharacterSet].location == NSNotFound) {
		return YES;
	}
	return NO;
}

- (BOOL)areValidPhoneNumberCharacters {
	NSMutableCharacterSet *characterSet = [NSMutableCharacterSet decimalDigitCharacterSet];
	[characterSet addCharactersInString:@"+"];
	[characterSet invert];
	if ([self rangeOfCharacterFromSet:characterSet].location != NSNotFound) {
		return NO;
	}
	return YES;
}

- (NSString *)trim {
	NSCharacterSet *characterSet = [NSCharacterSet whitespaceAndNewlineCharacterSet];
	return [self stringByTrimmingCharactersInSet:characterSet];
}

- (BOOL)isEmpty {
	return [self trim].length == 0;
}

- (NSString *)substringFromIndex:(NSUInteger)from toIndex:(NSUInteger)to {
	NSRange range = NSMakeRange(from, to);
	return [self substringWithRange:range];
}

@end
