//
//  XL_CellAdapter.m
//  XL_Demos
//
//  Created by zhouxiaolu on 16/9/28.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import "XL_CellAdapter.h"

@implementation XL_CellAdapter
+ (XL_CellAdapter *)cellAdapterWithCellIndentifier:(NSString *)cellIdentifier data:(id)data cellWidth:(CGFloat)cellWidth cellHeight:(CGFloat)cellHeight cellType:(NSInteger)cellType
{
    XL_CellAdapter *adapter = [[self class] new];
    adapter.cellIdentifier = cellIdentifier;
    adapter.data = data;
    adapter.cellWidth = cellWidth;
    adapter.cellHeight = cellHeight;
    adapter.cellType = cellType;
    return adapter;
}
+ (XL_CellAdapter *)cellAdapterWithCellIndentifier:(NSString *)cellIdentifier data:(id)data cellHeight:(CGFloat)cellHeight cellType:(NSInteger)cellType
{
    XL_CellAdapter *adapter = [[self class] new];
    adapter.cellIdentifier = cellIdentifier;
    adapter.data = data;
    adapter.cellHeight = cellHeight;
    adapter.cellType = cellType;
    return adapter;
}
+ (XL_CellAdapter *)cellAdapterWithCellIndentifier:(NSString *)cellIdentifier data:(id)data cellType:(NSInteger)cellType
{
    XL_CellAdapter *adapter = [[self class] new];
    adapter.cellIdentifier = cellIdentifier;
    adapter.data = data;
    adapter.cellType = cellType;
    return adapter;
}
@end
