//
//  HZYNewsModel.m
//  LOLProject
//
//  Created by MS on 16-3-9.
//  Copyright (c) 2016年 passionHan. All rights reserved.
//

#import "HZYNewsModel.h"
#import "MJExtension.h"
@implementation HZYNewsModel

/**
 *  使用MJExtension解析的网络数据,如果数据中有系统关键字的字段,转模型的时候需要实现这个方法
 */
- (NSDictionary *)replacedKeyFromPropertyName{
    
    return @{@"newsId":@"id",@"shortIntroduce":@"short"};
}

@end
