//
//  HZYListTitleModel.m
//  HZYListTabBarDemo
//
//  Created by passionHan on 16/3/25.
//  Copyright (c) 2016年 passionHan. All rights reserved.
//

#import "HZYListTitleModel.h"
//字典转模型的三方库(功能超强大)(该项目中用的是低版本的,新版本可以去https://github.com/CoderMJLee/MJExtension)下载,同样很好用
#import "MJExtension.h"
@implementation HZYListTitleModel

+ (NSArray *)listTitleModelGetModelArrayWithPlistName:(NSString *)plistName{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:plistName ofType:nil];
    
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    
    return [self objectArrayWithKeyValuesArray:array];
}

@end
