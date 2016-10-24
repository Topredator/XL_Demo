//
//  ScreenConditionView.m
//  XL_Demos
//
//  Created by zhouxiaolu on 16/7/27.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import "ScreenConditionView.h"


#define kMargin  15

#define kItemSpace  3
#define kRowSpace 10
#define kItemHeight  30
@interface ScreenConditionView ()
{
    NSInteger numRow;
    CGFloat rowWidth;
}
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, assign) ScreenConditionType conditionType;
@property (nonatomic, strong) NSArray *dataArr;

@end

@implementation ScreenConditionView

- (instancetype)initWithScreenConditionType:(ScreenConditionType)type data:(NSArray *)dataArr pointY:(CGFloat)pointY
{
    self = [super init];
    if (self) {
        self.conditionType = type;
        if (dataArr && dataArr.count) self.dataArr = dataArr;
        //  列
        if (dataArr.count <= 4) {
            numRow = 4;
        } else if (dataArr.count == 5)
            numRow = 3;
        else
            numRow = 4;
        //  宽
        rowWidth = (kScreenFrame_width - 15 * 2 - (numRow - 1) * 3) / numRow;
        [self configSub:pointY];
    }
    return self;
}

- (void)configSub:(CGFloat)pointY
{
    if (self.conditionType == ScreenConditionType_Time) {
        self.titleLabel.text = @"加入时间：";
    } else if (self.conditionType == ScreenConditionType_Money) {
        self.titleLabel.text = @"消费金额：";
    } else if (self.conditionType == ScreenConditionType_Order) {
        self.titleLabel.text = @"消费单数：";
    } else if (self.conditionType == ScreenConditionType_Integrate) {
        self.titleLabel.text = @"剩余积分：";
    } else if (self.conditionType == ScreenConditionType_Coupon) {
        self.titleLabel.text = @"未使用优惠券：";
    }
    [self addSubview:self.titleLabel];
    CGFloat width = [NSString valueForString:self.titleLabel.text font:kFont(14) Type:0 num_Value:16];
    [self.titleLabel setFrame:CGRectMake(15, 10, width, 16)];
    [self addSubview:self.nameLabel];
    [self addSubview:self.contentView];
    
    
    UIButton *button = nil;
    for (int i = 0; i < self.dataArr.count; i++) {
        int rem = i % numRow;
        int con = i / numRow;
        CGFloat x = kMargin + (rowWidth + kItemSpace) * rem;
        CGFloat y = (kItemHeight + kRowSpace) * con;
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(x, y, rowWidth, kItemHeight)];
        [btn setTitle:_dataArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [btn setBackgroundColor:[UIColor whiteColor]];
        btn.titleLabel.font = kFont(14);
        [btn addTarget:self action:@selector(screenConditionAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn];
        if (i == 0)
        {
            [btn setSelected:YES];
            [btn setBackgroundColor:[UIColor blueColor]];
        }
        button = btn;
    }
    if (button)
    {
        CGRect rect = self.contentView.frame;
        rect.size.height = CGRectGetMaxY(button.frame);
        self.contentView.frame = rect;
        [self setFrame:CGRectMake(0, pointY, kScreenFrame_width, CGRectGetMaxY(_contentView.frame) + 10)];
    }
    else
    {
        [self.contentView setFrame:CGRectZero];
        [self setFrame:CGRectMake(0, pointY, kScreenFrame_width, 36)];
    }
    
    
}



#pragma mark - private method -
- (void)screenConditionAction:(UIButton *)btn
{
    for (UIButton *btn in self.contentView.subviews) {
        [btn setSelected:NO];
        [btn setBackgroundColor:[UIColor whiteColor]];
    }
    [btn setSelected:YES];
    [btn setBackgroundColor:[UIColor blueColor]];
    self.nameLabel.text = btn.titleLabel.text;
}

#pragma mark - setter and getter -
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        UILabel *lb = [UILabel new];
        lb.font = kFont(14);
        _titleLabel = lb;
    }
    return _titleLabel;
}
- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        UILabel *lb = [UILabel new];
        lb.font = kFont(14);
        lb.frame = CGRectMake(CGRectGetMaxX(_titleLabel.frame), CGRectGetMinY(_titleLabel.frame), kScreenFrame_width - 30 - CGRectGetWidth(_titleLabel.frame), 16);
        lb.text = @"全部";
        _nameLabel = lb;
    }
    return _nameLabel;
}
- (UIView *)contentView
{
    if (!_contentView) {
        UIView *v = [UIView new];
        v.frame = CGRectMake(0, CGRectGetMaxY(_titleLabel.frame) + 10, kScreenFrame_width, 10);
        _contentView = v;
    }
    return _contentView;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
