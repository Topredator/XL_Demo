//
//  DrawCell.m
//  XL_Demos
//
//  Created by zhouxiaolu on 16/9/13.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import "DrawCell.h"
#import "DMDraw.h"

#import "DetailView.h"

#define kSuperview_Height self.superview.superview.bounds.size.height

@interface DrawCell ()
@property (nonatomic, strong) UILabel *titleLabel; //   title
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) DetailView *detailView;

@property (nonatomic, strong) UIButton *fuctionBtn;


@property (nonatomic, copy) DeselecCellBlock cellBlock;

@property (nonatomic, assign) CGRect originCellFrame;
@property (nonatomic, assign) CGRect originDetailViewFrame;
@end

@implementation DrawCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        WS(vs);
        [self addSubview:self.titleLabel];
        [self addSubview:self.timeLabel];
        [self addSubview:self.detailLabel];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@15);
            make.top.equalTo(@15);
            make.size.mas_equalTo(CGSizeMake(100, 30));
        }];
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@15);
            make.right.equalTo(vs.mas_right).offset(-15);
            make.size.mas_equalTo(CGSizeMake(100, 30));
        }];
        [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@15);
            make.right.equalTo(@(-15));
            make.top.equalTo(vs.titleLabel.mas_bottom).offset(10);
            make.height.equalTo(@50);
        }];
    }
    return self;
}
- (void)configDrawCellWithModel:(DMDraw *)model
{
    self.titleLabel.text = model.title;
    self.timeLabel.text = model.timeText;
    self.detailLabel.text = model.desText;
    
    [self.detailView configDetailViewWithModel:model];
}
- (void)addDeselectCellBlick:(DeselecCellBlock)block
{
    _cellBlock = block;
}
- (void)selectToShowDrawCellDetailWithContentOffsetY:(CGFloat)contentOffsetY
{
    UIView *superView = self.superview;
    [self.detailView setFrame:CGRectMake(0, CGRectGetMaxY(self.frame), CGRectGetWidth(self.frame), kSuperview_Height)];
    [superView insertSubview:self.detailView belowSubview:self];
    
    [self.fuctionBtn setFrame:CGRectMake(0, contentOffsetY, CGRectGetWidth(self.frame), 120)];
    [self addSubview:self.fuctionBtn];
    
    [UIView animateWithDuration:.3f animations:^{
        CGRect rect = self.frame;
        self.originCellFrame = rect;
        rect.origin = CGPointMake(0, contentOffsetY);
        self.frame = rect;
        
        rect = self.fuctionBtn.frame;
        rect.origin = CGPointMake(0, contentOffsetY);
        self.fuctionBtn.frame = rect;
        
        rect = self.detailView.frame;
        self.originDetailViewFrame = rect;
        rect.origin = CGPointMake(0, contentOffsetY + 120);
        self.detailView.frame = rect;
        
        [self addShadowWithView:self];
        [self addShadowWithView:self.detailView];
    }];
}
- (void)addShadowWithView:(UIView *)view {
    [view.layer setShadowColor:[UIColor blackColor].CGColor];
    [view.layer setShadowOpacity:0.3];
    [view.layer setShadowRadius:3.0];
    [view.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)fuctionBtnAction:(UIButton *)btn
{
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = self.originCellFrame;
        
        self.layer.shadowColor = [UIColor clearColor].CGColor;
        self.layer.shadowRadius = 0;
        self.layer.shadowOpacity = 0.0;
        
        self.detailView.layer.shadowColor = [UIColor clearColor].CGColor;
        self.detailView.layer.shadowRadius = 0;
        self.detailView.layer.shadowOpacity = 0.0;
        
        self.detailView.frame = self.originDetailViewFrame;
    } completion:^(BOOL finished) {
        [self.detailView removeFromSuperview];
        [self.fuctionBtn removeFromSuperview];
        if (_cellBlock) {
            _cellBlock();
        }
    }];
}
#pragma mark - setter and getter -
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        UILabel *lb = [UILabel new];
        lb.font = kFont(16);
        _titleLabel = lb;
    }
    return _titleLabel;
}
- (UILabel *)detailLabel
{
    if (!_detailLabel) {
        UILabel *lb = [UILabel new];
        lb.font = kFont(16);
        lb.numberOfLines = 0;
        _detailLabel = lb;
    }
    return _detailLabel;
}
- (DetailView *)detailView
{
    if (!_detailView) {
        DetailView *view = [DetailView new];
        _detailView = view;
    }
    return _detailView;
}
- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        UILabel *lb = [UILabel new];
        lb.font = kFont(16);
        _timeLabel = lb;
    }
    return _timeLabel;
}
- (UIButton *)fuctionBtn
{
    if (!_fuctionBtn) {
        UIButton *btn = [UIButton new];
        [btn setBackgroundColor:[UIColor clearColor]];
        [btn addTarget:self action:@selector(fuctionBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        _fuctionBtn = btn;
    }
    return _fuctionBtn;
}
@end
