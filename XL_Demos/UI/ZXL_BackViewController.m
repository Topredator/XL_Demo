//
//  ZXL_BackViewController.m
//  XL_Demos
//
//  Created by zhouxiaolu on 16/8/2.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import "ZXL_BackViewController.h"

#import "ZXL_ConfigInputBoxViewController.h"

@interface ZXL_BackViewController ()

@end

@implementation ZXL_BackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    WS(vs);
    UIButton *btn = [UIButton new];
    [btn setTitle:@"点我" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor purpleColor]];
    [btn addTarget:self action:@selector(showConfigInputBox) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(vs.view.mas_centerX);
        make.centerY.equalTo(vs.view.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(150, 40));
    }];
}
#pragma mark - event method -
- (void)showConfigInputBox
{
    [ZXL_ConfigInputBoxViewController showConfigInputBox:self inputType:InputType_Int returnContent:^(NSString *string) {
        
    }];
}
@end
