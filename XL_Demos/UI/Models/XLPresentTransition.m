//
//  XLPresentTransition.m
//  XL_Demos
//
//  Created by zhouxiaolu on 16/7/7.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import "XLPresentTransition.h"

#import "TransitionFromViewController.h"


@implementation XLPresentTransition

+ (instancetype)transitionWithTransitionType:(XLPresentTransitionType)type
{
    return [[self alloc] initWithTranstionType:type];
}
- (instancetype)initWithTranstionType:(XLPresentTransitionType)type
{
    if (self = [super init]) {
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
        case XLPresentTransitionType_Present:
        {
            [self presentAnimation:transitionContext];
        }
            break;
        case XLPresentTransitionType_Dismiss:
        {
            [self dismissAnimation:transitionContext];
        }
            break;
    }
}



- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    switch (_type) {
        case XLPresentTransitionType_Present:{
            id<UIViewControllerContextTransitioning> transitionContext = [anim valueForKey:@"transitionContext"];
            [transitionContext completeTransition:YES];
            [transitionContext viewControllerForKey:UITransitionContextToViewKey].view.layer.mask = nil;
        }
            break;
        case XLPresentTransitionType_Dismiss:{
            id<UIViewControllerContextTransitioning> transitionContext = [anim valueForKey:@"transitionContext"];
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            if ([transitionContext transitionWasCancelled]) {
                [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer.mask = nil;
            }
        }
            break;
    }
}

//  实现present动画逻辑
- (void)presentAnimation:(id<UIViewControllerContextTransitioning>)transitionContext
{
    //拿到控制器获取button的frame来设置动画的开始结束的路径
    UITabBarController *fromVC = (UITabBarController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    TransitionFromViewController *temp = ((UINavigationController *)fromVC.viewControllers.firstObject).viewControllers.lastObject;
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    //画两个圆路径
    UIBezierPath *startCycle =  [UIBezierPath bezierPathWithOvalInRect:temp.btnFrom];
    //通过如下方法计算获取在x和y方向按钮距离边缘的最大值，然后利用勾股定理即可算出最大半径
    CGFloat x = MAX(temp.btnFrom.origin.x, containerView.frame.size.width - temp.btnFrom.origin.x);
    CGFloat y = MAX(temp.btnFrom.origin.y, containerView.frame.size.height - temp.btnFrom.origin.y);
    //勾股定理计算半径
    CGFloat radius = sqrtf(pow(x, 2) + pow(y, 2));
    //以按钮中心为圆心，按钮中心到屏幕边缘的最大距离为半径，得到转场后的path
    UIBezierPath *endCycle = [UIBezierPath bezierPathWithArcCenter:containerView.center radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    //创建CAShapeLayer进行遮盖
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    //设置layer的path保证动画后layer不会回弹
    maskLayer.path = endCycle.CGPath;
    //将maskLayer作为toVC.View的遮盖
    toVC.view.layer.mask = maskLayer;
    //创建路径动画
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    //动画是加到layer上的，所以必须为CGPath，再将CGPath桥接为OC对象
    maskLayerAnimation.fromValue = (__bridge id)(startCycle.CGPath);
    maskLayerAnimation.toValue = (__bridge id)((endCycle.CGPath));
    maskLayerAnimation.duration = [self transitionDuration:transitionContext];
    maskLayerAnimation.delegate = self;
    //设置淡入淡出
    maskLayerAnimation.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [maskLayerAnimation setValue:transitionContext forKey:@"transitionContext"];
    [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
}
//  实现dismiss动画逻辑
- (void)dismissAnimation:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UITabBarController *toVC = (UITabBarController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    TransitionFromViewController *temp = ((UINavigationController *)toVC.viewControllers.firstObject).viewControllers.lastObject;
    UIView *containerView = [transitionContext containerView];
    //画两个圆路径
    CGFloat radius = sqrtf(containerView.frame.size.height * containerView.frame.size.height + containerView.frame.size.width * containerView.frame.size.width) / 2;
    UIBezierPath *startCycle = [UIBezierPath bezierPathWithArcCenter:containerView.center radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    UIBezierPath *endCycle =  [UIBezierPath bezierPathWithOvalInRect:temp.btnFrom];
    //创建CAShapeLayer进行遮盖
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.fillColor = [UIColor greenColor].CGColor;
    maskLayer.path = endCycle.CGPath;
    fromVC.view.layer.mask = maskLayer;
    //创建路径动画
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.fromValue = (__bridge id)(startCycle.CGPath);
    maskLayerAnimation.toValue = (__bridge id)((endCycle.CGPath));
    maskLayerAnimation.duration = [self transitionDuration:transitionContext];
    maskLayerAnimation.delegate = self;
    maskLayerAnimation.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [maskLayerAnimation setValue:transitionContext forKey:@"transitionContext"];
    [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
}

@end
