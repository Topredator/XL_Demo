//
//  DrawCell.h
//  XL_Demos
//
//  Created by zhouxiaolu on 16/9/13.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DMDraw;

typedef void(^DeselecCellBlock)(void);

@interface DrawCell : UITableViewCell
- (void)configDrawCellWithModel:(DMDraw *)model;
/**
 *  展示详情
 *
 *  @param contentOffsetY tableview 偏移量
 */
- (void)selectToShowDrawCellDetailWithContentOffsetY:(CGFloat)contentOffsetY;
- (void)addDeselectCellBlick:(DeselecCellBlock)block;
@end
