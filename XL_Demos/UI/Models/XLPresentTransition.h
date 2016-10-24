//
//  XLPresentTransition.h
//  XL_Demos
//
//  Created by zhouxiaolu on 16/7/7.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, XLPresentTransitionType) {
    XLPresentTransitionType_Present = 0, // present动画
    XLPresentTransitionType_Dismiss //  dismiss动画
};

@interface XLPresentTransition : NSObject<UIViewControllerAnimatedTransitioning>
@property (nonatomic, assign) XLPresentTransitionType type;
//  枚举初始化
+ (instancetype)transitionWithTransitionType:(XLPresentTransitionType)type;
- (instancetype)initWithTranstionType:(XLPresentTransitionType)type;

@end
