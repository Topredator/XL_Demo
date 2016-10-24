//
//  ScreenConditionView.h
//  XL_Demos
//
//  Created by zhouxiaolu on 16/7/27.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ScreenConditionDelegate <NSObject>
@optional
//  时间
//  金额
//  订单
//  积分
//  优惠券
@end

typedef NS_ENUM(NSInteger, ScreenConditionType) {
    ScreenConditionType_Default = 0,
    ScreenConditionType_Time,
    ScreenConditionType_Money,
    ScreenConditionType_Order,
    ScreenConditionType_Integrate,
    ScreenConditionType_Coupon
};

@interface ScreenConditionView : UIView
@property (nonatomic, weak) id <ScreenConditionDelegate> delegate;
- (instancetype)initWithScreenConditionType:(ScreenConditionType)type data:(NSArray *)dataArr pointY:(CGFloat)pointY;
@end
