//
//  MainHandle.m
//  XL_Demos
//
//  Created by zhouxiaolu on 16/6/21.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import "MainHandle.h"
static MainHandle *mainHandle = nil;
@implementation MainHandle
+ (instancetype)defaultHandle
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mainHandle = [[MainHandle alloc] init];
    });
    return mainHandle;
}
@end
