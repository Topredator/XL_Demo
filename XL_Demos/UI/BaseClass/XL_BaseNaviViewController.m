//
//  XL_BaseNaviViewController.m
//  XL_Demos
//
//  Created by zhouxiaolu on 16/6/20.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import "XL_BaseNaviViewController.h"

@interface XL_BaseNaviViewController ()

@end

@implementation XL_BaseNaviViewController

- (instancetype)init
{
    if (self) {
        [self setUpNavigationBar];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.titleStr && self.titleStr.length)
        self.title = self.titleStr;
}
- (void)setUpNavigationBar
{
    self.navigationBar.translucent = NO;
}
- (void)setTitleStr:(NSString *)titleStr
{
    _titleStr = titleStr;
    self.title = titleStr;
}

@end
