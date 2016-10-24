//
//  ShoppingCarViewController.m
//  XL_Demos
//
//  Created by zhouxiaolu on 16/9/1.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import "ShoppingCarViewController.h"

@interface ShoppingCarViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *shopTableview; //    列表
@property (nonatomic, strong) UIView *bottomView;   //  底部视图
@property (nonatomic, strong) UIButton *allSelectBtn; //    全选按钮
@property (nonatomic, strong) UILabel *totalLabel; //   结算
@property (nonatomic, strong) NSMutableArray *goodDataArr;  //  数据源
@property (nonatomic, strong) NSMutableArray *selectedArr;  //  选中的数据
@property (nonatomic, strong) NSMutableArray *unSelectedArr;    //  未选中的数据
@property (nonatomic, strong) UILabel *defaultLabel; // 缺省页
@end

@implementation ShoppingCarViewController
#pragma mark - life cycle -
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.goodDataArr = [NSMutableArray array];
    self.selectedArr = [NSMutableArray array];
    self.unSelectedArr = [NSMutableArray array];
    [self customSub];
}
#pragma mark - event method -
- (void)allSelectBtnAction:(UIButton *)btn
{
    btn.selected = !btn.selected;
}
#pragma mark - private method -
- (void)customSub
{
    [self.view addSubview:self.shopTableview];
    [self.view addSubview:self.bottomView];
    [_bottomView addSubview:self.allSelectBtn];
    [_bottomView addSubview:self.totalLabel];
    
    BS(vs);
    [self.shopTableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, -50, 0));
    }];
    [_shopTableview insertSubview:self.defaultLabel atIndex:0];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.equalTo(@0);
        make.height.equalTo(@50);
    }];
    [self.allSelectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.centerY.equalTo(vs.bottomView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(65, 40));
    }];
    [self.totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(vs.bottomView.mas_centerY);
        make.right.equalTo(@-15);
        make.size.mas_equalTo(CGSizeMake(150, 40));
    }];
}
#pragma mark - tableview datasource and delegete -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    self.defaultLabel.hidden = (!self.goodDataArr.count) ? NO : YES;
    return self.goodDataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"shoppingcarCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
#pragma mark - setter and getter -
- (UITableView *)shopTableview
{
    if (!_shopTableview) {
        UITableView *tb = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        tb.delegate = self;
        tb.dataSource = self;
        tb.backgroundColor = RGBA(249, 249, 249, 1);
        tb.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        tb.separatorColor = [UIColor hexChangeFloat:@"e4e4e4"];
        _shopTableview = tb;
    }
    return _shopTableview;
}
- (UIView *)bottomView
{
    if (!_bottomView) {
        UIView *v = [UIView new];
        v.backgroundColor = RGBA(235, 235, 235, 1);
        _bottomView = v;
    }
    return _bottomView;
}
- (UIButton *)allSelectBtn
{
    if (!_allSelectBtn) {
        UIButton *btn = [UIButton new];
        [btn setImage:[UIImage imageNamed:@"unchecked"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"checked"] forState:UIControlStateSelected];
        [btn setTitle:@" 全选" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = kFont(16);
        btn.titleEdgeInsets = UIEdgeInsetsMake(0,5,0,0);
        [btn addTarget:self action:@selector(allSelectBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        _allSelectBtn = btn;
    }
    return _allSelectBtn;
}
- (UILabel *)totalLabel
{
    if (!_totalLabel) {
        UILabel *lb = [UILabel new];
        lb.textColor = [UIColor hexChangeFloat:@"ff5607"];
        lb.font = kFont(16);
        lb.text = @"确定(0)";
        lb.textAlignment = NSTextAlignmentRight;
        _totalLabel = lb;
    }
    return _totalLabel;
}
- (UILabel *)defaultLabel
{
    if (!_defaultLabel) {
        UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(15, (kScreenFrame_height - 64 - 50 - 50) / 2, kScreenFrame_width - 30, 50)];
        lb.textAlignment = NSTextAlignmentCenter;
        lb.textColor = [UIColor hexChangeFloat:@"999999"];
        lb.font = kFont(16);
        lb.text = @"很遗憾，没有商品";
        _defaultLabel = lb;
    }
    return _defaultLabel;
}
@end
