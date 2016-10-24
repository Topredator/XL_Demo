//
//  AbstractColleague.h
//  XL_Demos
//
//  Created by zhouxiaolu on 16/7/22.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AbstractColleague;
@protocol AbstractColleagueDelegate <NSObject>

@optional
/**
 *  同事操作
 *
 *  @param colleague 同事对象
 */
- (void)colleagueEvent:(AbstractColleague *)colleague;
@end

@interface AbstractColleague : NSObject
@property (nonatomic, weak) id <AbstractColleagueDelegate> delegate;
@end
