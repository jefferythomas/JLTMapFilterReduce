//
//  JLTMapFilterReduceRunner.m
//  JLTMapFilterReduceTests
//
//  Created by Jeffery Thomas on 3/30/14.
//
//

#import "JLTMapFilterReduceRunner.h"
#import "NSArray+JLTMapFilterReduce.h"
#import <mach/mach.h>

@implementation JLTMapFilterReduceRunner

- (void)runAll
{
    uint64_t start;
    uint64_t stop;
    size_t i;
    NSArray *sample = @[@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9"];
    NSNumberFormatter *formatter = [NSNumberFormatter new];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];

    start = mach_absolute_time();
    for (i = 0; i < 1000; ++i) {
        [sample JLT_arrayByMapping:^id(id obj) {
            return obj;
        }];
    }
    stop = mach_absolute_time();
    NSLog(@"JLT_arrayByMapping: %@ time units", [formatter stringFromNumber:@(stop-start)]);

    start = mach_absolute_time();
    for (i = 0; i < 1000; ++i) {
        [sample JLT_arrayByFiltering:^BOOL(id obj) {
            return YES;
        }];
    }
    stop = mach_absolute_time();
    NSLog(@"JLT_arrayByFiltering: %@ time units", [formatter stringFromNumber:@(stop-start)]);

    start = mach_absolute_time();
    for (i = 0; i < 1000; ++i) {
        [sample JLT_objectByReducing:^id(id obj1, id obj2) {
            return obj1;
        } initialObject:@"-"];
    }
    stop = mach_absolute_time();
    NSLog(@"JLT_objectByReducing:initialObject: %@ time units", [formatter stringFromNumber:@(stop-start)]);
}

@end
