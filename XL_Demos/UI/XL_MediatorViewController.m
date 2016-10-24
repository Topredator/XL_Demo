//
//  XL_MediatorViewController.m
//  XL_Demos
//
//  Created by zhouxiaolu on 16/7/22.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import "XL_MediatorViewController.h"

#import "Colleague.h"
#import "Mediator.h"

@interface XL_MediatorViewController ()

@end

@implementation XL_MediatorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    Colleague *colleagueA = [[Colleague alloc] init];
    Colleague *colleagueB = [[Colleague alloc] init];
    Colleague *colleagueC = [[Colleague alloc] init];
    
    
    Mediator *mediator = [[Mediator alloc] init];
    mediator.colleagueA = colleagueA;
    mediator.colleagueB = colleagueB;
    mediator.colleagueC = colleagueC;
    
    
    colleagueA.delegate = mediator;
    colleagueB.delegate = mediator;
    colleagueC.delegate = mediator;
    
    [colleagueA changeNum:3];
    
    NSLog(@"%@", [mediator colleagueMessage]);
    
}
@end
