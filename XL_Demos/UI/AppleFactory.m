//
//  AppleFactory.m
//  XL_Demos
//
//  Created by zhouxiaolu on 16/7/8.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import "AppleFactory.h"

#import "XL_Iphone.h"
#import "XL_Iwatch.h"


@implementation AppleFactory
- (BasePhone *)createPhone
{
    NSLog(@"生产苹果手机");
    return [[XL_Iphone alloc] init];
}
- (BaseWatch *)createWatch
{
    NSLog(@"生产苹果手表");
    return [[XL_Iwatch alloc] init];
}
@end
