//
//  SemaphoreViewController.m
//  XL_Demos
//
//  Created by zhouxiaolu on 16/9/12.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import "SemaphoreViewController.h"

@implementation SemaphoreViewController
#pragma mark - life cycle -
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self configGCDSemaphore];
}
#pragma mark - private method -
- (void)configGCDSemaphore
{
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        //  延时执行
        double delaySecond = 1.f;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delaySecond * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^{
            NSLog(@"A");
            //  signal 释放   信号量 +1
            dispatch_semaphore_signal(semaphore);
        });
        //  wait 当信号量为0 时 无限等待 ， > 0 时，信号量 -1
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    });
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        //  延时执行
        double delaySecond = 1.f;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delaySecond * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^{
            NSLog(@"B");
            dispatch_semaphore_signal(semaphore);
        });
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    });
    //  执行过 A B 后执行
    dispatch_group_notify(group, dispatch_get_global_queue(0, 0), ^{
        NSLog(@"totle ---> C");
    });
    
}
@end
