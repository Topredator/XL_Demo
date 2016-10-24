//
//  SpeedDialCell.m
//  XL_Demos
//
//  Created by zhouxiaolu on 16/7/18.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import "SpeedDialCell.h"

static const NSInteger rowCapacity = 3; //  每行item个数
static const CGFloat itemSpacing = 10; //item间距
static const CGFloat  rowSpacing = 10; //行间距
static const CGFloat  topMargin = 0; //上边距
static const CGFloat  leftMargin = 0; //左边距
static const CGFloat  rightMargin = 0; //右边距


@interface SpeedDialCell ()
{
    MASConstraint *constraint_Right;
}
@property (nonatomic, strong) UIView *backView;
@end

@implementation SpeedDialCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        WS(vs);
        [self.contentView addSubview:self.backView];
        [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(vs.contentView.mas_left).offset(15);
            make.right.equalTo(vs.contentView.mas_right).offset(-15);
            make.top.equalTo(vs.contentView).offset(10);
            make.bottom.equalTo(vs.contentView.mas_bottom).offset(-10);
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

- (void)setSpeedDial:(SpeedDial *)speedDial
{
    _speedDial = speedDial;
    __block UIView *lastView = nil;
    
    for (int i = 0; i < speedDial.dataArr.count; i++) {
        //行index
        NSInteger rowIndex = i / rowCapacity;
        //列index
        NSInteger columnIndex = i % rowCapacity;
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor purpleColor];
        [self.backView addSubview:view];
        if (lastView) {
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                //设置 各个item 大小相等
                make.size.equalTo(lastView);
            }];
        }
        //每行第一列
        if (columnIndex == 0) {
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                //设置左边界
                make.left.offset(leftMargin);
                if (rowIndex == 0) {//第一行 第一个
                    //                    make.width.equalTo(view.mas_height);//长宽相等
                    //  高
                    make.height.mas_equalTo(50);
                    //  宽
                    //                    make.width.mas_equalTo((CGRectGetWidth(view.superview.frame) - leftMargin - rightMargin - (rowCapacity - 1) * itemSpacing) / rowCapacity);
                    
                    //不满一行时 需要 计算item宽
                    if (speedDial.dataArr.count < rowCapacity) {
                        //比如 每行容量是6,则公式为:(superviewWidth/6) - (leftMargin + rightMargin + SumOfItemSpacing)/6
                        make.width.equalTo(view.superview).multipliedBy(1.0/rowCapacity).offset(-(leftMargin + rightMargin + (rowCapacity -1) * itemSpacing)/rowCapacity);
                    }
                    //  设置上边界
                    [view mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.top.offset(topMargin);
                    }];
                }
                else // 其它行 第一个
                {
                    [view mas_makeConstraints:^(MASConstraintMaker *make) {
                        //和上一行的距离
                        make.top.equalTo(lastView.mas_bottom).offset(rowSpacing);
                    }];
                }
            }];
        }
        else {
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
        
        if (i == speedDial.dataArr.count - 1) {
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(view.superview.mas_bottom).offset(0).priorityHigh();
            }];
        }
        lastView = view;
    }
    
    // 告诉self约束需要更新
    [self.contentView setNeedsUpdateConstraints];
    // 调用此方法告诉self检测是否需要更新约束，若需要则更新，下面添加动画效果才起作用
    [self.contentView updateConstraintsIfNeeded];
    
    // 更新约束
    [UIView animateWithDuration:.2f animations:^{
        [self.contentView layoutIfNeeded];
    }];
}


- (void)setDataArr:(NSArray *)dataArr
{
}

- (CGSize)sizeThatFits:(CGSize)size
{
    CGFloat totalHeight = 0;
    totalHeight += [self.backView sizeThatFits:size].height;
    totalHeight += 20;
    return CGSizeMake(size.width, totalHeight);
}

#pragma mark - setter and getter -
- (UIView *)backView
{
    if (!_backView) {
        UIView *v = [UIView new];
        v.backgroundColor = [UIColor redColor];
        v.translatesAutoresizingMaskIntoConstraints = NO;
        _backView = v;
    }
    return _backView;
}
@end
