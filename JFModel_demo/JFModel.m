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

#pragma mark - KVC
- (void)setValue:(nullable id)value forUndefinedKey:(NSString *)key {
    //当setValue:forKey:调用时找不到该key就会调用此方法，预防json里有多余的key
}

- (nullable id)valueForUndefinedKey:(NSString *)key {
    //当valueForKey:调用时找不到该key就会调用此方法，预防崩溃
    return nil;
}

- (void)setValue:(id)value forKey:(NSString *)key {
    objc_property_t property = class_getProperty([self class], [key cStringUsingEncoding:NSUTF8StringEncoding]);
    if (property) {
        NSString *propertyAttributes = [NSString stringWithUTF8String:property_getAttributes(property)];
        Class propertyType = NSClassFromString([propertyAttributes cutFromString:@"\"" toString:@"\""]);
        if([propertyType isCustomClass]) {
            if ([propertyType respondsToSelector:@selector(getObjectWithDictionary:)]) {
                value = [propertyType getObjectWithDictionary:value];
            }
        }
        if ([propertyAttributes containsString:@"Stype_"]) {
            Class elementType = NSClassFromString([propertyAttributes cutFromString:@"Stype_" toString:@":"]);
            if ([elementType respondsToSelector:@selector(getObjectsWithArray:)]) {
                value = [elementType getObjectsWithArray:value];
            }
        }
        if ([propertyAttributes containsString:@"Sswap_"]) {
            key = [propertyAttributes cutFromString:@"Sswap_" toString:@":"];
        }
    }
    [super setValue:value forKey:key];
}

#pragma mark - 正反序列化
- (instancetype)initWithCoder:(NSCoder *)coder {
    Class selfType = [self class];
    while (selfType != [NSObject class]) {
        unsigned int count = 0;
        objc_property_t *propertyList = class_copyPropertyList(selfType, &count);
        for (int i = 0; i < count; i++) {
            const char *propertyName = property_getName(*(propertyList + i));
            NSString *key = [NSString stringWithUTF8String:propertyName];
            id value = [coder decodeObjectForKey:key];
            if (value) {
                [self setValue:value forKey:key];
            }
        }
        free(propertyList);
        selfType = class_getSuperclass(selfType);
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    Class selfType = [self class];
    while (selfType != [NSObject class]) {
        unsigned int count = 0;
        objc_property_t *propertyList = class_copyPropertyList(selfType, &count);
        for (int i = 0; i < count; i++) {
            const char *propertyName = property_getName(*(propertyList + i));
            NSString *key = [NSString stringWithUTF8String:propertyName];
            id value = [self valueForKey:key];
            if (value) {
                [coder encodeObject:value forKey:key];
            }
        }
        free(propertyList);
        selfType = class_getSuperclass(selfType);
    }
}

#pragma mark - copy
- (instancetype)copyWithZone:(NSZone *)zone {
    typeof(self) copyInstance = [[self class] new];
    Class selfType = [self class];
    while (selfType != [NSObject class]) {
        unsigned int count = 0;
        objc_property_t *propertyList = class_copyPropertyList(selfType, &count);
        for (int i = 0; i < count; i++) {
            const char *propertyName = property_getName(*(propertyList + i));
            NSString *key = [NSString stringWithUTF8String:propertyName];
            id value = [self valueForKey:key];
            if (value) {
                [copyInstance setValue:value forKey:key];
            }
        }
        free(propertyList);
        selfType = class_getSuperclass(selfType);
    }
    return copyInstance;
}

@end

@implementation NSObject (isCustomClass)

+ (BOOL)isCustomClass {
    NSBundle *bundle = [NSBundle bundleForClass:self];
    return bundle == [NSBundle mainBundle];
}

@end

@implementation NSString (cut)

- (NSString *)cutFromString:(NSString *)fromString toString:(NSString *)toString {
    if ([self containsString:fromString] &&[self containsString:toString]) {
        return  [[self componentsSeparatedByString:fromString][1] componentsSeparatedByString:toString][0];
    }
    return nil;
}

@end
