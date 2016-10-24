//
//  TransitionToTwoViewController.m
//  XL_Demos
//
//  Created by zhouxiaolu on 16/7/7.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import "TransitionToTwoViewController.h"
#import "XLPushTransition.h"
@interface TransitionToTwoViewController ()

@end

@implementation TransitionToTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, (kScreenFrame_height - kScreenFrame_width - 64) / 2, kScreenFrame_width, kScreenFrame_width)];
    _imageView.userInteractionEnabled = YES;
    _imageView.layer.cornerRadius = kScreenFrame_width / 2;
    _imageView.layer.masksToBounds = YES;
    _imageView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:_imageView];
//    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(self.view.mas_centerX);
//        make.centerY.mas_equalTo(self.view.mas_centerY);
//        make.size.mas_equalTo(CGSizeMake(kScreenFrame_width, kScreenFrame_width));
//    }];
}

#pragma mark - UIViewControllerTransitioningDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC
{
    return [XLPushTransition transitionWithTransitionType:operation == UINavigationControllerOperationPush ? XLPushTransitionType_Push : XLPushTransitionType_Pop];
}
@end
