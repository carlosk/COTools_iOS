//
//  COToolsSampleTests.m
//  COToolsSampleTests
//
//  Created by carlos on 14-1-5.
//  Copyright (c) 2014年 carlosk. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface COToolsSampleTests : XCTestCase

@end

@implementation COToolsSampleTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

//第二个测试
- (void)testExample2{
    NSString *test = @"";
    XCTAssertNotNil(test, @"this is nil");
}

- (void)testNSLog{
    long currentTime = [NSDate date].timeIntervalSince1970;
    int size = 100000;
    for (int i = 0; i < size; i++) {
        NSLog(@"%d",i);
    }
    long cha = [NSDate date].timeIntervalSince1970 - currentTime;
    NSLog(@"时间差为%ld",cha);
}
- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
//    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
}

@end
