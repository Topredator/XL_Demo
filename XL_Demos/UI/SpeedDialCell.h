//
//  SpeedDialCell.h
//  XL_Demos
//
//  Created by zhouxiaolu on 16/7/18.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpeedDial.h"
@interface SpeedDialCell : UITableViewCell
@property (nonatomic, strong) SpeedDial *speedDial;
@property (nonatomic, strong) NSArray *dataArr;
@end
