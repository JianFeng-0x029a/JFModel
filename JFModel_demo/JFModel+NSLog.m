//
//  JFModel+log.m
//  JFModel_demo
//
//  Created by 剑风荡漾 on 16/6/6.
//  Copyright © 2016年 剑风荡漾. All rights reserved.
//

#import "JFModel+NSLog.h"
#import <objc/runtime.h>

@implementation JFModel (NSLog)

- (NSString *)descriptionWithLocale:(nullable id)locale {
    
    __block int i = [objc_getAssociatedObject(self, @selector(descriptionWithLocale:)) intValue];
    
    NSMutableString *t = [NSMutableString new];
    for (int j = 0; j <= i; j++) {
        [t appendString:@"\t"];
    }
    
    NSMutableString *desc = [[NSString stringWithFormat:@"%@{\n", [self debugDescription]] mutableCopy];
    Class cls = [self class];
    while (cls != [NSObject class]) {
        unsigned int count = 0;
        objc_property_t *propList = class_copyPropertyList(cls, &count);
        for (int j = 0; j < count; j++) {
            const char *propertyName = property_getName(*(propList + j));
            NSString *key = [NSString stringWithUTF8String:propertyName];
            id value = [self valueForKey:key];
            if ([value isKindOfClass:NSClassFromString(@"NSDictionary")] || [value isKindOfClass:NSClassFromString(@"NSArray")] || [value isKindOfClass:NSClassFromString(@"JFModel")]) {
                objc_setAssociatedObject(value, @selector(descriptionWithLocale:), @(i+1), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }
            [desc appendFormat:@"%@%@ = %@;\n", t, key, value];
        }
        free(propList);
        cls = class_getSuperclass(cls);
    }
    
    [t deleteCharactersInRange:NSMakeRange(t.length - @"\t".length, @"\t".length)];
    
    [desc appendString:[NSString stringWithFormat:@"%@}", t]];
    
    objc_setAssociatedObject(self, @selector(descriptionWithLocale:), @(0), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return desc;
}

@end

@implementation NSDictionary (NSLog)

- (NSString *)descriptionWithLocale:(id)locale {
    
    __block int i = [objc_getAssociatedObject(self, @selector(descriptionWithLocale:)) intValue];
    
    NSMutableString *t = [NSMutableString new];
    for (int j = 0; j <= i; j++) {
        [t appendString:@"\t"];
    }
    
    NSMutableString *desc = [[NSString stringWithFormat:@"{\n"] mutableCopy];
    
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if ([obj isKindOfClass:NSClassFromString(@"NSDictionary")] || [obj isKindOfClass:NSClassFromString(@"NSArray")] || [obj isKindOfClass:NSClassFromString(@"JFModel")]) {
            objc_setAssociatedObject(obj, @selector(descriptionWithLocale:), @(i+1), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
        [desc appendFormat:@"%@%@ = %@;\n", t, key, obj];
    }];
    
    [t deleteCharactersInRange:NSMakeRange(t.length - @"\t".length, @"\t".length)];
    
    [desc appendString:[NSString stringWithFormat:@"%@}", t]];
    
    objc_setAssociatedObject(self, @selector(descriptionWithLocale:), @(0), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    return desc;
}

@end

@implementation NSArray (NSLog)

- (NSString *)descriptionWithLocale:(id)locale {
    
    __block int i = [objc_getAssociatedObject(self, @selector(descriptionWithLocale:)) intValue];
    
    NSMutableString *t = [NSMutableString new];
    for (int j = 0; j <= i; j++) {
        [t appendString:@"\t"];
    }
    NSMutableString *desc = [[NSString stringWithFormat:@"(\n"] mutableCopy];
    
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:NSClassFromString(@"NSDictionary")] || [obj isKindOfClass:NSClassFromString(@"NSArray")] || [obj isKindOfClass:NSClassFromString(@"JFModel")]) {
            objc_setAssociatedObject(obj, @selector(descriptionWithLocale:), @(i+1), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
        [desc appendFormat:@"%@%@,\n", t, obj];
    }];
    
    [t deleteCharactersInRange:NSMakeRange(t.length - @"\t".length, @"\t".length)];
    [desc appendString:[NSString stringWithFormat:@"%@)", t]];
    
    objc_setAssociatedObject(self, @selector(descriptionWithLocale:), @(0), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    return desc;
}

@end

