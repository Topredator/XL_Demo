//
//  XL_CustomeShareViewController.h
//  XL_Demos
//
//  Created by zhouxiaolu on 16/8/30.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ShowType) {
    ShowType_Default = 0x00,
    ShowType_Share
};

@protocol CustomeShareDelegate <NSObject>
@required
- (NSMutableArray *)getShareDataArr;
@end


@interface XL_CustomeShareViewController : UIViewController
@property (nonatomic, assign) id <CustomeShareDelegate> delegate;
/**
 *  展示
 *
 *  @param parentViewController 父控制器
 *  @param dataDictionary       传入的数据
 *  @param showType             展示的类型
 */
+ (void)customeShareViewController:(UIViewController *)parentViewController
                    dataDictionary:(NSDictionary *)dataDictionary
                          showType:(ShowType)showType;
@end
