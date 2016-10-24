//
//  PS4_GameHandle.m
//  XL_Demos
//
//  Created by zhouxiaolu on 16/7/22.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import "PS4_GameHandle.h"
#import "GameHandle.h"

@interface PS4_GameHandle ()
@property (nonatomic, strong) GameHandle *handle;
@end

@implementation PS4_GameHandle
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.handle = [[GameHandle alloc] init];
    }
    return self;
}


- (void)up
{
    [self.handle up];
}
- (void)down
{
    [self.handle down];
}
- (void)left
{
    [self.handle left];
}
- (void)right
{
    [self.handle right];
}

- (void)start
{
    [self.handle start];
}
- (void)stop
{
    [self.handle stop];
}

- (void)commandA
{
    [self.handle commandA];
}
- (void)commandB
{
    [self.handle commandB];
}
- (void)commandX
{
    [self.handle commandX];
}
- (void)commandY
{
    [self.handle commandY];
}

- (void)cheat
{
    [self.handle left];
    [self.handle down];
    [self.handle right];
    [self.handle commandA];
}


@end
