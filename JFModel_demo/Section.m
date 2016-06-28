//
//  Section.m
//  JFModel_demo
//
//  Created by 剑风荡漾 on 16/6/6.
//  Copyright © 2016年 剑风荡漾. All rights reserved.
//

#import "Section.h"

@implementation Section

//重写setValue:forKey:方法，在NSObject类执行setValue:forKey:方法之前处理特殊属性
- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        //此处处理特殊的key，把json里特殊的key转换为你模型的key
        key = @"section_id";
    }
    if ([key isEqualToString:@"row"]) {
        //此处value是个字典，需要转为模型
        value = [Row getObjectWithDictionary:value];
    }
    if ([key isEqualToString:@"rowArray"]) {
        //此处value是个元素为字典的数组，需要转换为元素为模型的数组
        value = [Row getObjectsWithArray:value];
    }
    //处理完特殊属性，让NSObject类继续执行setValue:forKey:方法
    [super setValue:value forKey:key];
}

@end
