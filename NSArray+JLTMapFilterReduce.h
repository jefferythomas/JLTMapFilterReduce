//
//  NSArray+JLTMapFilterReduce.h
//  JLTMapFilterReduceTests
//
//  Created by Jeffery Thomas on 3/29/14.
//
//

#import <Foundation/Foundation.h>

@interface NSArray (JLTMapFilterReduce)

- (NSArray *)JLT_arrayByMapping:(id(^)(id obj))mapping;

- (NSArray *)JLT_arrayByFiltering:(BOOL(^)(id obj))filtering;

- (id)JLT_objectByReducing:(id(^)(id obj1, id obj2))reducing;

- (id)JLT_objectByReducing:(id(^)(id obj1, id obj2))reducing initialObject:(id)obj;

- (NSArray *)JLT_arrayByRemovingFirstObject;

@end
