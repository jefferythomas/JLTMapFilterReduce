//
//  JLTMapFilterReduceRunner.h
//  JLTMapFilterReduceTests
//
//  Created by Jeffery Thomas on 3/30/14.
//
//

#import <Foundation/Foundation.h>

@interface JLTMapFilterReduceRunner : NSObject

@property (nonatomic) NSNumberFormatter *numberFormatter;

- (NSTimeInterval)durationOfBlock:(void(^)(void))block;
- (NSString *)formattedNumberWithDurationOfBlock:(void(^)(void))block;
- (void)runAll;

@end
