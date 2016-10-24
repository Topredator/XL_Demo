//
//  BaseCustomeCell.h
//  XL_Demos
//
//  Created by zhouxiaolu on 16/9/28.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XL_CellAdapter;
@class BaseCustomeCell;

@protocol BaseCustomeCellDelegate <NSObject>
@optional

@end


@interface BaseCustomeCell : UITableViewCell
@property (nonatomic, weak) id  <BaseCustomeCellDelegate> delegate;
@property (nonatomic, weak) XL_CellAdapter *adapter;
@property (nonatomic, weak) id data;
@property (nonatomic, weak) NSIndexPath *indexPath;
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) UIViewController *controller;

#pragma mark - Method with must be overwrite
- (void)setupCell;
- (void)buildSubviews;
- (void)loadContent;
+ (CGFloat)cellHeightWithData:(id)data;

#pragma mark - Userful method 
- (void)updateWithNewCellHeight:(CGFloat)cellHeight animated:(BOOL)animated;
- (void)selectedEvent;


/**
 convenient method to set some weak reference

 @param dataAdapter cellAdapter object
 @param data        data
 @param indexPath   IndexPath
 @param tableView   TableView
 */
- (void)setWeakReferenceWithCellAdapter:(XL_CellAdapter *)adapter
                                                data:(id)data
                                  indexPath:(NSIndexPath *)indexPath
                                    tableView:(UITableView *)tableView;

@end
