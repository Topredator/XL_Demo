//
//  ShowTextCell.m
//  XL_Demos
//
//  Created by zhouxiaolu on 16/9/28.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import "ShowTextCell.h"
#import "DMShowText.h"
#import "NSString+LabelWidthAndHeight.h"
#import "XL_CellAdapter.h"


@interface ShowTextCell ()
@property (nonatomic, strong) UILabel  *normalLabel;
@property (nonatomic, strong) UILabel  *expendLabel;
@property (nonatomic, strong) UIView   *line;
@property (nonatomic, strong) UIView   *stateView;
@end

@implementation ShowTextCell
- (void)setupCell
{
    [super setupCell];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
- (void)buildSubviews
{
    [self.contentView addSubview:self.line];
    [self.contentView addSubview:self.stateView];
    [self.contentView addSubview:self.normalLabel];
    [self.contentView addSubview:self.expendLabel];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.and.right.equalTo(@0);
        make.height.equalTo(@.5);
    }];
    [self.stateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@13);
        make.size.mas_equalTo(CGSizeMake(2, 15));
    }];
    
}
- (void)loadContent
{
    DMShowText *dm = self.adapter.data;
    XL_CellAdapter *adapter = self.adapter;
    
    NSDictionary *attributeDic = @{NSFontAttributeName : kFont(14)};
    CGFloat width = kScreenWidth - 30;
    
    CGFloat totalHeight = [dm.contentString heightWithStringAttribute:attributeDic fixedWidth:width];
    CGFloat oneLineHeight = [NSString oneLineOfTextHeightWithStringAttribute:attributeDic];
    CGFloat nomalTextHeight = totalHeight >= 3 * oneLineHeight ? 3 * oneLineHeight : totalHeight;
    
    self.normalLabel.text = dm.contentString;
    self.expendLabel.text = dm.contentString;
    [self.normalLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.top.equalTo(@10);
        make.right.equalTo(@(-15));
        make.height.mas_equalTo(nomalTextHeight);
    }];
    [self.expendLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.top.equalTo(@10);
        make.right.equalTo(@(-15));
        make.height.mas_equalTo(totalHeight);
    }];
    
    if (adapter.cellType == ShowTextCellType_Normal)
    {
        self.normalLabel.alpha = 1;
        self.expendLabel.alpha = 0;
        self.stateView.backgroundColor = [UIColor grayColor];
    }
    else
    {
        self.normalLabel.alpha = 0;
        self.expendLabel.alpha = 1;
        self.stateView.backgroundColor = [UIColor redColor];
    }
    self.line.hidden = (self.indexPath.row == 0);
}

- (void)selectedEvent
{
    [self changeStatus];
}

+ (CGFloat)cellHeightWithData:(id)data
{
    DMShowText *dm = data;
    if (dm) {
        NSDictionary *attributeDic = @{NSFontAttributeName : kFont(14)};
        CGFloat width = kScreenWidth - 30;
        
        CGFloat totalHeight = [dm.contentString heightWithStringAttribute:attributeDic fixedWidth:width];
        CGFloat oneLineHeight = [NSString oneLineOfTextHeightWithStringAttribute:attributeDic];
        CGFloat nomalTextHeight = totalHeight >= 3 * oneLineHeight ? 3 * oneLineHeight : totalHeight;
        
        dm.nomalHeight = 10 + nomalTextHeight + 10;
        dm.expendHeight = 10 + totalHeight + 10;
    }
    return 0.f;
}

#pragma mark - private method -
- (void)changeStatus
{
    DMShowText *dm = self.adapter.data;
    XL_CellAdapter *adapter = self.adapter;
    if (adapter.cellType == ShowTextCellType_Normal)
    {
        adapter.cellType = ShowTextCellType_Expend;
        [self updateWithNewCellHeight:dm.expendHeight animated:YES];
        [self expendStatus];
    }
    else
    {
        adapter.cellType = ShowTextCellType_Normal;
        [self updateWithNewCellHeight:dm.nomalHeight animated:YES];
        [self normalStatus];
    }
}
- (void)normalStatus
{
    [UIView animateWithDuration:.25f animations:^{
        self.normalLabel.alpha = 1;
        self.expendLabel.alpha = 0;
        self.stateView.backgroundColor = [UIColor grayColor];
    }];
}
- (void)expendStatus
{
    [UIView animateWithDuration:.25f animations:^{
        self.normalLabel.alpha         = 0;
        self.expendLabel.alpha         = 1;
        self.stateView.backgroundColor = [UIColor redColor];
    }];
}
#pragma mark - setter and getter -
- (UILabel *)normalLabel
{
    if (!_normalLabel) {
        UILabel *lb = [UILabel new];
        lb.font = kFont(14);
        lb.numberOfLines = 3;
        lb.textColor = [UIColor grayColor];
        _normalLabel = lb;
    }
    return _normalLabel;
}
- (UILabel *)expendLabel
{
    if (!_expendLabel) {
        UILabel *lb = [UILabel new];
        lb.font = kFont(14);
        lb.numberOfLines = 0;
        lb.textColor = [UIColor blackColor];
        _expendLabel = lb;
    }
    return _expendLabel;
}
- (UIView *)line
{
    if (!_line) {
        UIView *v = [UIView new];
        v.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.25f];
        _line = v;
    }
    return _line;
}
- (UIView *)stateView
{
    if (!_stateView) {
        UIView *v = [UIView new];
        v.backgroundColor = [UIColor grayColor];
        _stateView = v;
    }
    return _stateView;
}
@end
