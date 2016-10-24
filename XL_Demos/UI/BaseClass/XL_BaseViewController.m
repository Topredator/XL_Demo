//
//  XL_BaseViewController.m
//  XL_Demos
//
//  Created by zhouxiaolu on 16/6/20.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import "XL_BaseViewController.h"

@interface XL_BaseViewController ()

@end

@implementation XL_BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    [self setNavigationBarAction];
}
#pragma mark - private methods -
- (void)setNavigationBarAction
{
    if (!self.navigationController) return;
}

@end
