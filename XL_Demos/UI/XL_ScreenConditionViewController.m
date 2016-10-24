//
//  XL_ScreenConditionViewController.m
//  XL_Demos
//
//  Created by zhouxiaolu on 16/7/27.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import "XL_ScreenConditionViewController.h"

#import "ScreenConditionView.h"

@interface XL_ScreenConditionViewController ()

@end

@implementation XL_ScreenConditionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSArray *arr = @[@"全部", @"100-500元", @"501-1000元", @"1001-2000元", @"自定义"];
    ScreenConditionView *conditionView = [[ScreenConditionView alloc] initWithScreenConditionType:ScreenConditionType_Money data:arr pointY:80];
    conditionView.backgroundColor = [UIColor redColor];
    [self.view addSubview:conditionView];
    
    NSArray *arr1 = @[@"全部", @"今日", @"昨日", @"最近7天", @"最近30天", @"自定义"];
    ScreenConditionView *conditionView1 = [[ScreenConditionView alloc] initWithScreenConditionType:ScreenConditionType_Time data:arr1 pointY:CGRectGetMaxY(conditionView.frame) + 15];
    conditionView1.backgroundColor = [UIColor redColor];
    [self.view addSubview:conditionView1];
}




@end
