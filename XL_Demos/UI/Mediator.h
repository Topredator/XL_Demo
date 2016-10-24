//
//  Mediator.h
//  XL_Demos
//
//  Created by zhouxiaolu on 16/7/22.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import "AbstractMediator.h"

@class Colleague;

@interface Mediator : AbstractMediator

@property (nonatomic, strong) Colleague  *colleagueA;
@property (nonatomic, strong) Colleague  *colleagueB;
@property (nonatomic, strong) Colleague  *colleagueC;
@end
