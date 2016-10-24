//
//  UITableView+CellExtension.m
//  XL_Demos
//
//  Created by zhouxiaolu on 16/9/28.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import "UITableView+CellExtension.h"
#import "XL_CellAdapter.h"
#import "BaseCustomeCell.h"


@implementation UITableView (CellExtension)
- (void)registerCellClass:(NSArray<CellType *> *)cellClassArray
{
    for (CellType *type in cellClassArray) {
        [self registerClass:NSClassFromString(type.className) forCellReuseIdentifier:type.reuseIdentifier];
    }
}
- (BaseCustomeCell *)dequeueAndLoadContentReusableCellFromAdapter:(XL_CellAdapter *)adapter indexPath:(NSIndexPath *)indexPath
{
    BaseCustomeCell *cell = [self dequeueReusableCellWithIdentifier:adapter.cellIdentifier];
    [cell setWeakReferenceWithCellAdapter:adapter data:adapter.data indexPath:indexPath tableView:self];
    [cell loadContent];
    return cell;
}
- (BaseCustomeCell *)dequeueAndLoadContentReusableCellFromAdapter:(XL_CellAdapter *)adapter indexPath:(NSIndexPath *)indexPath controller:(UIViewController *)controller
{
    BaseCustomeCell *cell = [self dequeueReusableCellWithIdentifier:adapter.cellIdentifier];
    cell.controller = controller;
    [cell setWeakReferenceWithCellAdapter:adapter data:adapter.data indexPath:indexPath tableView:self];
    [cell loadContent];
    return cell;
}
@end
@implementation CellType

+ (instancetype)cellTypeWithClassName:(NSString *)className reuseIdentifer:(NSString *)reuseIdentifier
{
    NSParameterAssert(NSClassFromString(className));
    CellType *type = [[self class] new];
    type.className = className;
    type.reuseIdentifier = reuseIdentifier;
    return type;
}
+ (instancetype)cellTypeWithClassName:(NSString *)className
{
    NSParameterAssert(NSClassFromString(className));
    CellType *type = [[self class] new];
    type.className = className;
    type.reuseIdentifier = className;
    return type;
}
@end
