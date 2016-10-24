//
//  XL_FactoryViewController.m
//  XL_Demos
//
//  Created by zhouxiaolu on 16/7/8.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import "XL_FactoryViewController.h"

#import "DeviceFactory.h"
#import "BaseDevice.h"
#import "IphoneDevice.h"
#import "AndroidDevice.h"

@implementation XL_FactoryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    IphoneDevice *device = (IphoneDevice *)[DeviceFactory deviceFactoryWithDeviceType:DeviceType_Iphone];
    [device fingerprintIdentification];
    [device phoneCall];
    [device sendMessages];
}
@end
