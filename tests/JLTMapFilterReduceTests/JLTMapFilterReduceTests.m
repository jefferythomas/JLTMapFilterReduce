//
//  JLTMapFilterReduceTests.m
//  JLTMapFilterReduceTests
//
//  Created by Jeffery Thomas on 3/29/14.
//
//

#import <XCTest/XCTest.h>

@interface JLTMapFilterReduceTests : XCTestCase

@end

@implementation JLTMapFilterReduceTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testArrayByMapping
{
    NSArray *actual = [@[@"a", @"b", @"c"] JLT_arrayByMapping:^NSString *(NSString *string) {
        return [string uppercaseString];
    }];
    NSArray *expected = @[@"A", @"B", @"C"];
    XCTAssertEqualObjects(actual, expected, @"Mapping should have uppercased the strings.");
}

- (void)testArrayByFiltering
{
    NSArray *actual = [@[@"a", @"b", @"1"] JLT_arrayByFiltering:^BOOL(NSString *string) {
        return [string rangeOfCharacterFromSet:[NSCharacterSet letterCharacterSet]].location != NSNotFound;
    }];
    NSArray *expected = @[@"a", @"b"];
    XCTAssertEqualObjects(actual, expected, @"Filtering should have removed the 1.");
}

- (void)testArrayByReducing
{
    NSString *actual = [@[@"a", @"b", @"c"] JLT_objectByReducing:^NSString *(NSString *s1, NSString *s2) {
        return [s1 stringByAppendingString:s2];
    }];

    NSString *expected = @"abc";
    XCTAssertEqualObjects(actual, expected, @"Reducing should have returned %@.", expected);
}

- (void)testArrayByReducingInitialObject
{
    NSString *actual = [@[@"a", @"b", @"c"] JLT_objectByReducing:^NSString *(NSString *s1, NSString *s2) {
        return [s1 stringByAppendingString:s2];
    } initialObject:@"+"];

    NSString *expected = @"+abc";
    XCTAssertEqualObjects(actual, expected, @"Reducing should have returned %@.", expected);
}

@end
