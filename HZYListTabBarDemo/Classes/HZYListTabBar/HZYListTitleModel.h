//
//  HZYListTitleModel.h
//  HZYListTabBarDemo
//
//  Created by passionHan on 16/3/25.
//  Copyright (c) 2016年 passionHan. All rights reserved.
//

#import <Foundation/Foundation.h>

//装有给界面的标题和对应的URL的模型

@interface HZYListTitleModel : NSObject

@property (nonatomic ,copy) NSString *urlString;

@property (nonatomic ,copy) NSString *title;

+ (NSArray *)listTitleModelGetModelArrayWithPlistName:(NSString *)plistName;

@end
