//
//  HZYNewsModel.h
//  LOLProject
//
//  Created by MS on 16-3-9.
//  Copyright (c) 2016年 passionHan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HZYNewsModel : NSObject

/**
 *  新闻的id
 */
@property (nonatomic, copy) NSString *newsId;
/**
 *  新闻的title
 */
@property (nonatomic, copy) NSString *title;
/**
 *  新闻的图标
 */
@property (nonatomic, copy) NSString *icon;
/**
 *  新闻的简单介绍
 */
@property (nonatomic, copy) NSString *shortIntroduce;



@end
