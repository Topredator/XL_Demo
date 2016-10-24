//
//  TransitionFromViewController.m
//  XL_Demos
//
//  Created by zhouxiaolu on 16/7/7.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import "TransitionFromViewController.h"

#import "TransitionToViewController.h"
#import "TransitionToTwoViewController.h"

#import "XLPushTransition.h"
@interface TransitionFromViewController ()

@end

@implementation TransitionFromViewController
@synthesize presentBtn;
@synthesize pushBtn;
#pragma mark - life cycle methods-
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    WS(vs);
    self.presentBtn = [UIButton new];
    [presentBtn setTitle:@"Present" forState:UIControlStateNormal];
    [presentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    presentBtn.backgroundColor = [UIColor blueColor];
    [presentBtn addTarget:self action:@selector(presentBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    presentBtn.layer.cornerRadius = 50.f;
    presentBtn.layer.masksToBounds = YES;
    [self.view addSubview:presentBtn];
    
    [presentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(vs.view.mas_centerX);
        make.centerY.equalTo(vs.view.mas_centerY).offset(-80);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    
    self.pushBtn = [UIButton new];
    [pushBtn setTitle:@"Push" forState:UIControlStateNormal];
    [pushBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    pushBtn.backgroundColor = [UIColor blueColor];
    [pushBtn addTarget:self action:@selector(pushBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    pushBtn.layer.cornerRadius = 50.f;
    pushBtn.layer.masksToBounds = YES;
    [self.view addSubview:pushBtn];
    [pushBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(vs.view.mas_centerX);
        make.centerY.equalTo(vs.view.mas_centerY).offset(80);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
}


#pragma mark - event methods -
- (void)presentBtnAction:(UIButton *)btn
{
    self.btnFrom = CGRectMake(self.view.centerX - 50, self.view.centerY - 130, btn.size.width, btn.size.height);
    TransitionToViewController *toVC = [[TransitionToViewController alloc] init];
    [self presentViewController:toVC animated:YES completion:nil];
}
- (void)pushBtnAction:(UIButton *)btn
{
    self.btnFrom = CGRectMake(self.view.centerX - 50, self.view.centerY + 30, btn.size.width, btn.size.height);
    TransitionToTwoViewController *toVC = [[TransitionToTwoViewController alloc] init];
    toVC.title = @"Push";
    self.navigationController.delegate = toVC;
    [self.navigationController pushViewController:toVC animated:YES];
}


@end
