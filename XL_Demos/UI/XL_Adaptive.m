//
//  XL_Adaptive.m
//  XL_Demos
//
//  Created by zhouxiaolu on 16/7/15.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import "XL_Adaptive.h"

@implementation XL_Adaptive

- (instancetype)initWithData:(NSDictionary *)dict
{
    self = super.init;
    if (self) {
        _title = dict[@"title"];
        _content = dict[@"content"];
        _username = dict[@"username"];
        _time = dict[@"time"];
        _imageName = dict[@"imageName"];
    }
    return self;
}
@end
