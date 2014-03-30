//
//  NSArray+JLTMapFilterReduce.m
//  JLTMapFilterReduceTests
//
//  Created by Jeffery Thomas on 3/29/14.
//
//

#import "NSArray+JLTMapFilterReduce.h"

@implementation NSArray (JLTMapFilterReduce)

- (NSArray *)JLT_arrayByMapping:(id (^)(id))mapping
{
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:[self count]];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        id mappedObject = mapping(obj);
        NSAssert(mappedObject, @"mapping must not result in a nil object");
        [result addObject:mappedObject];
    }];
    return result;
}

- (NSArray *)JLT_arrayByFiltering:(BOOL (^)(id))filtering
{
    NSIndexSet *indexes = [self indexesOfObjectsPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        return filtering(obj);
    }];
    return [self objectsAtIndexes:indexes];
}

- (id)JLT_objectByReducing:(id(^)(id, id))reducing
{
    NSAssert([self count] >= 2, @"Cannot reduce an array with less than 2 objects");

    return [[self JLT_arrayByRemovingFirstObject] JLT_objectByReducing:reducing
                                                         initialObject:[self firstObject]];
}

- (id)JLT_objectByReducing:(id (^)(id, id))reducing initialObject:(id)obj
{
    NSAssert([self count] >= 1, @"Cannot reduce an array with less than 1 object");

    __block id result = obj;
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        result = reducing(result, obj);
    }];
    return result;
}

- (NSArray *)JLT_arrayByRemovingFirstObject
{
    if ([self count] < 2)
        return [NSArray array];

    NSRange range = NSMakeRange(1, [self count] - 1);
    return [self subarrayWithRange:range];
}

@end
