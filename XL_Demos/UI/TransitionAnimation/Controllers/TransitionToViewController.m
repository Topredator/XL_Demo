//
//  TransitionToViewController.m
//  XL_Demos
//
//  Created by zhouxiaolu on 16/7/7.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import "TransitionToViewController.h"
#import "XLPresentTransition.h"
@interface TransitionToViewController ()<UIViewControllerTransitioningDelegate>

@end

@implementation TransitionToViewController
#pragma mark - init method -
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.transitioningDelegate = self;
        self.modalPresentationStyle = UIModalPresentationCustom;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor purpleColor];
    
    
    UILabel *lb = [UILabel new];
    lb.text = @"点任意地方返回";
    lb.textAlignment = NSTextAlignmentCenter;
    lb.textColor = [UIColor whiteColor];
    [self.view addSubview:lb];
    lb.font = kFont(18);
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(200, 30));
    }];
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(returnBack)];
    tapGR.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:tapGR];
}

#pragma mark - private method -
- (void)returnBack
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - UIViewControllerTransitioningDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    //这里我们初始化presentType
    return [XLPresentTransition transitionWithTransitionType:XLPresentTransitionType_Present];
}
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    //这里我们初始化dismissType
    return [XLPresentTransition transitionWithTransitionType:XLPresentTransitionType_Dismiss];
}

@end
