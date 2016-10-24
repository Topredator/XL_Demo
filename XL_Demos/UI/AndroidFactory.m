//
//  AndroidFactory.m
//  XL_Demos
//
//  Created by zhouxiaolu on 16/7/8.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import "AndroidFactory.h"
#import "XL_Android.h"
#import "XL_AndroidWatch.h"
@implementation AndroidFactory
- (BasePhone *)createPhone
{
    NSLog(@"生产安卓手机");
    return [[XL_Android alloc] init];
}
- (BaseWatch *)createWatch
{
    NSLog(@"生产安卓手表");
    return [[XL_AndroidWatch alloc] init];
}
@end
