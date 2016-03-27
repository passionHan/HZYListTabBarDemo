//
//  HZYNewsCell.h
//  LOLProject
//
//  Created by MS on 16-3-10.
//  Copyright (c) 2016年 passionHan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HZYNewsModel;
@interface HZYNewsCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) HZYNewsModel *news;


@end
