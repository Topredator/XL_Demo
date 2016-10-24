//
//  XL_CellAdapter.h
//  XL_Demos
//
//  Created by zhouxiaolu on 16/9/28.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface XL_CellAdapter : NSObject
@property (nonatomic, copy) NSString *cellIdentifier;
@property (nonatomic, strong) id data;
@property (nonatomic, assign) CGFloat cellWidth;
@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) NSInteger cellType;

#pragma mark - Optional properties
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) UICollectionView *collectView;
@property (nonatomic, weak) NSIndexPath *indexPath;

#pragma mark - Constructor method
+ (XL_CellAdapter *)cellAdapterWithCellIndentifier:(NSString *)cellIdentifier
                                              data:(id)data
                                         cellWidth:(CGFloat)cellWidth
                                        cellHeight:(CGFloat)cellHeight
                                          cellType:(NSInteger)cellType;
+ (XL_CellAdapter *)cellAdapterWithCellIndentifier:(NSString *)cellIdentifier
                                              data:(id)data
                                        cellHeight:(CGFloat)cellHeight
                                        cellType:(NSInteger)cellType;


+ (XL_CellAdapter *)cellAdapterWithCellIndentifier:(NSString *)cellIdentifier
                                              data:(id)data
                                          cellType:(NSInteger)cellType;

@end
