//
//  XLPushTransition.h
//  XL_Demos
//
//  Created by zhouxiaolu on 16/7/7.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, XLPushTransitionType) {
    XLPushTransitionType_Push = 0, //   push动画
    XLPushTransitionType_Pop // pop动画
};

@interface XLPushTransition : NSObject<UIViewControllerAnimatedTransitioning>
@property (nonatomic, assign) XLPushTransitionType type;

+ (instancetype)transitionWithTransitionType:(XLPushTransitionType)type;
- (instancetype)initWithTransitionType:(XLPushTransitionType)type;
@end
