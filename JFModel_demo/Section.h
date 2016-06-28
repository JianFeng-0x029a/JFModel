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

//属性名和键一样，如不一样需要特殊处理，见.m文件

@property (nonatomic, assign) NSInteger section_id; //属性名和json里的键不同的特殊属性需要处理，section_id对应json里的id

@property (nonatomic, copy) NSString *sectionTitle; //

@property (nonatomic, strong) NSArray *rowArray; //自定义类元素的数组需要处理，系统类元素的数组不处理

@property (nonatomic, strong) Row *row; //自定义类属性需要处理

@end
