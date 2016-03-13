//
//  Common.h
//  HZYListTabBarDemo
//
//  Created by MS on 16-3-11.
//  Copyright (c) 2016年 passionHan. All rights reserved.
//

#ifndef HZYListTabBarDemo_Common_h
#define HZYListTabBarDemo_Common_h

#import "HZYListTabBar.h"

#define HZYColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0]

//屏幕的SIZE
#define kScreenSize [UIScreen mainScreen].bounds.size

//箭头按钮的宽度
#define kArrowButtonW 30.0

//listTabBar 的高度
#define kListTabBarH  kArrowButtonW

//导航栏的Y
#define kNavY 64.0

//plist文件中的title
#define kPlistTitle @"title"

//plist文件中的urlString
#define kPlistUrlString @"urlString"

//listTabBarItem字体的颜色
#define klistTabBarItemsFontSize 13 

//listtabBarItem的间距
#define kItemsPadding 30.0

#define klistTabBarBundleName           @"HZYResource.bundle"

#define klistTabBarResourcesPath(file) [klistTabBarBundleName stringByAppendingPathComponent:file]


#endif
