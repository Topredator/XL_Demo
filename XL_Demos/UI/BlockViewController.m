//
//  BlockViewController.m
//  XL_Demos
//
//  Created by zhouxiaolu on 16/8/29.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import "BlockViewController.h"

static int static_global = 1;
int global = 2;

static const NSInteger tagNum = 1000;

@interface BlockViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *myScroll;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) UIPageControl *pageControll;
@end

@implementation BlockViewController
#pragma mark - init method -
#pragma mark - life cycle method -
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.view addSubview:self.myScroll];
    [_myScroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self customMethod];
    
    [self xl_LoadUI];
}
#pragma mark - scrollview delegate -
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self xl_InfiniteShuffling];
}
#pragma mark - private method - 
- (void)customMethod
{
    static int static_k = 3;
    int val = 4;
    void (^ myBlock)(void) = ^ {
        static_global ++;
        global ++;
        static_k ++;
        NSLog(@"static_global = %d\nglobal = %d\nstatic_k = %d", static_global, global, static_k);
    };
    global ++;
    static_global ++;
    static_k ++;
    val ++;
    NSLog(@"static_global = %d\nglobal = %d\nstatic_k = %d\nval = %d", static_global, global, static_k, val);
    myBlock();
}
- (void)xl_LoadUI
{
    for (int i = 0; i < self.dataArr.count + 2; i++) {
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(i * kScreenWidth, 0, kScreenWidth, kScreenHeight - 64)];
        v.tag = tagNum + i;
        if (i == 0) v.backgroundColor = self.dataArr[self.dataArr.count - 1];
        else if (i == self.dataArr.count + 1) v.backgroundColor = self.dataArr[0];
        else v.backgroundColor = self.dataArr[i - 1];
        
        [self.myScroll addSubview:v];
    }
    [self.myScroll setContentSize:CGSizeMake(kScreenWidth * (self.dataArr.count + 2), 0)];
    [self.myScroll setContentOffset:CGPointMake(kScreenWidth, 0) animated:NO];
}
- (void)xl_InfiniteShuffling
{
    if (self.myScroll.contentOffset.x == 0) {
        //  切换到最后一个
        [self.myScroll setContentOffset:CGPointMake(kScreenWidth * self.dataArr.count, 0) animated:NO];
    }
    else if (self.myScroll.contentOffset.x == kScreenWidth * (self.dataArr.count + 1))
    {
        //  切换到第一个
        [self.myScroll setContentOffset:CGPointMake(kScreenWidth, 0) animated:NO];
    }
}
#pragma mark - setter and getter -
- (UIScrollView *)myScroll
{
    if (!_myScroll) {
        UIScrollView *scroll = [UIScrollView new];
        scroll.delegate = self;
        scroll.pagingEnabled = YES;
        scroll.showsVerticalScrollIndicator = NO;
        scroll.showsHorizontalScrollIndicator = NO;
        _myScroll = scroll;
    }
    return _myScroll;
}
- (NSMutableArray *)dataArr
{
    if (!_dataArr) {
        NSArray *arr = @[[UIColor redColor], [UIColor purpleColor], [UIColor grayColor]];
        NSMutableArray *marr = [NSMutableArray arrayWithArray:arr];
        _dataArr = marr;
    }
    return _dataArr;
}
- (UIPageControl *)pageControll
{
    if (!_pageControll) {
        UIPageControl *page = [UIPageControl new];
    }
    return _pageControll;
}
@end
