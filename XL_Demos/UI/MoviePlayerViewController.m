//
//  MoviePlayerViewController.m
//  XL_Demos
//
//  Created by zhouxiaolu on 16/9/21.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import "MoviePlayerViewController.h"
#import "XL_TVPlayerViewController.h"


@interface MoviePlayerViewController ()

@end

@implementation MoviePlayerViewController
#pragma mark - life cycle method -
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *btn = [UIButton new];
    [btn setTitle:@"点我播放" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor purpleColor]];
    btn.titleLabel.font = kFont(17);
    btn.layer.cornerRadius = 50.f;
    btn.layer.masksToBounds = YES;
    [btn addTarget:self action:@selector(presentTVPlayer) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    WS(vs);
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(vs.view.mas_centerX);
        make.centerY.equalTo(vs.view.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    
}
- (void)presentTVPlayer
{
    XL_TVPlayerViewController *playerVC = [XL_TVPlayerViewController new];
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"chenyifaer" withExtension:@"mp4"];
    playerVC.addressURL = url;
    [self presentViewController:playerVC animated:YES completion:nil];
}
@end
