//
//  DrawCellViewController.m
//  XL_Demos
//
//  Created by zhouxiaolu on 16/9/13.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import "DrawCellViewController.h"
#import "DrawCell.h"
#import "DMDraw.h"


#define kText  @"一块车牌，一个车位比一辆车还贵/成本太高不敢结婚/孩子上不起学/天气阴晴不定/我已成傻逼。"

@interface DrawCellViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *drawTableview;
@property (nonatomic, strong) NSMutableArray *dataArr;
@end

@implementation DrawCellViewController
#pragma mark - life cycle -
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.view addSubview:self.drawTableview];
    [self.drawTableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataArr = [NSMutableArray array];
    NSArray *arr = @[@{@"title" : @"Topredator", @"desText" : kText, @"timeText" : @"2016-09-13", @"detailImage" : @"image.jpg"},
                            @{@"title" : @"Topredator", @"desText" : kText, @"timeText" : @"2016-09-13", @"detailImage" : @"image.jpg"},
                            @{@"title" : @"Topredator", @"desText" : kText, @"timeText" : @"2016-09-13", @"detailImage" : @"image.jpg"},
                            @{@"title" : @"Topredator", @"desText" : kText, @"timeText" : @"2016-09-13", @"detailImage" : @"image.jpg"},
                            @{@"title" : @"Topredator", @"desText" : kText, @"timeText" : @"2016-09-13", @"detailImage" : @"image.jpg"},
                            @{@"title" : @"Topredator", @"desText" : kText, @"timeText" : @"2016-09-13", @"detailImage" : @"image.jpg"},
                            @{@"title" : @"Topredator", @"desText" : kText, @"timeText" : @"2016-09-13", @"detailImage" : @"image.jpg"}];
    for (NSDictionary *dic in arr) {
        DMDraw *draw = [[DMDraw alloc] initWithDic:dic];
        [self.dataArr addObject:draw];
    }
}
#pragma mark - tableview datasource and delegate -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"DrawCell";
    DrawCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[DrawCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    [cell configDrawCellWithModel:self.dataArr[indexPath.row]];
    [cell addDeselectCellBlick:^{
        for (UIView *subcell in tableView.visibleCells) {
            if (subcell != cell) {
                subcell.alpha = 1;
            }
        }
        tableView.allowsSelection = YES;
        tableView.scrollEnabled = YES;
    }];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DrawCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [self.drawTableview bringSubviewToFront:cell];
    for (UIView *subcell in tableView.visibleCells) {
        if (subcell != cell) {
            subcell.alpha = 0;
        }
    }
    tableView.allowsSelection = NO;
    tableView.scrollEnabled = NO;
    [cell selectToShowDrawCellDetailWithContentOffsetY:tableView.contentOffset.y];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return .01f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .01f;
}
#pragma mark - setter and getter -
- (UITableView *)drawTableview
{
    if (!_drawTableview) {
        UITableView *tb = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        tb.dataSource = self;
        tb.delegate = self;
        _drawTableview = tb;
    }
    return _drawTableview;
}
@end
