//
//  XL_DecoratorViewController.m
//  XL_Demos
//
//  Created by zhouxiaolu on 16/7/22.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import "XL_DecoratorViewController.h"

#import "GameHandle.h"
#import "PS4_GameHandle.h"
#import "CompositeGameHandle.h"

@interface XL_DecoratorViewController ()

@end

@implementation XL_DecoratorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //  GameHandle
    GameHandle *handle = [GameHandle new];
    [handle up];
    [handle down];
    [handle left];
    [handle right];
    NSLog(@"\n");
    NSLog(@"\n");
    PS4_GameHandle *ps4 = [PS4_GameHandle new];
    [ps4 cheat];
    NSLog(@"\n");
    NSLog(@"\n");
    CompositeGameHandle *compositeHandle = [CompositeGameHandle new];
    [compositeHandle compositeOperation];
    
}
@end
