//
//  BaseCustomeCell.m
//  XL_Demos
//
//  Created by zhouxiaolu on 16/9/28.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import "BaseCustomeCell.h"
#import "XL_CellAdapter.h"


@implementation BaseCustomeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupCell];
        [self buildSubviews];
    }
    return self;
}

//  have to implementation method
- (void)setupCell
{}
- (void)buildSubviews
{}
- (void)loadContent
{}
+ (CGFloat)cellHeightWithData:(id)data
{
    return 0.f;
}
- (void)selectedEvent
{}

- (void)updateWithNewCellHeight:(CGFloat)cellHeight animated:(BOOL)animated
{
    if (_tableView && _adapter) {
        _adapter.cellHeight = cellHeight;
        if (animated)
        {
            [_tableView beginUpdates];
            [_tableView endUpdates];
        }
        else
        {
            [_tableView reloadData];
        }
    }
}

- (void)setWeakReferenceWithCellAdapter:(XL_CellAdapter *)adapter data:(id)data indexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView
{
    _adapter = adapter;
    _data = data;
    _indexPath = indexPath;
    _tableView = tableView;
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
