//
//  PS4_GameHandle.h
//  XL_Demos
//
//  Created by zhouxiaolu on 16/7/22.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface PS4_GameHandle : NSObject

- (void)up;
- (void)down;
- (void)left;
- (void)right;

- (void)start;
- (void)stop;

- (void)commandA;
- (void)commandB;
- (void)commandX;
- (void)commandY;

- (void)cheat;


@end
