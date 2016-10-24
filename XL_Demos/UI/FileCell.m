//
//  FileCell.m
//  XL_Demos
//
//  Created by zhouxiaolu on 16/7/21.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import "FileCell.h"
#import "File.h"

#import "FileViewController.h"

@interface FileCell ()
@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIButton *functionBtn;
@property (nonatomic, strong) UILabel *fileLabel;
@end

@implementation FileCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        WS(vs);
        [self.contentView addSubview:self.leftImageView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.fileLabel];
        [self.contentView addSubview:self.functionBtn];
        
        [_leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.and.top.equalTo(vs.contentView).offset(15);
            make.size.mas_equalTo(CGSizeMake(64, 50));
        }];
        
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(vs.leftImageView.mas_leading);
            make.top.equalTo(vs.leftImageView.mas_bottom).offset(5);
            make.width.mas_equalTo(vs.leftImageView.mas_width);
            make.height.mas_equalTo(20);
        }];
        
        [_fileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(vs.contentView.mas_centerY);
            make.left.equalTo(vs.leftImageView.mas_right).offset(15);
            make.right.equalTo(vs.contentView.mas_right).offset(- 15);
            make.height.mas_equalTo(20);
        }];
        
        [_functionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(vs.contentView).insets(UIEdgeInsetsZero);
        }];
    }
    return self;
}

- (void)configFileContent
{
    File *file = self.data;
    self.nameLabel.text = file.fileName;
    switch (file.fileType) {
        case FileType_Folder:
        {
            self.leftImageView.image = [UIImage imageNamed:@"Folder"];
            self.nameLabel.textColor = [UIColor blackColor];
            self.fileLabel.textColor = [UIColor blackColor];
            self.fileLabel.text = @"Folder";
            self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
            break;
        case FileType_File:
        {
            self.leftImageView.image = [UIImage imageNamed:@"File"];
            self.nameLabel.textColor = [UIColor grayColor];
            self.fileLabel.textColor = [UIColor grayColor];
            self.fileLabel.text = @"File";
            self.accessoryType = UITableViewCellAccessoryNone;
        }
            break;
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

- (void)buttonAction:(UIButton *)btn
{
    File *file = self.data;
    if (file.fileType == FileType_Folder) {
        FileViewController *vc = [[FileViewController alloc] init];
        vc.file = file;
        [self.viewController.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - setter and getter -
- (UIImageView *)leftImageView
{
    if (!_leftImageView) {
        UIImageView *image = [UIImageView new];
        image.contentMode = UIViewContentModeScaleAspectFit;
        _leftImageView = image;
    }
    return _leftImageView;
}
- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        UILabel *lb = [UILabel new];
        lb.font = kFont(12);
        lb.textAlignment = NSTextAlignmentCenter;
        _nameLabel = lb;
    }
    return _nameLabel;
}
- (UILabel *)fileLabel
{
    if (!_fileLabel) {
        UILabel *lb = [UILabel new];
        lb.font = kFont(18);
        _fileLabel = lb;
    }
    return _fileLabel;
}
- (UIButton *)functionBtn
{
    if (!_functionBtn) {
        UIButton *btn = [UIButton new];
        [btn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        _functionBtn = btn;
    }
    return _functionBtn;
}
@end
