//
//  FactoryManager.m
//  XL_Demos
//
//  Created by zhouxiaolu on 16/7/8.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import "FactoryManager.h"

#import "AppleFactory.h"
#import "AndroidFactory.h"

@implementation FactoryManager

+ (BaseFactory *)managerWithFactoryType:(FactoryType)type
{
    BaseFactory *factory = nil;
    if (type == FactoryType_Iphone)
    {
        factory = [[AppleFactory alloc] init];
    }
    else if (type == FactoryType_Android)
    {
        factory = [[AndroidFactory alloc] init];
    }
    return factory;
}

@end
