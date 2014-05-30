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

- (NSTimeInterval)durationOfBlock:(void(^)(void))block
{
    uint64_t start = mach_absolute_time();
    block();
    uint64_t stop = mach_absolute_time();
    return [self durationFromMachAbsoluteTimeDuration:stop - start];
}

- (NSString *)formattedNumberWithDurationOfBlock:(void(^)(void))block
{
    return [self.numberFormatter stringFromNumber:@([self durationOfBlock:block])];
}

- (void)runAll
{
    NSArray *sample = @[@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9"];

    NSLog(@"arrayByMapping: %@ seconds", [self formattedNumberWithDurationOfBlock:^{
        for (size_t i = 0; i < 1000; ++i) {
            [sample arrayByMapping:^id(id obj) {
                return obj;
            }];
        }
    }]);

    NSLog(@"arrayByFiltering: %@ seconds", [self formattedNumberWithDurationOfBlock:^{
        for (size_t i = 0; i < 1000; ++i) {
            [sample arrayByFiltering:^BOOL(id obj) {
                return YES;
            }];
        }
    }]);

    NSLog(@"objectByReducing: %@ seconds", [self formattedNumberWithDurationOfBlock:^{
        for (size_t i = 0; i < 1000; ++i) {
            [sample objectByReducing:^id(id obj1, id obj2) {
                return obj1;
            } initialObject:@"-"];
        }
    }]);
}

#pragma mark Private

- (NSTimeInterval)durationFromMachAbsoluteTimeDuration:(uint64_t)duration
{
    mach_timebase_info_data_t info;
    mach_timebase_info(&info);

    NSTimeInterval time = (NSTimeInterval)info.numer / (NSTimeInterval)info.denom * (NSTimeInterval)1E-9;
    return duration * time;
}

- (NSNumberFormatter *)numberFormatter
{
    if (!_numberFormatter) {
        NSNumberFormatter *formatter = [NSNumberFormatter new];
        [formatter setNumberStyle:NSNumberFormatterScientificStyle];
        _numberFormatter = formatter;
    }
    return _numberFormatter;
}

@end
