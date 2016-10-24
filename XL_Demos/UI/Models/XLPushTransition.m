//
//  XLPushTransition.m
//  XL_Demos
//
//  Created by zhouxiaolu on 16/7/7.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import "XLPushTransition.h"

#import "TransitionFromViewController.h"
#import "TransitionToTwoViewController.h"

@implementation XLPushTransition

+ (instancetype)transitionWithTransitionType:(XLPushTransitionType)type
{
    return [[self alloc] initWithTransitionType:type];
}
- (instancetype)initWithTransitionType:(XLPushTransitionType)type
{
    self = [super init];
    if (self) {
        self.type = type;
    }
    return self;
}
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return .5f;
}
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    switch (_type) {
        case XLPushTransitionType_Push:
        {
            [self doPushAnimation:transitionContext];
        }
            break;
        case XLPushTransitionType_Pop:
        {
            [self doPopAnimation:transitionContext];
        }
            break;
    }
}

//  push动画逻辑
- (void)doPushAnimation:(id<UIViewControllerContextTransitioning>)transtionContext
{
    TransitionFromViewController *fromVC = (TransitionFromViewController *)[transtionContext  viewControllerForKey:UITransitionContextFromViewControllerKey];
    TransitionToTwoViewController *toVC = (TransitionToTwoViewController *)[transtionContext     viewControllerForKey:UITransitionContextToViewControllerKey];
    //拿到当前点击的cell的imageView
    UIView *containerView = [transtionContext containerView];
    //snapshotViewAfterScreenUpdates 对pushBtn截图保存成另一个视图用于过渡，并将视图转换到当前控制器的坐标
    UIView *tempView = [fromVC.pushBtn snapshotViewAfterScreenUpdates:NO];
    tempView.frame = [fromVC.pushBtn convertRect:fromVC.pushBtn.bounds toView:containerView];
    //设置动画前的各个控件的状态
    fromVC.pushBtn.hidden = YES;
    toVC.view.alpha = 0;
    toVC.imageView.hidden = YES;
    //tempView 添加到containerView中，要保证在最前方，所以后添加
    [containerView addSubview:toVC.view];
    [containerView addSubview:tempView];
    //开始做动画
    [UIView animateWithDuration:[self transitionDuration:transtionContext] animations:^{
        tempView.frame = [toVC.imageView convertRect:toVC.imageView.bounds toView:containerView];
        toVC.view.alpha = 1;
    } completion:^(BOOL finished) {
        //tempView先隐藏不销毁，pop的时候还会用
        tempView.hidden = YES;
        toVC.imageView.hidden = NO;
        //如果动画过渡取消了就标记不完成，否则才完成，这里可以直接写YES，如果有手势过渡才需要判断，必须标记，否则系统不会中动画完成的部署，会出现无法交互之类的bug
        [transtionContext completeTransition:YES];
    }];
}
//  pop动画逻辑
- (void)doPopAnimation:(id<UIViewControllerContextTransitioning>)transitionContext
{
    TransitionToTwoViewController *fromVC = (TransitionToTwoViewController *)[transitionContext     viewControllerForKey:UITransitionContextFromViewControllerKey];
     TransitionFromViewController *toVC = (TransitionFromViewController *)[transitionContext     viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    //这里的lastView就是push时候初始化的那个tempView
    UIView *tempView = containerView.subviews.lastObject;
    //设置初始状态
    fromVC.imageView.hidden = YES;
    toVC.pushBtn.hidden = YES;
    tempView.hidden = NO;
    [containerView insertSubview:toVC.view atIndex:0];
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        tempView.frame = /*[toVC.pushBtn convertRect:toVC.pushBtn.bounds toView:containerView]*/toVC.btnFrom;
        fromVC.view.alpha = 0;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
        tempView.hidden = YES;
        toVC.pushBtn.hidden = NO;
        [tempView removeFromSuperview];
    }];
}
@end
