//
//  Mediator.m
//  XL_Demos
//
//  Created by zhouxiaolu on 16/7/22.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import "Mediator.h"

#import "Colleague.h"

@implementation Mediator
- (void)colleagueEvent:(AbstractColleague *)colleague
{
    if ([colleague isEqual:self.colleagueA]) {
        self.colleagueB.num = self.colleagueA.num * 3;
        self.colleagueC.num = self.colleagueB.num * 3;
    } else if ([colleague isEqual:self.colleagueB]) {
        self.colleagueA.num = self.colleagueB.num / 3;
        self.colleagueC.num = self.colleagueB.num * 3;
    } else if ([colleague isEqual:self.colleagueC]) {
        self.colleagueA.num = self.colleagueC.num / 3 / 3;
        self.colleagueB.num = self.colleagueC.num * 3;
    }
}

- (NSDictionary *)colleagueMessage
{
    return @{@"A" : @(self.colleagueA.num),
                    @"B" : @(self.colleagueB.num),
                    @"C" : @(self.colleagueC.num),};
}
@end
