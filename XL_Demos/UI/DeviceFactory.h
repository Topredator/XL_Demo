//
//  DeviceFactory.h
//  XL_Demos
//
//  Created by zhouxiaolu on 16/7/8.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseDevice.h"
#import "IphoneDevice.h"
#import "AndroidDevice.h"

typedef NS_ENUM(NSInteger, DeviceType) {
    DeviceType_Iphone = 0,
    DeviceType_Android
};


@interface DeviceFactory : NSObject
//  生产设备
+ (BaseDevice *)deviceFactoryWithDeviceType:(DeviceType)type;
@end
