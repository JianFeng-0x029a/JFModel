//
//  JFModel.h
//  JFModel_demo
//
//  Created by 剑风荡漾 on 16/6/6.
//  Copyright © 2016年 剑风荡漾. All rights reserved.
//

#pragma mark - 打印日志
#ifdef DEBUG
/** DEBUG 模式下打印日志,当前行 */
#   define DLog(fmt, ...) NSLog((@"\n%s\nline = %d\n" fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif

/** 处理交换key */
#define swapKey(key)        setter=swap_##key:
/** 处理元素为自定义类的数组 */
#define arrayType(type)     setter=type_##type:

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

@interface NSObject (isCustomClass)
/**
 *  是否是自定义类
 *
 *  @return 是否是自定义类
 */
+ (BOOL)isCustomClass;

@end

@interface NSString (cut)
/**
 *  截取字符串
 *
 *  @param fromString  开始的字符串
 *  @param toString      结束的字符串
 *
 *  @return 新的字符串（不包含fromString和toString）
 */
- (NSString *)cutFromString:(NSString *)fromString toString:(NSString *)toString;

@end
