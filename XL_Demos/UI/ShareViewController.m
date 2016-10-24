//
//  ShareViewController.m
//  XL_Demos
//
//  Created by zhouxiaolu on 16/8/30.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import "ShareViewController.h"
#import "XL_CustomeShareViewController.h"
#import "Function.h"
@interface ShareViewController ()<CustomeShareDelegate>

@end

@implementation ShareViewController
#pragma mark - life cycle method -
- (void)viewDidLoad {
    [super viewDidLoad];
    [self customeSubview];
}
#pragma mark - CustomeShareDelegate -
- (NSMutableArray *)getShareDataArr
{
    NSMutableArray *mArr = [NSMutableArray array];
    [mArr addObject:[Function FunctionWithName:@"微信好友" AndImage:@"weixin_friend" AndAction:^(id obj) {
        NSLog(@"微信好友");
    }]];
    [mArr addObject:[Function FunctionWithName:@"朋友圈" AndImage:@"weixin_group" AndAction:^(id obj) {
        NSLog(@"朋友圈");
    }]];
    [mArr addObject:[Function FunctionWithName:@"QQ好友" AndImage:@"share_qq" AndAction:^(id obj) {
        NSLog(@"QQ好友");
    }]];
    [mArr addObject:[Function FunctionWithName:@"QQ空间" AndImage:@"share_kongjian" AndAction:^(id obj) {
        NSLog(@"QQ空间");
    }]];
    [mArr addObject:[Function FunctionWithName:@"复制链接" AndImage:@"shareLink" AndAction:^(id obj) {
        NSLog(@"复制链接");
    }]];
    return mArr;
}
#pragma mark - event method -
- (void)clickBtnAction:(UIButton *)btn
{
    [XL_CustomeShareViewController customeShareViewController:self dataDictionary:@{} showType:ShowType_Share];
}
#pragma mark - private method -
- (void)customeSubview
{
    UIButton *clickBtn = [UIButton new];
    [clickBtn setTitle:@"点我分享" forState:UIControlStateNormal];
    [clickBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [clickBtn setBackgroundColor:[UIColor hexChangeFloat:@"ff5607"]];
    clickBtn.layer.cornerRadius = 4.f;
    clickBtn.layer.masksToBounds = YES;
    [clickBtn addTarget:self action:@selector(clickBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:clickBtn];
    WS(vs);
    [clickBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(vs.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(100, 35));
        make.top.equalTo(vs.view).offset(100);
    }];
}
@end
