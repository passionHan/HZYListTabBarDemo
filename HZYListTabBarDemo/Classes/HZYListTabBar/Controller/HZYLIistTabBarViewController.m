//
//  HZYLIistTabBarViewController.m
//  HZYListTabBarDemo
//
//  Created by MS on 16-3-11.
//  Copyright (c) 2016年 passionHan. All rights reserved.
//

#import "HZYLIistTabBarViewController.h"
#import "Common.h"

//需要在这里导入您要展示新闻界面的控制器 然后修改与其相对应的名字
#import "HZYNewsListViewController.h"

@interface HZYLIistTabBarViewController ()<HZYListTabBarDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) HZYListTabBar *listTabBar;
/**
 *  装有ViewController的ScrollView
 */
@property (nonatomic, weak) UIScrollView *contentScrollView;
/**
 *  当前viewController的索引
 */
@property (nonatomic, assign)NSInteger currentIndex;
/**
 *  用来存放listtabBar上item的标题和item对应界面请求数据的URL
 */
@property (nonatomic, strong) NSArray *newsUrlList;


@end

@implementation HZYLIistTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /**
     写在前面:
          笔者初学iOS的时候,对于新闻客户端中常见的滑动翻页查看资讯的功能就挺感兴趣的,就想着去实现它,在实现的过程中也是遇到了一系列的问题,之后再网上也查了许多资料,也有类似于这样功能的三方库,三方库能实现界面的要求,但是要在加载每个item界面的网络数据时却是程序一启动全部都去加载,这样程序的性能是很不好的,这也是我比较困惑的地方,后来通过我的研究,找到了相对好的解决方法,所以写了此Demo,希望能帮助到初学iOS有这方面困惑的人员!
     *  注:
            1.此Demo主要目的是实现类似于新闻客户端中可以滑动查看不同种类新闻资讯的功能.
            2.每个item首次加载都是自动刷新资讯,程序开始运行只是加载第一个item资讯.
            3.程序中用到的item标题和接口都在NewsUrl.plist文件中.
            4.程序还有很多功能没有实现,代码有的还可以封装,笔者有时间了再去完善!
            5.此Demo注释详细,适合新手观看,希望能给初学iOS开发的人员带来帮助!
     */
    
    self.navigationItem.title = @"新闻";
    [self initView];
}
/**
 *  加载plist中的数据
 */
- (NSArray *)newsUrlList{
    
    if (_newsUrlList == nil) {
        
        _newsUrlList = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"NewsUrl.plist" ofType:nil]];
    }
    
    return _newsUrlList;
}

/**
 *  初始化试图控制器
 */
- (void)initView{
    
    //设置控制器是否自动调整他内部scrollView内边距（一定要设置为NO,否则在导航条显示的时候,scroolView的第一个控制器显示的tableView会有偏差）
    self.automaticallyAdjustsScrollViewInsets = NO;
    //设置能够滑动的listTabBar
    self.listTabBar = [[HZYListTabBar alloc] initWithFrame:CGRectMake(0, kNavY, kScreenSize.width, kListTabBarH)];
    self.listTabBar.delegate = self;
    
    //这句代码调用了HZYListTabBar的 setitemsTitle 方法  会到HZYListTabBar里设置数据
    self.listTabBar.itemsTitle = self.newsUrlList;
    [self.view addSubview:self.listTabBar];
    
    //添加能滚动显示ViewController的ScrollView
    CGFloat scroolY = CGRectGetMaxY(self.listTabBar.frame);
    CGFloat scroolH = kScreenSize.height - scroolY;
    
    UIScrollView *contentScroolView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, scroolY, kScreenSize.width, scroolH)];

    contentScroolView.showsHorizontalScrollIndicator = NO;
    contentScroolView.delegate = self;
    
    //设置scrollView能够分页
    contentScroolView.pagingEnabled = YES;
    //关闭scrollView的弹簧效果
    contentScroolView.bounces = NO;
    contentScroolView.backgroundColor = [UIColor whiteColor];
    
    self.contentScrollView = contentScroolView;
    [self.view addSubview:self.contentScrollView];
    
    //添加子控制器
    [self addChildViewControllers];
    
    self.contentScrollView.contentSize = CGSizeMake(kScreenSize.width * self.childViewControllers.count,0);
    
    //添加默认显示的控制器
    HZYNewsListViewController *newsVc = [self.childViewControllers firstObject];
    newsVc.view.frame = self.contentScrollView.bounds;
    [self.contentScrollView addSubview:newsVc.view];
}

/**
 *  添加子控制器
 */
- (void)addChildViewControllers{
    
    for (int i = 0; i < self.newsUrlList.count; i ++) {
        
        HZYNewsListViewController*vc = [[HZYNewsListViewController alloc] init];
        vc.title = self.newsUrlList[i][kPlistTitle];
        vc.urlString = self.newsUrlList[i][kPlistUrlString];
        
        [self addChildViewController:vc];
    }
}

#pragma mark -- scrollView 的代理方法 --

/**
 *  scrollView 滚动时调用
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    //当scrollView滑动超过了屏幕一半时就让它进入下一个界面
    self.currentIndex = scrollView.contentOffset.x / kScreenSize.width + 0.5;
   
}

/**
 *  scrollView 动画滚动结束时调用  只有通过代码（设置contentOfset）使scrollView停止滚动才会调用
 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{

    //这句代码调用了HZYListTabBar的 setCurrentItemIndex 方法  会到HZYListTabBar里设置数据
    self.listTabBar.currentItemIndex = self.currentIndex;
    
    HZYNewsListViewController *vc = self.childViewControllers[self.currentIndex];
    //如果当前试图控制器的View已经加载过了,就直接返回,不会重新加载了（这句代码很重要）
    if (vc.view.superview) {
        return;
    }
    vc.view.frame = scrollView.bounds;
    [self.contentScrollView addSubview:vc.view];
}

/**
 *  这个是由手势导致scrollView滚动结束调用（减速）(不实现这个代理方法用手滑scrollView并不会加载控制器)
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

#pragma mark -- HZYListTabBar的代理方法 --
- (void)listTabBar:(HZYListTabBar *)listTabBar didSelectedItemIndex:(NSInteger)index{
    
    [self.contentScrollView setContentOffset:CGPointMake(index * kScreenSize.width, 0) animated:YES];
}

- (void)listTabBarDidClickedArrowButton:(HZYListTabBar *)listTabBar{
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"抱歉,显示当前关注的item和添加更多item暂时还没有实现,等有时间了再去跟新！" delegate:nil  cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
