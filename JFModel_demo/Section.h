//
//  Section.h
//  JFModel_demo
//
//  Created by 剑风荡漾 on 16/6/6.
//  Copyright © 2016年 剑风荡漾. All rights reserved.
//

#import "JFModel.h"
#import "Row.h"

@interface Section : JFModel

//属性名和json里的键不同的特殊属性需要处理，section_id对应json里的id
@property (nonatomic, assign, swapKey(id)) NSInteger section_id;

@property (nonatomic, copy) NSString *sectionTitle;

//自定义类元素的数组需要处理，系统类元素的数组不处理, Row为元素类型
@property (nonatomic, strong, arrayType(Row)) NSArray *rowArray;

@property (nonatomic, strong) Row *row;

@end
