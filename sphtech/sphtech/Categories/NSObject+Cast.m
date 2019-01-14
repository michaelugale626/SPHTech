//
//  NSObject+Cast.m
//  BOW
//
//  Created by A101 on 7/21/16.
//  Copyright © 2016 A101. All rights reserved.
//

#import "NSObject+Cast.h"

@implementation NSObject (Cast)

- (BOOL)safeBoolValue {
	if ([self isKindOfClass:[NSString class]]) {
		NSString *stringSelf = (NSString *)self;
		NSString *lowercaseString = [stringSelf lowercaseString];
		if ([lowercaseString isEqualToString:@"true"] ||
			[lowercaseString isEqualToString:@"yes"] ||
			[lowercaseString isEqualToString:@"1"]) {
			return YES;
		}
	} else if ([self isKindOfClass:[NSNumber class]]) {
		NSNumber *numberSelf = (NSNumber *)self;
		return [numberSelf boolValue];
	}
	return NO;
}

- (NSNumber *)safeNumberValue {
	if ([self isKindOfClass:[NSString class]]) {
		static NSNumberFormatter *numberFormatter = nil;
		if (numberFormatter == nil) {
			numberFormatter = [[NSNumberFormatter alloc] init];
			numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
		}
		NSString *stringSelf = (NSString *)self;
		return [numberFormatter numberFromString:stringSelf];
	} else if ([self isKindOfClass:[NSNumber class]]) {
		return (NSNumber *)self;
	}
	return nil;
}

- (NSString *)safeStringValue {
	if ([self isKindOfClass:[NSNumber class]]) {
		NSNumber *numberSelf = (NSNumber *)self;
		return [numberSelf stringValue];
	} else if ([self isKindOfClass:[NSString class]]) {
		return (NSString *)self;
	}
	return nil;
}

- (NSDictionary *)safeDictionaryValue {
	if ([self isKindOfClass:[NSDictionary class]]) {
		return (NSDictionary *)self;
	}
	return nil;
}

- (NSArray *)safeArrayValue {
	if ([self isKindOfClass:[NSArray class]]) {
		return (NSArray *)self;
	}
	return nil;
}

@end
