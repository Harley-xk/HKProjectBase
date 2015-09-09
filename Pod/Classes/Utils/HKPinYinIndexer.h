//
//  HKPinYinIndexer.h
//  HKProjectBase-Sample
//
//  Created by Harley.xk on 15/9/9.
//  Copyright (c) 2015年 Harley.xk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HKPinYinIndexer : NSObject

/**
 *  初始化索引器
 *
 *  @param objects 需要索引的数组，可以是任意类型的对象
 *  @param valueHandler 索引依据的对象属性，在block中返回对应的值。
 */
+ (instancetype)indexerForObjects:(NSArray *)objects valueHandler:(NSString *(^)(id obj))valueHandler;

/**
 *  索引完成的对象数组的数组，按照索引顺序排列
 */
@property (strong, nonatomic, readonly) NSArray *indexedObjects;

/**
 *  首字母索引数组
 */
@property (strong, nonatomic, readonly) NSArray *indexedTiles;

@end
