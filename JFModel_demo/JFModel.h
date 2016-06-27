//
//  JFModel.h
//  JFModel_demo
//
//  Created by 剑风荡漾 on 16/6/6.
//  Copyright © 2016年 剑风荡漾. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  基础类已写好了NSCoding, NSCopying协议，子类不需要重写
 */

@interface JFModel : NSObject<NSCoding, NSCopying>

/**
 *  数组转model数组
 *
 *  @param dataArray 数组<字典>
 *
 *  @return model数组
 */
+ (NSArray *)getObjectsWithArray:(NSArray *)dataArray;

/**
 *  字典转model
 *
 *  @param dataArray 字典
 *
 *  @return model
 */
+ (instancetype)getObjectWithDictionary:(NSDictionary *)data;

/**
 *  数组转model数组
 *
 *  @param dataArray 数组<字典>
 *
 *  @return model数组
 */
- (NSArray *)getObjectsWithArray:(NSArray *)dataArray;

/**
 *  字典转model
 *
 *  @param dataArray 字典
 *
 *  @return model
 */
- (instancetype)getObjectWithDictionary:(NSDictionary *)data;

@end
