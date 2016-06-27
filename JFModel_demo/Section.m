//
//  Section.m
//  JFModel_demo
//
//  Created by 剑风荡漾 on 16/6/6.
//  Copyright © 2016年 剑风荡漾. All rights reserved.
//

#import "Section.h"

@implementation Section

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        key = @"section_id";
    }
    if ([key isEqualToString:@"row"]) {
        value = [Row getObjectWithDictionary:value];
    }
    if ([key isEqualToString:@"rowArray"]) {
        value = [Row getObjectsWithArray:value];
    }
    [super setValue:value forKey:key];
}

@end
