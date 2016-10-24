//
//  CountDownViewController.m
//  XL_Demos
//
//  Created by zhouxiaolu on 16/8/31.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import "CountDownViewController.h"

#import "CountCell.h"

@interface CountDownViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *countTableview;
@property (nonatomic, strong) NSMutableArray *countDataArr;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation CountDownViewController
#pragma mark - life cycle -
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.view addSubview:self.countTableview];
    [self.countTableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.countDataArr = [NSMutableArray array];
    for (int i = 0; i < 15; i++) {
        int num = 0;
        num += (arc4random() % 10) * 3600;
        num += (arc4random() % 60) * 60;
        num += arc4random() % 60;
        [self.countDataArr addObject:[NSNumber numberWithInt:num]];
    }
    self.timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerEvent) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(timeinvalidate) name:@"timeinvalidate" object:nil];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"timeinvalidate" object:nil];
}
#pragma mark - tableview datasource and delegete -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.countDataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CountCell *cell = [tableView dequeueReusableCellWithIdentifier:[[CountCell class] description]];
    if (!cell) {
        cell = [[CountCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[[CountCell class] description] cellWidth:kScreenFrame_width];
    }
    [cell configCellWithData:self.countDataArr[indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return .01f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .01f;
}
#pragma mark - event method -
- (void)timerEvent
{
    if (!self.countDataArr.count) return;
    for (int i = 0; i < self.countDataArr.count; i++) {
        int second = [self.countDataArr[i] intValue];
        second -= 1;
        [self.countDataArr replaceObjectAtIndex:i withObject:[NSNumber numberWithInt:second]];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NotificationConfirmCell" object:nil];
}
- (void)timeinvalidate
{
    [self.timer invalidate];
}
#pragma mark - setter and getter -
- (UITableView *)countTableview
{
    if (!_countTableview) {
        UITableView *tb = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        tb.delegate = self;
        tb.dataSource = self;
        _countTableview = tb;
    }
    return _countTableview;
}
@end
