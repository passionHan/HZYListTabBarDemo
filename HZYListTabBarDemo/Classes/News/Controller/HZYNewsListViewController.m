  //
//  HZYNewsListViewController.m
//  LOLProject
//
//  Created by MS on 16-3-9.
//  Copyright (c) 2016年 passionHan. All rights reserved.
//

#import "HZYNewsListViewController.h"
#import "HZYNewsModel.h"
#import "HZYNewsCell.h"
#import "HZYNewsListViewController.h"
#import "HZYHttpRequest.h"
#import "MJRefresh.h"
#import "AFNetworking.h"
#import "MJExtension.h"

#import "Common.h"
@interface HZYNewsListViewController ()

@property (nonatomic, strong) NSMutableArray *newsArray;
@property (nonatomic, assign) int pageIndex;
@property (nonatomic,assign,getter=isUpdate) BOOL update;

@end

@implementation HZYNewsListViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _newsArray = [NSMutableArray array];
    
    self.tableView.frame = CGRectMake(0, 0, kScreenW,kscreenH - kNavY - kArrowButtonW);
    
    self.tableView.rowHeight = 80;
    
    __weak typeof (self) weakSelf = self;
    
    self.pageIndex = 1;

    //添加下拉刷新
    self.tableView.mj_header = [MJRefreshStateHeader headerWithRefreshingBlock:^{
        
        [weakSelf loadData];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoStateFooter footerWithRefreshingBlock:^{
        
        weakSelf.pageIndex ++;
        [weakSelf loadMoreData];
    }];

    self.update = YES;
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    if (self.update) {
        
        [self.tableView.mj_header beginRefreshing];
        self.update = NO;
    }
    
}

- (void)loadData{
    
    NSString *url = [NSString stringWithFormat:self.urlString,1];
    
    [self loadType:1 withUrlString:url];

    
}

- (void)loadMoreData{
    
    NSString *url = [NSString stringWithFormat:self.urlString,self.pageIndex];
    
    [self loadType:2 withUrlString:url];
}

#pragma mark 网络请求
- (void)loadType:(int)type withUrlString:(NSString *)UrlString{
    
    [HZYHttpRequest GET:UrlString complete:^(AFHTTPRequestOperation *operation, id responseObject, NSError *error) {
        
        if (!error) {
            //成功
            NSDictionary *rootDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            
            //使用MJExtension库实现字典转模型  功能超强大,好多实用功能,喜欢的小伙伴去网上查资料去吧！！
            NSArray *news = [HZYNewsModel objectArrayWithKeyValuesArray:rootDict[@"result"]];
            
            if (type == 1) {
                self.newsArray = [news mutableCopy];
                [self.tableView.mj_header endRefreshing];
                [self.tableView reloadData];
                
            }else if(type == 2){
                
                [self.newsArray addObjectsFromArray:news];
                [self.tableView.mj_footer endRefreshing];
                [self.tableView reloadData];
            }
            
        }else{
            //失败
            
        }
    }];

    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.newsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HZYNewsCell *cell = [HZYNewsCell cellWithTableView:tableView];
    
    cell.news = self.newsArray[indexPath.row];
    
    return cell;
}


@end
