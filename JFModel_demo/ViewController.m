//
//  ViewController.m
//  JFModel_demo
//
//  Created by 剑风荡漾 on 16/6/6.
//  Copyright © 2016年 剑风荡漾. All rights reserved.
//

#import "ViewController.h"

#import "Section.h"

//#import "JFModel+NSLog.h"

@interface ViewController ()

@end

@implementation ViewController

- (NSArray *)dataArray {
    //仿JSON
    return  @[@{@"id" : @0,
                @"sectionTitle" : @"第0分区",
                @"rowArray" : @[@{@"id" : @0,
                                  @"rowTitle" : @"第0分区第0行"},
                                @{@"id" : @1,
                                  @"rowTitle" : @"第0分区第1行"},
                                @{@"id" : @2,
                                  @"rowTitle" : @"第0分区第2行"},
                                @{@"id" : @3,
                                  @"rowTitle" : @"第0分区第3行"}],
                @"row" : @{@"id" : @0,
                           @"rowTitle" : @"第0分区单独的行"}
                },
              @{@"id" : @1,
                @"sectionTitle" : @"第1分区",
                @"rowArray" : [NSNull null],
                @"row" : @{@"id" : @1}
                },
              @{@"id" : @2,
                @"sectionTitle" : @"第2分区",
                @"rowArray" : @[@{@"id" : @0,
                                  @"rowTitle" : @"第2分区第0行"},
                                @{@"id" : @1,
                                  @"rowTitle" : @"第2分区第1行"},
                                @{@"id" : @2,
                                  @"rowTitle" : @"第2分区第2行"},
                                @{@"id" : @3,
                                  @"rowTitle" : @"第2分区第3行"},
                                @{@"id" : @4,
                                  @"rowTitle" : @"第2分区第4行"},
                                @{@"id" : @5,
                                  @"rowTitle" : [NSNull null],
                                  @"多余的key" : @"多余的值"}],
                @"row" : [NSNull null]
                }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *model = [Section getObjectsWithArray:self.dataArray];
    
    NSLog(@"model = %@", model);
    
    Section *section = model[1];
    
    NSLog(@"section = %@", section);
    
    Row *row = [section.rowArray lastObject];
    
    NSLog(@"row = %@", row.rowTitle);
    
    Row *row1 = section.row;
    
    NSLog(@"row1 = %@", row1);
    
    Row *row2 = [row1 copy];
    
    NSLog(@"row2 = %@", row2);
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:row2] forKey:@"row"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    Row *row3 = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"row"]];
    
    NSLog(@"row3 = %@", row3);
}

@end
