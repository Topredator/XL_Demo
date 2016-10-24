//
//  HomeViewController.m
//  XL_Demos
//
//  Created by zhouxiaolu on 16/7/12.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import "HomeViewController.h"

#import "XLTabbarSelectTransition.h"

#import "XL_ScreenConditionViewController.h"
#import "ZXL_BackViewController.h"
#import "BlockViewController.h"
#import "ShareViewController.h"
#import "CountDownViewController.h"
#import "ShoppingCarViewController.h"

#import "ProsonCenterViewController.h"
#import "SemaphoreViewController.h"
#import "DrawCellViewController.h"
#import "MoviePlayerViewController.h"

#import "ClickAnimatedViewController.h"

@interface HomeViewController ()<UITabBarControllerDelegate, UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *sortArr;
}
@property (nonatomic, strong) NSMutableArray *titlesArr;
@property (nonatomic, strong) NSMutableArray *classNamesArr;
@property (nonatomic, strong) UITableView *myTable;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    sortArr = [NSMutableArray array];
    // Do any additional setup after loading the view.
    self.tabBarController.delegate = self;
    self.titlesArr = @[].mutableCopy;
    self.classNamesArr = @[].mutableCopy;
    //  添加cell
    [self setCellContent:@"筛选" className:@"XL_ScreenConditionViewController"];
    [self setCellContent:@"自定义输入框" className:@"ZXL_BackViewController"];
    [self setCellContent:@"Block + 无线轮播" className:@"BlockViewController"];
    [self setCellContent:@"自定义分享" className:@"ShareViewController"];
    [self setCellContent:@"倒计时" className:@"CountDownViewController"];
    [self setCellContent:@"购物车" className:@"ShoppingCarViewController"];
    [self setCellContent:@"个人中心" className:@"ProsonCenterViewController"];
    [self setCellContent:@"信号量" className:@"SemaphoreViewController"];
    [self setCellContent:@"抽屉Cell" className:@"DrawCellViewController"];
    [self setCellContent:@"播放器" className:@"MoviePlayerViewController"];
    [self setCellContent:@"cell点击效果" className:@"ClickAnimatedViewController"];
    
    NSArray *arr = @[@1, @32, @10, @45, @3, @0, @21];
    [self fastSortWithArray:[NSMutableArray arrayWithArray:arr]];
    NSLog(@"sortArr = %@", sortArr);
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.view addSubview:self.myTable];
    [_myTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsZero);
    }];
}
#pragma mark - tableview datasource and delegate -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _titlesArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[[UITableViewCell class] description]];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[[UITableViewCell class] description]];
    }
    cell.textLabel.text = _titlesArr[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *className = self.classNamesArr[indexPath.row];
    Class class = NSClassFromString(className);
    if (class) {
        UIViewController *ctrl = class.new;
        ctrl.title = _titlesArr[indexPath.row];
        ctrl.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:ctrl animated:YES];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return .01f;
}
#pragma mark - UITabBarControllerDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController
                     animationControllerForTransitionFromViewController:(UIViewController *)fromVC
                                                       toViewController:(UIViewController *)toVC  NS_AVAILABLE_IOS(7_0)
{
    return [XLTabbarSelectTransition tabbarSelectTranstion];
}
#pragma mark - private method -
- (void)setCellContent:(NSString *)title className:(NSString *)name
{
    [self.titlesArr addObject:title];
    [self.classNamesArr addObject:name];
}


-(NSMutableArray *)bubbleSortWithArray:(NSMutableArray *)dataArr
{
    if(!dataArr || dataArr.count==0 || dataArr.count==1) return dataArr;
    for(NSInteger i=dataArr.count;i>0;i--)
    {
        NSInteger maxValue=[dataArr[0] integerValue];
        NSInteger maxIndex=0;
        for(NSInteger j=1;j<i;j++)
        {
            if(maxValue>[dataArr[j] integerValue])
            {
                NSInteger  tValue=maxValue;
                dataArr[maxIndex]=@([dataArr[j] integerValue]);
                dataArr[j]=@(tValue);
                maxIndex=j;
            }
            else
            {
                maxValue=[dataArr[j] integerValue];
                maxIndex=j;
            }
        }
    }
    return dataArr;
}

//快速排序@3,@5,@1,@5,@9,@30,@7,@2,@0
/**
 *  快速排序
 *
 *  @param dataArr 原数组
 */
- (void)fastSortWithArray:(NSMutableArray *)dataArr
{
    if(!dataArr || dataArr.count==0) return;
    NSInteger middleValue=[dataArr[0] integerValue];
    NSMutableArray  *minArr=[NSMutableArray array];
    NSMutableArray  *maxArr=[NSMutableArray array];
    for(int i=1;i<dataArr.count;i++)
    {
        if([dataArr[i] integerValue]<middleValue)
        {
            [minArr addObject:dataArr[i]];
        }
        else
        {
            [maxArr addObject:dataArr[i]];
        }
    }
    [self fastSortWithArray:minArr];//递归
    [self fastSortWithArray:maxArr];//递归
    
    if(sortArr.count==0)
    {
        [sortArr addObject:@(middleValue)];//sortArr为全局的变量
    }
    else
    {
        for(int i=0;i<sortArr.count;i++)
        {
            if(i==0 && middleValue<=[sortArr[i] integerValue])
            {
                [sortArr insertObject:@(middleValue) atIndex:0];
                break;
            }
            if(i+1<sortArr.count && middleValue>[sortArr[i] integerValue] && middleValue<=[sortArr[i+1] integerValue])
            {
                [sortArr insertObject:@(middleValue) atIndex:i+1];
                break;
            }
            if(i==sortArr.count-1 && middleValue>=[sortArr[i] integerValue])//最后一个
            {
                [sortArr addObject:@(middleValue)];
                break;
            }
        }
    }
}


#pragma mark - setter and getter
- (UITableView *)myTable
{
    if (!_myTable) {
        UITableView *tb = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        tb.dataSource = self;
        tb.delegate = self;
        _myTable = tb;
    }
    return _myTable;
}
@end
