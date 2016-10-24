//
//  XL_BaseNaviViewController.h
//  XL_Demos
//
//  Created by zhouxiaolu on 16/6/20.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XL_BaseNaviViewController : UINavigationController
@property (nonatomic, copy) NSString *titleStr;
- (void)setUpNavigationBar;
@end
