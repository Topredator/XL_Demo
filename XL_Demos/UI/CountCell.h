//
//  CountCell.h
//  XL_Demos
//
//  Created by zhouxiaolu on 16/8/31.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CountCell : UITableViewCell
/**
 *  初始化
 *
 *  @param style           cell类型
 *  @param reuseIdentifier 标识符
 *  @param cellWidth       cell 宽度
 *
 *  @return cell
 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
                    cellWidth:(CGFloat)cellWidth;

- (void)configCellWithData:(NSNumber *)num;
@end
