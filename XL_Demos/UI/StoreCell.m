//
//  StoreCell.m
//  XL_Demos
//
//  Created by zhouxiaolu on 16/9/6.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import "StoreCell.h"

#import "DMShopCar.h"

@interface StoreCell ()
@property (nonatomic, assign) StorecellType cellType;
@property (nonatomic, strong) UIButton *selectBtn; //   选中button
@property (nonatomic, strong) UIImageView *logoImage; //    图标
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) DMShopCar *dm;
@end


@implementation StoreCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier storecellType:(StorecellType)type
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.cellType = type;
        [self customLayoutSubviews];
    }
    return self;
}
- (void)customLayoutSubviews
{
    BS(vs);
    if (self.cellType == StorecellType_StoreTitle)
    {
        [self.contentView addSubview:self.selectBtn];
        [self.contentView addSubview:self.logoImage];
        [self.contentView addSubview:self.contentLabel];
        [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(20, 20));
            make.left.equalTo(@15);
            make.top.equalTo(@12);
        }];
        [self.logoImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(30, 30));
            make.left.equalTo(vs.selectBtn.mas_right).offset(15);
            make.top.equalTo(@7);
        }];
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@12);
            make.left.equalTo(vs.logoImage.mas_right).offset(10);
            make.right.equalTo(vs.contentView.mas_right).offset(-15);
            make.height.equalTo(@20);
        }];
    }
    else if (self.cellType == StorecellType_TotalPrice)
    {
        [self.contentView addSubview:self.contentLabel];
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@12);
            make.left.equalTo(@50);
            make.right.equalTo(vs.contentView.mas_right).offset(-50);
            make.height.equalTo(@20);
        }];
    }
}
#pragma mark - event method -
- (void)selectBtnAction:(UIButton *)btn
{
    if (self.selectBlock) {
        self.selectBlock(_dm, btn);
    }
}
#pragma mark - setter and getter -
- (UIButton *)selectBtn
{
    if (!_selectBtn) {
        UIButton *btn = [UIButton new];
        [btn setImage:[UIImage imageNamed:@"unchecked"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"checked"] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(selectBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        _selectBtn = btn;
    }
    return _selectBtn;
}
- (UIImageView *)logoImage
{
    if (!_logoImage) {
        UIImageView *logo = [UIImageView new];
        logo.image = [UIImage imageNamed:@"shop.png"];
        _logoImage = logo;
    }
    return _logoImage;
}
- (UILabel *)contentLabel
{
    if (!_contentLabel) {
        UILabel *lb = [UILabel new];
        lb.font = kFont(16);
        _contentLabel = lb;
    }
    return _contentLabel;
}
@end
