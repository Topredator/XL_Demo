//
//  XLTabbarSelectTransition.h
//  XL_Demos
//
//  Created by zhouxiaolu on 16/7/12.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XLTabbarSelectTransition : NSObject<UIViewControllerAnimatedTransitioning>

//  初始化
+ (instancetype)tabbarSelectTranstion;
- (instancetype)initWithSelectTransition;
@end
