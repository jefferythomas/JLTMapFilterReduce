//
//  NSArray+JLTMapFilterReduce.h
//  JLTMapFilterReduceTests
//
//  Created by Jeffery Thomas on 3/29/14.
//
//

#import <Foundation/Foundation.h>

@interface NSArray<ElementType> (JLTMapFilterReduce)
NS_ASSUME_NONNULL_BEGIN

#if !defined(JLT_PREFIX_CATEGORIES)

- (NSArray *)arrayByMapping:(id(^)(ElementType el))mapping;

- (NSArray<ElementType> *)arrayByFiltering:(BOOL(^)(ElementType el))filtering;

- (id)objectByReducing:(id(^)(id obj, ElementType el))reducing;

- (id)objectByReducing:(id(^)(id obj, ElementType el))reducing initialObject:(id)obj;

- (NSArray<ElementType> *)arrayByRemovingFirstObject;

#else

- (NSArray *)JLT_arrayByMapping:(id(^)(ElementType el))mapping;

- (NSArray<ElementType> *)JLT_arrayByFiltering:(BOOL(^)(ElementType el))filtering;

- (id)JLT_objectByReducing:(id(^)(id obj, ElementType el))reducing;

- (id)JLT_objectByReducing:(id(^)(id obj, ElementType el))reducing initialObject:(id)obj;

- (NSArray<ElementType> *)JLT_arrayByRemovingFirstObject;

#endif

NS_ASSUME_NONNULL_END
@end
