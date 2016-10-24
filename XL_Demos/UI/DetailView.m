//
//  DetailView.m
//  XL_Demos
//
//  Created by zhouxiaolu on 16/9/13.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import "DetailView.h"
#import "DMDraw.h"

@interface DetailView ()
@property (nonatomic, strong) UIImageView *detailImage;
@property (nonatomic, strong) UILabel *textLabel;
@end

@implementation DetailView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.detailImage];
        [self addSubview:self.textLabel];
        
        WS(vs);
        [self.detailImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@20);
            make.right.equalTo(@(-20));
            make.top.equalTo(@20);
            make.height.equalTo(@200);
        }];
        [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@20);
            make.right.equalTo(@(-20));
            make.top.equalTo(vs.detailImage.mas_bottom).offset(20);
            make.height.equalTo(@40);
        }];
    }
    return self;
}
- (void)configDetailViewWithModel:(DMDraw *)model
{
    self.detailImage.image = [UIImage imageNamed:model.detailImage];
    self.textLabel.text = model.desText;
}
#pragma mark - setter and getter -
- (UIImageView *)detailImage
{
    if (!_detailImage) {
        UIImageView *image = [UIImageView new];
        image.contentMode = UIViewContentModeScaleAspectFit;
        _detailImage = image;
    }
    return _detailImage;
}
- (UILabel *)textLabel
{
    if (!_textLabel) {
        UILabel *lb = [UILabel new];
        lb.textColor = [UIColor hexChangeFloat:@"9b9b9b"];
        lb.textAlignment = NSTextAlignmentCenter;
        lb.font = kFont(16);
        lb.numberOfLines = 0;
        _textLabel = lb;
    }
    return _textLabel;
}
@end
