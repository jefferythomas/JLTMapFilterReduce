//
//  NSArray+JLTMapFilterReduce.m
//  JLTMapFilterReduceTests
//
//  Created by Jeffery Thomas on 3/29/14.
//
//

#import "NSArray+JLTMapFilterReduce.h"

#if defined(JLT_PREFIX_CATEGORIES)
#define arrayByMapping JLT_arrayByMapping
#define arrayByFiltering JLT_arrayByFiltering
#define objectByReducing JLT_objectByReducing
#define arrayByRemovingFirstObject JLT_arrayByRemovingFirstObject
#endif

@implementation NSArray (JLTMapFilterReduce)

- (NSArray *)arrayByMapping:(id (^)(id))mapping
{
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:[self count]];
    for (id obj in self) {
        id mappedObject = mapping(obj);
        NSAssert(mappedObject, @"mapping must not result in a nil object");
        [result addObject:mappedObject];
    }
    return [result copy];
}

- (NSArray *)arrayByFiltering:(BOOL (^)(id))filtering
{
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:[self count]];
    for (id obj in self) {
        if (filtering(obj)) {
            [result addObject:obj];
        }
    }
    return [result copy];
}

- (id)objectByReducing:(id(^)(id, id))reducing
{
    NSAssert([self count] >= 2, @"Cannot reduce an array with less than 2 objects");

    return [[self arrayByRemovingFirstObject] objectByReducing:reducing initialObject:[self firstObject]];
}

- (id)objectByReducing:(id (^)(id, id))reducing initialObject:(id)obj
{
    NSAssert([self count] >= 1, @"Cannot reduce an array with less than 1 object");

    id result = obj;
    for (id obj in self) {
        result = reducing(result, obj);
    }
    return result;
}

- (NSArray *)arrayByRemovingFirstObject
{
    if ([self count] < 2)
        return [NSArray array];

    NSRange range = NSMakeRange(1, [self count] - 1);
    return [self subarrayWithRange:range];
}

@end
