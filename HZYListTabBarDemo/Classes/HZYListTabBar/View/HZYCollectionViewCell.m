//
//  HZYCollectionViewCell.m
//  HZYListTabBarDemo
//
//  Created by passionHan on 16/3/25.
//  Copyright (c) 2016年 passionHan. All rights reserved.
//

#import "HZYCollectionViewCell.h"

#import "HZYNewsListViewController.h"

@interface HZYCollectionViewCell()

@property (nonatomic ,strong) HZYNewsListViewController *listViewController;

@end

@implementation HZYCollectionViewCell

#pragma mark --懒加载
- (HZYNewsListViewController *)listViewController{
    
    if (_listViewController == nil) {
        
        _listViewController = [[HZYNewsListViewController alloc] init];
    }
    
    return _listViewController;
}

- (void)setUrlString:(NSString *)urlString{
    
    _urlString = urlString;
}

- (void)setTitle:(NSString *)title{
    
    _title = title;
    
    self.listViewController.titleName = title;
    
    self.listViewController.urlString = _urlString;
    
    self.listViewController.tableView.frame = self.bounds;
    
    //将显示新闻界面的tableView添加到collectionView的cell中
    [self.contentView addSubview:self.listViewController.tableView];
}

@end
