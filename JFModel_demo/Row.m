//
//  Row.m
//  JFModel_demo
//
//  Created by 剑风荡漾 on 16/6/6.
//  Copyright © 2016年 剑风荡漾. All rights reserved.
//

#import "Row.h"

@implementation Row

//重写setValue:forKey:方法，在系统类执行setValue:forKey:方法之前处理特殊属性
- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        key = @"row_id";
    }
    [super setValue:value forKey:key];
}

@end
