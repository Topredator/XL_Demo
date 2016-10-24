//
//  BaseFactory.h
//  XL_Demos
//
//  Created by zhouxiaolu on 16/7/8.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BasePhone.h"
#import "BaseWatch.h"
@interface BaseFactory : NSObject
//  生产手机
- (BasePhone *)createPhone;
//  生产手表
- (BaseWatch *)createWatch;
@end
