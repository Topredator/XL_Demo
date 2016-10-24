//
//  RootViewController.m
//  XL_Demos
//
//  Created by zhouxiaolu on 16/6/20.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import "RootViewController.h"

#import "NetWork.h"

#import "TransitionFromViewController.h"
#import "XL_FactoryViewController.h"
#import "XL_AbstractFactoryViewController.h"
#import "XL_DelegateViewController.h"

#import "XLTabbarSelectTransition.h"

#import "XL_AdaptiveViewController.h"
#import "XL_SpeedDialViewController.h"
#import "XL_CompositeViewController.h"

#import "XL_FileViewController.h"

#import "XL_DecoratorViewController.h"
#import "XL_MediatorViewController.h"
#import "XL_EditaTableViewController.h"


@interface RootViewController ()<UITableViewDataSource, UITableViewDelegate, UITabBarControllerDelegate>
@property (nonatomic, strong) NSMutableArray *titlesArr;
@property (nonatomic, strong) NSMutableArray *classNamesArr;
@property (nonatomic, strong) UITableView *myTable;
@end

@implementation RootViewController
#pragma mark - life cycle method -
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"Topredator Example";
    self.titlesArr = @[].mutableCopy;
    self.classNamesArr = @[].mutableCopy;
    self.tabBarController.delegate = self;
    
    //  添加cell
    [self setCellContent:@"转场动画" className:@"TransitionFromViewController"];
    [self setCellContent:@"工厂模式" className:@"XL_FactoryViewController"];
    [self setCellContent:@"抽象工厂" className:@"XL_AbstractFactoryViewController"];
    [self setCellContent:@"代理" className:@"XL_DelegateViewController"];
    [self setCellContent:@"自适应Cell高度" className:@"XL_AdaptiveViewController"];
    [self setCellContent:@"九宫格" className:@"XL_SpeedDialViewController"];
    [self setCellContent:@"组合模式1" className:@"XL_CompositeViewController"];
    [self setCellContent:@"组合模式2" className:@"XL_FileViewController"];
    [self setCellContent:@"装饰模式" className:@"XL_DecoratorViewController"];
    [self setCellContent:@"中介者模式" className:@"XL_MediatorViewController"];
    [self setCellContent:@"tableview 操作" className:@"XL_EditaTableViewController"];
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

#pragma mark -
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
