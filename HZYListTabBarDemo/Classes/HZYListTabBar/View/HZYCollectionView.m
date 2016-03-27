//
//  HZYCollectionView.m
//  HZYListTabBarDemo
//
//  Created by passionHan on 16/3/25.
//  Copyright (c) 2016年 passionHan. All rights reserved.
//

#import "HZYCollectionView.h"

@implementation HZYCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        
        self.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}

@end
