//
//  XL_SpeedDialViewController.m
//  XL_Demos
//
//  Created by zhouxiaolu on 16/7/18.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import "XL_SpeedDialViewController.h"
#import "UITableView+FDTemplateLayoutCell.h"

#import "SpeedDialCell.h"

#define kCellIdentifier @"speedDial"


#import "SpeedDial.h"

@interface XL_SpeedDialViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *speedDialTableView;
@property (nonatomic, strong) NSMutableArray *dataArr;
@end

@implementation XL_SpeedDialViewController
#pragma mark - life cycle method -
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSArray *arr = @[@{@"arr" : @[@"1", @"2", @"3", @"4", @"5", @"6"]},
                     @{@"arr" : @[@"1", @"2", @"3", @"4", @"5", @"6", @"7"]},
                     @{@"arr" : @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9"]},
                     @{@"arr" : @[@"1", @"2", @"3", @"4"]},
                     @{@"arr" : @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9"]},
                     @{@"arr" : @[@"1", @"2", @"3", @"4", @"5", @"6"]}];
    
    self.dataArr = [NSMutableArray array];
    for (NSDictionary *dic in arr) {
        SpeedDial *speedDial = [[SpeedDial alloc] initWithDatadic:dic];
        [self.dataArr addObject:speedDial];
    }
    
    
//    [self layoutSubViews];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    WS(vs);
    [self.view addSubview:self.speedDialTableView];
    [_speedDialTableView registerClass:[SpeedDialCell class] forCellReuseIdentifier:kCellIdentifier];
    [_speedDialTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(vs.view).with.insets(UIEdgeInsetsZero);
    }];
    
}

#pragma mark - private methods - 
- (void)layoutSubViews
{
    NSMutableArray *views = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < 2; i++) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor purpleColor];
        [self.view addSubview:view];
        [views addObject:view];
    }
    NSArray *items = views;
    
    NSInteger rowCapacity = 3;//每行item容量(个数)
    
    CGFloat itemSpacing = 10; //item间距
    CGFloat rowSpacing = 10; //行间距
    CGFloat topMargin = 80; //上边距
    CGFloat leftMargin = 10; //左边距
    CGFloat rightMargin = 10; //右边距
    
    __block UIView *lastView;

    [items enumerateObjectsUsingBlock:^(UIView   *view, NSUInteger idx, BOOL *  stop) {
        NSInteger rowIndex = idx / rowCapacity; //行index
        NSInteger columnIndex = idx % rowCapacity;//列index
        
        if (lastView) {
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                //设置 各个item 大小相等
                make.size.equalTo(lastView);
            }];
        }
        if (columnIndex == 0) {//每行第一列
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                //设置左边界
                make.left.offset(leftMargin);
                if (rowIndex == 0) {//第一行 第一个
                    make.width.equalTo(view.mas_height);//长宽相等
                    if (items.count < rowCapacity) {//不满一行时 需要 计算item宽
                        //比如 每行容量是6,则公式为:(superviewWidth/6) - (leftMargin + rightMargin + SumOfItemSpacing)/6
                        make.width.equalTo(view.superview).multipliedBy(1.0/rowCapacity).offset(-(leftMargin + rightMargin + (rowCapacity -1) * itemSpacing)/rowCapacity);
                    }
                    [view mas_makeConstraints:^(MASConstraintMaker *make) {//设置上边界
                        make.top.offset(topMargin);
                    }];
                }else {//其它行 第一个
                    [view mas_makeConstraints:^(MASConstraintMaker *make) {
                        //和上一行的距离
                        make.top.equalTo(lastView.mas_bottom).offset(rowSpacing);
                    }];
                }
            }];
        }else {
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                //设置item水平间距
                make.left.equalTo(lastView.mas_right).offset(itemSpacing);
                //设置item水平对齐
                make.centerY.equalTo(lastView);
                
                //设置右边界距离
                //只有第一行最后一个有必要设置与父视图右边的距离，因为结合这条约束和之前的约束可以得出item的宽，前提是必须满一行，不满一行 需要计算item的宽
                if (columnIndex == rowCapacity - 1 && rowIndex == 0) {
                    make.right.offset(- rightMargin);
                }
            }];
        }
        lastView = view;
    }];
    
}

#pragma mark - tableview datasource and delegate -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SpeedDialCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [self configCell:cell indexPath:indexPath];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WS(vs);
    return [tableView fd_heightForCellWithIdentifier:kCellIdentifier
                                    cacheByIndexPath:indexPath
                                       configuration:^(SpeedDialCell *cell) {
                                           [vs configCell:cell indexPath:indexPath];
                                       }];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return .01f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .01f;
}
#pragma mark - private method -
- (void)configCell:(SpeedDialCell *)cell indexPath:(NSIndexPath *)indexPath
{
    cell.fd_enforceFrameLayout = YES;
    cell.speedDial = self.dataArr[indexPath.row];
}
#pragma mark - setter and getter -
- (UITableView *)speedDialTableView
{
    if (!_speedDialTableView) {
        UITableView *tb = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        tb.dataSource = self;
        tb.delegate = self;
        tb.fd_debugLogEnabled = YES;
        _speedDialTableView = tb;
    }
    return _speedDialTableView;
}
@end
