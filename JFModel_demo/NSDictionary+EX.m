//
//  NSDictionary+EX.m
//  Shopping
//
//  Created by 剑风荡漾 on 16/3/16.
//  Copyright © 2016年 华人网络. All rights reserved.
//

#import "NSDictionary+EX.h"

@implementation NSDictionary (EX)

#pragma mark - 把字典里的空换成@""
//类型识别:将所有的NSNull类型转化成@""
+ (id)changeType:(id)myObj {
    if ([myObj isKindOfClass:[NSDictionary class]]) {
        return [self nullDic:myObj];
    }
    else if([myObj isKindOfClass:[NSArray class]]) {
        return [self nullArr:myObj];
    }
    else if([myObj isKindOfClass:[NSString class]]) {
        return [self stringToString:myObj];
    }
    else if([myObj isKindOfClass:[NSNull class]]) {
        return [self nullToString];
    }
    else {
        return myObj;
    }
}

//将NSDictionary中的Null类型的项目转化成@""
+ (NSDictionary *)nullDic:(NSDictionary *)myDic {
    
    NSArray *keyArr = [myDic allKeys];
    NSMutableDictionary *resDic = [[NSMutableDictionary alloc]init];
    
    if ([myDic isKindOfClass:[NSNull class]]) {
        return [resDic copy];
    }
    for (int i = 0; i < keyArr.count; i ++) {
        id obj = [myDic objectForKey:keyArr[i]];
        
        obj = [self changeType:obj];
        [resDic setObject:obj forKey:keyArr[i]];
    }
    return [resDic copy];
}

//将NSDictionary中的Null类型的项目转化成@""
+ (NSArray *)nullArr:(NSArray *)myArr {
    NSMutableArray *resArr = [[NSMutableArray alloc] init];
    
    if ([myArr isKindOfClass:[NSNull class]]) {
        return [resArr copy];
    }
    for (int i = 0; i < myArr.count; i ++) {
        id obj = myArr[i];
        
        obj = [self changeType:obj];
        
        [resArr addObject:obj];
    }
    return [resArr copy];
}

//将NSString类型的原路返回
+ (NSString *)stringToString:(NSString *)string {
    return string;
}

//将Null类型的项目转化成@""
+ (NSString *)nullToString {
    return @"";
}

@end
