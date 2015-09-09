//
//  HKPinYinIndexer.m
//  HKProjectBase-Sample
//
//  Created by Harley.xk on 15/9/9.
//  Copyright (c) 2015年 Harley.xk. All rights reserved.
//

#import "HKPinYinIndexer.h"
#import "NSString+HKProjectBase.h"

@interface HKPinYinIndex : NSObject
@property (copy,   nonatomic) NSString *name;
@property (assign, nonatomic) NSInteger sectionNumber;
@property (weak,   nonatomic) id objectToIndex;
@end
@implementation HKPinYinIndex
+ (instancetype)indexForObject:(id)object name:(NSString *)name
{
    HKPinYinIndex *index = [[HKPinYinIndex alloc] init];
    index.objectToIndex = object;
    index.name = name;
    return index;
}
- (NSString *)pinyin
{
    return [_name pingYinFirstLetter];
}
@end

@interface HKPinYinIndexer ()
@property (strong, nonatomic) NSArray *objects;
@property (copy, nonatomic) NSString *(^valueHandler)(id obj);

@property (strong, nonatomic) NSArray *indexedObjects;
@property (strong, nonatomic) NSArray *indexedTiles;
@end

@implementation HKPinYinIndexer

+ (instancetype)indexerForObjects:(NSArray *)objects valueHandler:(NSString *(^)(id obj))valueHandler
{
    return [[self alloc] initForObjects:objects valueHandler:valueHandler];
}

- (instancetype)initForObjects:(NSArray *)objects valueHandler:(NSString *(^)(id obj))valueHandler
{
    self = [super init];
    if (self) {
        self.objects = objects;
        self.valueHandler = valueHandler;
        
        [self indexObjects];
    }
    return self;
}

- (void)indexObjects
{
    NSAssert(self.valueHandler != nil, @"HKPinYinIndexer: Set ValueHandler before index objects!");
    
    // 按索引分组
    UILocalizedIndexedCollation *theCollation = [UILocalizedIndexedCollation currentCollation];
    NSMutableArray *indexArray = [NSMutableArray array];
    
    for (int i = 0; i < self.objects.count; i++) {
        id object = self.objects[i];
        HKPinYinIndex *index = [HKPinYinIndex indexForObject:object name:self.valueHandler(object)];
        NSInteger section = [theCollation sectionForObject:index collationStringSelector:@selector(pinyin)];
        index.sectionNumber = section;
        [indexArray addObject:index];
    }
    
    NSArray *sortedIndexArray = [indexArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [[(HKPinYinIndex *)obj1 name] caseInsensitiveCompare:[(HKPinYinIndex *)obj2 name]];
    }];
    
    NSInteger sectionCount = [[theCollation sectionTitles] count];   //返回的应该是27，是a－z和＃
    
    NSMutableArray *indexedObjects = [NSMutableArray array];
    NSMutableArray *indexedTiles = [NSMutableArray array];
    
    for (NSInteger i = 0; i <= sectionCount; i++) {
        NSMutableArray *sectionArray = [NSMutableArray array];
        for (NSUInteger j = 0; j < [sortedIndexArray count]; j++) {
            HKPinYinIndex *index = [sortedIndexArray objectAtIndex:j];
            if (index.sectionNumber == i) {
                [sectionArray addObject:index.objectToIndex];
            }
        }
        if (sectionArray.count > 0) {
            [indexedObjects addObject:sectionArray];
            [indexedTiles addObject:[[theCollation sectionTitles] objectAtIndex:i]];
        }
    }
    self.indexedObjects = [NSArray arrayWithArray:indexedObjects];
    self.indexedTiles = [NSArray arrayWithArray:indexedTiles];
}

@end
