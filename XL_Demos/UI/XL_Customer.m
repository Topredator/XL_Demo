//
//  XL_Customer.m
//  XL_Demos
//
//  Created by zhouxiaolu on 16/7/8.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import "XL_Customer.h"

@implementation XL_Customer

- (void)buyProductCount:(NSInteger)count
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(customer:productNum:)]) {
        [self.delegate customer:self productNum:count];
    }
}
@end
