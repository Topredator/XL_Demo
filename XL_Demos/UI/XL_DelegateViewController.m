//
//  XL_DelegateViewController.m
//  XL_Demos
//
//  Created by zhouxiaolu on 16/7/8.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import "XL_DelegateViewController.h"

#import "XL_Customer.h"

@interface XL_DelegateViewController ()<CustomerProtocol>

@end

//  经销商
@implementation XL_DelegateViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    XL_Customer *customer = [[XL_Customer alloc] init];
    customer.name = @"~逗比~";
    customer.delegate = self;
    
    [customer buyProductCount:5];
}

- (void)customer:(XL_Customer *)customer productNum:(NSInteger)productNum
{
    NSLog(@"客户   %@   在本店买了  %ld  件商品", customer.name, productNum);
}
@end
