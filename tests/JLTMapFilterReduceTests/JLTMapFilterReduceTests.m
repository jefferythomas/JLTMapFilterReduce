//
//  JLTMapFilterReduceTests.m
//  JLTMapFilterReduceTests
//
//  Created by Jeffery Thomas on 3/29/14.
//
//

#import <XCTest/XCTest.h>
#import "NSArray+JLTMapFilterReduce.h"

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
    NSArray<NSString *> *actual = [@[@"a", @"b", @"c"] arrayByMapping:^id _Nonnull(NSString * _Nonnull obj) {
        return obj.uppercaseString;
    }];

    NSArray<NSString *> *expected = @[@"A", @"B", @"C"];
    XCTAssertEqualObjects(actual, expected, @"Mapping should have uppercased the strings.");
}

- (void)testArrayByFiltering
{
    NSArray<NSString *> *actual = [@[@"a", @"b", @"1"] arrayByFiltering:^BOOL(NSString * _Nonnull obj) {
        return [obj rangeOfCharacterFromSet:[NSCharacterSet letterCharacterSet]].location != NSNotFound;
    }];

    NSArray<NSString *> *expected = @[@"a", @"b"];
    XCTAssertEqualObjects(actual, expected, @"Filtering should have removed the 1.");
}

- (void)testArrayByReducing
{
    NSString *actual =
    [@[@"a", @"b", @"c"] objectByReducing:^id _Nonnull(id _Nonnull reducedObject, NSString * _Nonnull obj) {
        return [reducedObject stringByAppendingString:obj];
    }];

    NSString *expected = @"abc";
    XCTAssertEqualObjects(actual, expected, @"Reducing should have returned %@.", expected);
}

- (void)testArrayByReducingInitialObject
{
    NSString *actual =
    [@[@"a", @"b", @"c"] objectByReducing:^id _Nonnull(id _Nonnull reducedObject, NSString * _Nonnull obj) {
        return [reducedObject stringByAppendingString:obj];
    } initialObject:@"+"];

    NSString *expected = @"+abc";
    XCTAssertEqualObjects(actual, expected, @"Reducing should have returned %@.", expected);
}

@end
