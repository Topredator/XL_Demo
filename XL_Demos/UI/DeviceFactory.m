//
//  DeviceFactory.m
//  XL_Demos
//
//  Created by zhouxiaolu on 16/7/8.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import "DeviceFactory.h"

@implementation DeviceFactory
+ (BaseDevice *)deviceFactoryWithDeviceType:(DeviceType)type
{
    BaseDevice *device = nil;
    if (type == DeviceType_Iphone)
    {
        device = [[IphoneDevice alloc] init];
    }
    else if (type == DeviceType_Android)
    {
        device = [[AndroidDevice alloc] init];
    }
    return device;
}

@end
