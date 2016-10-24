//
//  URLQueryTests.m
//  XL_Demos
//
//  Created by zhouxiaolu on 16/9/21.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "NSURL+XL_URLQuery.h"

@interface URLQueryTests : XCTestCase

@end

@implementation URLQueryTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}
- (void)testUrlFilterToken
{
    XCTAssertEqualObjects([NSURL urlFilterToken:@"http://baidu.com?token=1234555"], [NSURL URLWithString:@"http://baidu.com"]);
}
- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end