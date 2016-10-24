//
//  SpeedDial.h
//  XL_Demos
//
//  Created by zhouxiaolu on 16/7/25.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SpeedDial.h"

@interface SpeedDial : NSObject

@property (nonatomic, strong) NSMutableArray *dataArr;
- (instancetype)initWithDatadic:(NSDictionary *)dict;

@end
