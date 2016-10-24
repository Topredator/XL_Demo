//
//  TransitionToTwoViewController.h
//  XL_Demos
//
//  Created by zhouxiaolu on 16/7/7.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import "XL_BaseViewController.h"

@interface TransitionToTwoViewController : XL_BaseViewController<UINavigationControllerDelegate>
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic) CGRect imageRect;
@end
