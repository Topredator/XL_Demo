//
//  GameHandle.m
//  XL_Demos
//
//  Created by zhouxiaolu on 16/7/22.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import "GameHandle.h"

@implementation GameHandle
- (void)up
{
    NSLog(@"↑");
}
- (void)down
{
    NSLog(@"↓");
}
- (void)left
{
    NSLog(@"←");
}
- (void)right
{
    NSLog(@"→");
}

- (void)start
{
    NSLog(@"start");
}
- (void)stop
{
    NSLog(@"stop");
}

- (void)commandA
{
    NSLog(@"A");
}
- (void)commandB
{
    NSLog(@"B");
}
- (void)commandX
{
    NSLog(@"X");
}
- (void)commandY
{
    NSLog(@"Y");
}
@end
