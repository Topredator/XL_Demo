//
//  Colleague.m
//  XL_Demos
//
//  Created by zhouxiaolu on 16/7/22.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import "Colleague.h"

@implementation Colleague
- (void)changeNum:(CGFloat)num
{
    self.num = num;
    if (self.delegate && [self.delegate respondsToSelector:@selector(colleagueEvent:)]) {
        [self.delegate colleagueEvent:self];
    }
}
@end
