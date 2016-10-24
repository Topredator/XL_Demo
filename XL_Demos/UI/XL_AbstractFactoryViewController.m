//
//  XL_AbstractFactoryViewController.m
//  XL_Demos
//
//  Created by zhouxiaolu on 16/7/8.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import "XL_AbstractFactoryViewController.h"

#import "FactoryManager.h"
#import "BaseFactory.h"


@implementation XL_AbstractFactoryViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    BaseFactory *factory = [FactoryManager managerWithFactoryType:FactoryType_Iphone];
    [factory createPhone];
    [factory createWatch];
}
@end
