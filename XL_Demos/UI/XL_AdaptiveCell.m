//
//  XL_AdaptiveCell.m
//  XL_Demos
//
//  Created by zhouxiaolu on 16/7/15.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import "XL_AdaptiveCell.h"

@interface XL_AdaptiveCell ()
{
    MASConstraint *constraint_Content;
    MASConstraint *constraint_Image;
    MASConstraint *constraint_Name;
}
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIImageView *contentImage;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@end

@implementation XL_AdaptiveCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        WS(vs);
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.contentLabel];
        [self.contentView addSubview:self.contentImage];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.timeLabel];
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(vs.contentView).offset(10);
            make.leading.equalTo(vs.contentView).offset(15);
            make.trailing.equalTo(vs.contentView.mas_trailing).with.offset(-15);
        }];
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(vs.titleLabel.mas_leading);
            make.right.equalTo(vs.contentView.mas_right).offset(-15);
            //  设置两条优先度不同的约束，内容为空时将优先度高的约束禁用
            //  优先度低，会被优先度高覆
            make.top.equalTo(vs.titleLabel.mas_bottom).priorityLow();
            constraint_Content = make.top.equalTo(vs.titleLabel.mas_bottom).offset(10).priorityHigh();
        }];
        
        
        [_contentImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(vs.titleLabel.mas_left);
            make.height.greaterThanOrEqualTo(@0);
            make.right.lessThanOrEqualTo(vs.contentView.mas_right).offset(-15);
            make.top.equalTo(vs.contentLabel.mas_bottom).priorityLow();
            constraint_Image = make.top.equalTo(vs.contentLabel.mas_bottom).offset(8).priorityHigh();
        }];
        
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(vs.titleLabel.mas_left);
            make.top.equalTo(vs.contentImage.mas_bottom).priorityLow();
            constraint_Name = make.top.equalTo(vs.contentImage.mas_bottom).offset(8).priorityHigh();
        }];
        
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(vs.contentView.mas_right).offset(-15);
            make.top.equalTo(vs.nameLabel.mas_top);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        }];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setAdaptive:(XL_Adaptive *)adaptive
{
    _adaptive = adaptive;
    self.titleLabel.text = adaptive.title;
    self.contentLabel.text = adaptive.content;
    self.contentImage.image = adaptive.imageName.length > 0 ? [UIImage imageNamed:adaptive.imageName] : nil;
    self.nameLabel.text = adaptive.username;
    self.timeLabel.text = adaptive.time;
    
    
    self.contentLabel.text.length ==  0 ? [constraint_Content deactivate] : [constraint_Content activate];
    self.contentImage.image      == nil ? [constraint_Image deactivate] : [constraint_Image activate];
    self.nameLabel.text.length ==  0 ? [constraint_Name deactivate] : [constraint_Name activate];
    
}

- (CGSize)sizeThatFits:(CGSize)size {
    CGFloat totalHeight = 0;
    totalHeight += [self.titleLabel sizeThatFits:size].height;
    totalHeight += [self.contentLabel sizeThatFits:size].height;
    totalHeight += [self.contentImage sizeThatFits:size].height;
    totalHeight += [self.nameLabel sizeThatFits:size].height;
    totalHeight += 46; // margins
    return CGSizeMake(size.width, totalHeight);
}

#pragma mark - setter and getter -
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        UILabel *lb = [UILabel new];
        lb.font = kFont(16);
        lb.numberOfLines = 0;
        _titleLabel = lb;
    }
    return _titleLabel;
}
- (UILabel *)contentLabel
{
    if (!_contentLabel) {
        UILabel *lb = [UILabel new];
        lb.font = kFont(14);
        lb.numberOfLines = 0;
//        lb.preferredMaxLayoutWidth = kScreenFrame_width - 30;
        _contentLabel = lb;
    }
    return _contentLabel;
}
- (UIImageView *)contentImage
{
    if (!_contentImage) {
        UIImageView *image = [UIImageView new];
        _contentImage = image;
    }
    return _contentImage;
}
- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        UILabel *lb = [UILabel new];
        lb.font = kFont(16);
        lb.numberOfLines = 1;
        _nameLabel = lb;
    }
    return _nameLabel;
}
- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        UILabel *lb = [UILabel new];
        lb.font = kFont(16);
        lb.numberOfLines = 1;
        _timeLabel = lb;
    }
    return _timeLabel;
}
@end
