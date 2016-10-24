//
//  AbstractMediator.h
//  XL_Demos
//
//  Created by zhouxiaolu on 16/7/22.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractColleague.h"

@interface AbstractMediator : NSObject<AbstractColleagueDelegate>
/**
 *  存储colleague 的相关信息
 */
@property (nonatomic, strong) NSDictionary *colleagueMessage;
@end
