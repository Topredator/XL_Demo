//
//  XLTabbarSelectTransition.m
//  XL_Demos
//
//  Created by zhouxiaolu on 16/7/12.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import "XLTabbarSelectTransition.h"

#import "XL_BaseViewController.h"
@implementation XLTabbarSelectTransition
- (instancetype)initWithSelectTransition
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
+ (instancetype)tabbarSelectTranstion
{
    return [[self alloc] initWithSelectTransition];
}

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return .5f;
}
// This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    XL_BaseViewController *fromVC = (XL_BaseViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    XL_BaseViewController *toVC = (XL_BaseViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    
    [UIView transitionFromView:fromVC.view
                        toView:toVC.view
                      duration:[self transitionDuration:transitionContext]
                       options:UIViewAnimationOptionTransitionCurlUp
                    completion:^(BOOL finished) {
                        [transitionContext completeTransition:YES];
                    }];
}

@end
