//
//  SpeedDial.m
//  XL_Demos
//
//  Created by zhouxiaolu on 16/7/25.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import "SpeedDial.h"

@implementation SpeedDial
- (instancetype)initWithDatadic:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.dataArr = [NSMutableArray arrayWithArray:dict[@"arr"]];
    }
    return self;
}
@end
