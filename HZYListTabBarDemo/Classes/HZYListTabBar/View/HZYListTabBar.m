//
//  HZYListTabBar.m
//  HZYListTabBarDemo
//
//  Created by MS on 16-3-11.
//  Copyright (c) 2016年 passionHan. All rights reserved.
//

#import "HZYListTabBar.h"
#import "Common.h"
@interface HZYListTabBar()

/**
 *  用于显示所有的item
 */
@property (nonatomic, weak) UIScrollView *listTabBar;
/**
 *  选中item的背景View
 */
@property (nonatomic, weak) UIView *btnBgView;
/**
 *  当前选中的item按钮
 */
@property (nonatomic, weak) UIButton *currentSelectedBtn;
/**
 *  箭头按钮
 */
@property (nonatomic, weak) UIButton *arrowButton;
/**
 *  装有所有item的数组
 */
@property (nonatomic, strong) NSMutableArray *items;

@end

@implementation HZYListTabBar


- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        _items = [NSMutableArray array];
        
        self.backgroundColor = [UIColor colorWithRed:245/255.0 green:236/255.0 blue:236/255.0 alpha:1.0];
        
        [self initView];
    }
    
    return self;
}

- (void)initView{
    
    //设置箭头按钮
    UIButton *arrowButton = [UIButton buttonWithType:UIButtonTypeCustom];
    arrowButton.frame = CGRectMake(kScreenSize.width - kArrowButtonW, 0, kArrowButtonW, kArrowButtonW);
    [arrowButton setImage:[UIImage imageNamed:klistTabBarResourcesPath(@"arrow")] forState:UIControlStateNormal];
    [arrowButton setImage:[UIImage imageNamed:klistTabBarResourcesPath(@"arrow")] forState:UIControlStateHighlighted];
    arrowButton.backgroundColor = [UIColor lightGrayColor];
    [arrowButton addTarget:self action:@selector(arrowButtonDidClick) forControlEvents:UIControlEventTouchUpInside];
    self.arrowButton = arrowButton;
    [self addSubview:self.arrowButton];
    
    //设置滚动的listTabBar
    UIScrollView *listTabBar = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width - kArrowButtonW,kArrowButtonW)];
    listTabBar.showsHorizontalScrollIndicator = NO;
    self.listTabBar = listTabBar;
    [self addSubview:self.listTabBar];

}
/**
 *  重写属性currentItemIndex的setter方法
 */
- (void)setCurrentItemIndex:(NSInteger)currentItemIndex{
    
    _currentItemIndex = currentItemIndex;
    
    UIButton *button = _items[currentItemIndex];
    
    [self settingSelectedButton:button];
    
    CGFloat listTabBatF = kScreenSize.width - kArrowButtonW;
    
    CGFloat rightButtonMaxX = button.frame.origin.x + button.frame.size.width;
    
    if (rightButtonMaxX > listTabBatF - 20)
    {
        CGFloat offsetX = rightButtonMaxX - listTabBatF;
        if (_currentItemIndex < self.itemsTitle.count - 1)
        {
            offsetX = offsetX + 60.0;
        }
        
        [self.listTabBar setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    }
    else
    {
        [self.listTabBar setContentOffset:CGPointMake(0, 0) animated:YES];
    }
}

/**
 *  重写属性setItemsTitle的setter方法(在控制器中调用itemsTitle的setter方法是就会来到这里->self.itemsTitle=)
 */
- (void)setItemsTitle:(NSArray *)itemsTitle{
    
    _itemsTitle = itemsTitle;
    
    CGFloat buttonX = 0;
    CGFloat buttonW = 0;
    for (int i = 0; i < itemsTitle.count; i ++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];

        //取得item的标题
        NSString *title = _itemsTitle[i][kPlistTitle];
        buttonW = [self sizeWithFont:klistTabBarItemsFontSize text:title].width;
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        button.frame = CGRectMake(10 + buttonX, 0, buttonW , kArrowButtonW);
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(itemsDidClick:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i == 0) {
            
            button.selected = YES;
        }
        [self.listTabBar addSubview:button];

        [self.items addObject:button];
        
        buttonX += buttonW + kItemsPadding;
    }
    
    self.listTabBar.contentSize = CGSizeMake(buttonX + buttonW + kItemsPadding, 0);
    
    
}

/**
 *  item按钮的点击事件
 */
- (void)itemsDidClick:(UIButton *)button{
    
    [self settingSelectedButton:button];
    
    NSInteger index = [_items indexOfObject:button];
    
    if ([self.delegate respondsToSelector:@selector(listTabBar:didSelectedItemIndex:)]) {
        
        [self.delegate listTabBar:self didSelectedItemIndex:index];
    }
}


/**
 *  设置button为选中状态（主要是改变选中按钮的title颜色）
 */
- (void)settingSelectedButton:(UIButton *)button{
    
    for (UIView *view in self.listTabBar.subviews) {
        
        if ([view isKindOfClass:[UIButton class]]) {
            
            ((UIButton *)view).selected = NO;
        }
    }
    button.selected = YES;
}

/**
 *  根据文字自适应宽度和高度
 *
 *  @param fontSize 计算的文字的大小
 *  @param text     要计算的文字
 */
- (CGSize)sizeWithFont:(NSInteger)fontSize text:(NSString *)text{
    
    NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
    
   return [text boundingRectWithSize:CGSizeMake(MAXFLOAT, kArrowButtonW) options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
    
}
/**
 *  点击箭头按钮触发的事件
 */
- (void)arrowButtonDidClick{
    
    if ([self.delegate respondsToSelector:@selector(listTabBarDidClickedArrowButton:)]) {
        
        [self.delegate listTabBarDidClickedArrowButton:self];
    }
}




@end
