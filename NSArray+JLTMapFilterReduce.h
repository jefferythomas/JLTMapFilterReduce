//
//  NSArray+JLTMapFilterReduce.h
//  JLTMapFilterReduceTests
//
//  Created by Jeffery Thomas on 3/29/14.
//
//

#import <Foundation/Foundation.h>

@interface NSArray<ObjectType> (JLTMapFilterReduce)
NS_ASSUME_NONNULL_BEGIN

#if !defined(JLT_PREFIX_CATEGORIES)

- (NSArray *)arrayByMapping:(id(^)(ObjectType obj))mapping;

- (NSArray<ObjectType> *)arrayByFiltering:(BOOL(^)(ObjectType obj))filtering;

- (id)objectByReducing:(id(^)(id reducedObject, ObjectType obj))reducing;

- (id)objectByReducing:(id(^)(id reducedObject, ObjectType obj))reducing
         initialObject:(id)initialObject;

- (NSArray<ObjectType> *)arrayByRemovingFirstObject;

#else

- (NSArray *)JLT_arrayByMapping:(id(^)(ObjectType obj))mapping;

- (NSArray<ObjectType> *)JLT_arrayByFiltering:(BOOL(^)(ObjectType obj))filtering;

- (id)JLT_objectByReducing:(id(^)(id reducedObject, ObjectType obj))reducing;

- (id)JLT_objectByReducing:(id(^)(id reducedObject, ObjectType obj))reducing
             initialObject:(id)initialObject;

- (NSArray<ObjectType> *)JLT_arrayByRemovingFirstObject;

#endif

NS_ASSUME_NONNULL_END
@end
