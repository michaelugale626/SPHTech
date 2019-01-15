//
//  sphtechRestTests.m
//  sphtechRestTests
//
//  Created by Michael Ugale on 1/15/19.
//  Copyright © 2019 Michael Ugale. All rights reserved.
//

#import <XCTest/XCTest.h>

//Manager
#import "ServerManager.h"

@interface sphtechRestTests : XCTestCase
    
@property NSMutableDictionary *dictionary;

@end

@implementation sphtechRestTests

- (void)setUp {
    [super setUp];
    
    _dictionary = [[NSMutableDictionary alloc] init];
    [_dictionary setObject:@"10"            forKey:@"limit"];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testGetDataList {
    
    [[ServerManager sharedManager] getDataList:_dictionary
                                       success:^(NSDictionary *responseObject) {
                                           
                                           if ([responseObject isKindOfClass:[NSHTTPURLResponse class]]) {
                                               NSInteger statusCode = [(NSHTTPURLResponse *) responseObject statusCode];
                                               XCTAssertEqual(statusCode, 200, @"status code was not 200; was %ld", (long)statusCode);
                                           }
                                           
                                           XCTAssert(responseObject, @"data nil");
                                           
                                       } failure:^(NSError *error) {
                                           XCTAssertNil(error, @"dataTaskWithURL error %@", error);
                                       }];
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
