//
//  FileCell.h
//  XL_Demos
//
//  Created by zhouxiaolu on 16/7/21.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FileCell : UITableViewCell

@property (nonatomic, weak) id data;
@property (nonatomic, weak) UIViewController *viewController;
/**
 *  设置
 */
- (void)configFileContent;
@end
