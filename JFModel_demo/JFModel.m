//
//  JFModel.m
//  JFModel_demo
//
//  Created by 剑风荡漾 on 16/6/6.
//  Copyright © 2016年 剑风荡漾. All rights reserved.
//

#import "JFModel.h"
#import <objc/runtime.h>
#import "JFModel+NSLog.h"

@implementation JFModel

#pragma mark - JSON转模型
+ (NSArray *)getObjectsWithArray:(NSArray *)dataArray {
    return [[self alloc] getObjectsWithArray:dataArray];
}

+ (instancetype)getObjectWithDictionary:(NSDictionary *)data {
    return [[self alloc] getObjectWithDictionary:data];
}

- (NSArray *)getObjectsWithArray:(NSArray *)dataArray {
    if (![dataArray isKindOfClass:[NSArray class]]) {
        return nil;
    }
    NSMutableArray* dataArr = [NSMutableArray new];
    for (NSDictionary* dic in dataArray) {
        typeof(self) instance = [self getObjectWithDictionary:dic];
        [dataArr addObject:instance];
    }
    return [dataArr copy];
}

- (instancetype)getObjectWithDictionary:(NSDictionary *)data {
    if (![data isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    typeof(self) instance = [[self class] new];
    [instance setValuesForKeysWithDictionary:data];
    return instance;
}

- (void)setValue:(nullable id)value forUndefinedKey:(NSString *)key {
    //当setValue:forKey:调用时找不到该key就会调用此方法，预防json里有多余的key
}

#pragma mark - 正反序列化
- (instancetype)initWithCoder:(NSCoder *)coder {
    Class cls = [self class];
    while (cls != [NSObject class]) {
        unsigned int count = 0;
        objc_property_t *propertyList = class_copyPropertyList(cls, &count);
        for (int i = 0; i < count; i++) {
            const char *propertyName = property_getName(*(propertyList + i));
            NSString *key = [NSString stringWithUTF8String:propertyName];
            id value = [coder decodeObjectForKey:key];
            if (value) {
                [self setValue:value forKey:key];
            }
        }
        free(propertyList);
        cls = class_getSuperclass(cls);
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    Class cls = [self class];
    while (cls != [NSObject class]) {
        unsigned int count = 0;
        objc_property_t *propertyList = class_copyPropertyList(cls, &count);
        for (int i = 0; i < count; i++) {
            const char *propertyName = property_getName(*(propertyList + i));
            NSString *key = [NSString stringWithUTF8String:propertyName];
            id value = [self valueForKey:key];
            if (value) {
                [coder encodeObject:value forKey:key];
            }
        }
        free(propertyList);
        cls = class_getSuperclass(cls);
    }
}

#pragma mark - copy
- (instancetype)copyWithZone:(NSZone *)zone {
    typeof(self) copyInstance = [[self class] new];
    Class cls = [self class];
    while (cls != [NSObject class]) {
        unsigned int count = 0;
        objc_property_t *propertyList = class_copyPropertyList(cls, &count);
        for (int i = 0; i < count; i++) {
            const char *propertyName = property_getName(*(propertyList + i));
            NSString *key = [NSString stringWithUTF8String:propertyName];
            id value = [self valueForKey:key];
            if (value) {
                [copyInstance setValue:value forKey:key];
            }
        }
        free(propertyList);
        cls = class_getSuperclass(cls);
    }
    return copyInstance;
}

@end
