//
//  Colleague.h
//  XL_Demos
//
//  Created by zhouxiaolu on 16/7/22.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import "AbstractColleague.h"

@interface Colleague : AbstractColleague
@property (nonatomic, assign) float num;

- (void)changeNum:(CGFloat)num;

@end
