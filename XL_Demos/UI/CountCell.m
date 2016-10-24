//
//  CountCell.m
//  XL_Demos
//
//  Created by zhouxiaolu on 16/8/31.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import "CountCell.h"

@interface CountCell ()
{
    int second; //  秒
}
@property (nonatomic, strong) YYLabel *contentLabel;
@end


@implementation CountCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellWidth:(CGFloat)cellWidth
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.contentLabel];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(notificationCenterEvent:)
                                                     name:@"NotificationConfirmCell"
                                                   object:nil];
        WS(vs);
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(vs.contentView).offset(15);
            make.left.equalTo(vs.contentView).offset(10);
            make.right.equalTo(vs.contentView.mas_right).offset(-10);
            make.height.mas_equalTo(20);
        }];
    }
    return self;
}
- (void)configCellWithData:(NSNumber *)num
{
    second = num.intValue;
    self.contentLabel.text = [self currentTimeString:num.intValue];
}
#pragma mark - event method -
- (void)notificationCenterEvent:(id)sender
{
    second -= 1;
    self.contentLabel.text = [self currentTimeString:second];
}
#pragma mark - private method - 
- (NSMutableAttributedString *)timeContent:(NSString *)time
{
    NSMutableAttributedString *matt = [[NSMutableAttributedString alloc] initWithString:time attributes:@{NSFontAttributeName : kFont(18), NSForegroundColorAttributeName : [UIColor hexChangeFloat:@"ff5607"]}];
    return matt;
}
- (NSString*)currentTimeString:(int)countNum {
    if (countNum <= 0) {
        return @"00:00:00";
    } else {
        return [NSString stringWithFormat:@"%02ld:%02ld:%02ld",(long)countNum/3600,(long)countNum%3600/60,(long)countNum%60];
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}
#pragma mark - setter and getter -
- (YYLabel *)contentLabel
{
    if (!_contentLabel) {
        YYLabel *lb = [YYLabel new];
        lb.textAlignment = NSTextAlignmentCenter;
        lb.textColor = [UIColor hexChangeFloat:@"ff5607"];
        lb.font = kFont(18);
        _contentLabel = lb;
    }
    return _contentLabel;
}
@end
