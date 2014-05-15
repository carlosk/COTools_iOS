//
//  JsonParseTest.m
//  COToolsSample
//
//  Created by carlos on 14-1-22.
//  Copyright (c) 2014年 carlosk. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "User.h"
@interface JsonParseTest : XCTestCase

@end

@implementation JsonParseTest

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)test1{
    NSArray *arr = @[@1, @2, @3];
    NSNumber *average = [arr valueForKeyPath:@"@max.self"]; // 2
    
    NSLog(@"test1=%@",average);
}

- (void)testJsonParse{
    NSString *jsonContent = @"{\"identity\":\"\",\"age\":12,\"name\":\"carlos\",\"aaddress\":\"123\",\"createDate\":\"2014-10-10 12:23:32\",\"imageIds\":[1,2]}";
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[jsonContent dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
    User *user = [[User alloc]initWithJson:json];
//    NSLog(@"user = %@",user);
    XCTAssertEqual(user.age, 12, @"int is not parse");
    XCTAssertEqualObjects(user.name, @"carlos", @"NSString is not parse");
    XCTAssertEqualObjects(user.address, @"123", @"NSString is not empty");
    XCTAssertNotNil(user.createDate, @"必须有值");
    NSArray *imageIds = user.imageIds;
    int imageId2 = [imageIds[1] integerValue] ;
    XCTAssertTrue(imageId2  == 2, @"id必须为2");
}


@end
