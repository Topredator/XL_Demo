//
//  CompositeGameHandle.m
//  XL_Demos
//
//  Created by zhouxiaolu on 16/7/23.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import "CompositeGameHandle.h"

@implementation CompositeGameHandle
- (void)compositeOperation
{
    [self left];
    [self up];
    [self right];
    [self down];
    [self commandA];
    [self commandB];
    [self commandX];
    [self commandY];
}
@end
