//
//  NSDateFormatter+StaticInstance.m
//  BOW
//
//  Created by A101 on 7/31/16.
//  Copyright © 2016 A101. All rights reserved.
//

#import "NSDateFormatter+StaticInstance.h"

@implementation NSDateFormatter (StaticInstance)

+ (NSDateFormatter *)dateFormatter {
	static NSDateFormatter * _instance = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		_instance = [[self alloc] init];
	});
	return _instance;
}

@end
