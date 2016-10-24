//
//  FactoryManager.h
//  XL_Demos
//
//  Created by zhouxiaolu on 16/7/8.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BaseFactory.h"

typedef NS_ENUM(NSInteger, FactoryType) {
    FactoryType_Iphone = 0,
    FactoryType_Android
};
@interface FactoryManager : NSObject
//  创建工厂
+ (BaseFactory *)managerWithFactoryType:(FactoryType)type;

@end
