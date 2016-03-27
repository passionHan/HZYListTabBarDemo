//
//  HZYCollectionViewCell.h
//  HZYListTabBarDemo
//
//  Created by passionHan on 16/3/25.
//  Copyright (c) 2016年 passionHan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HZYCollectionViewCell : UICollectionViewCell

/**
 *  每个界面的URL
 */
@property (nonatomic ,copy) NSString *urlString;
/**
 *  每个界面的标题
 */
@property (nonatomic ,copy) NSString *title;



@end
