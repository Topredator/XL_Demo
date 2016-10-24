//
//  ZXL_ConfigInputBoxViewController.h
//  XL_Demos
//
//  Created by zhouxiaolu on 16/8/2.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import "XL_BaseViewController.h"

@protocol ConfigInputBoxDelegate <NSObject>
@optional
- (NSString *)getIntTypeOfInput;
- (NSString *)getTextTypeOfInput;
- (NSString *)getDateTypeOfInput;
@end

typedef NS_ENUM(NSInteger, InputType) {
    InputType_Int,
    InputType_Date,
    InputType_Text
};

typedef void(^ReturnContent)(NSString *string);
@interface ZXL_ConfigInputBoxViewController : UIViewController

@property (nonatomic, weak) id <ConfigInputBoxDelegate> delegate;

@property (nonatomic, copy) void (^ReturnContent)(NSString *string);

+ (void)showConfigInputBox:(UIViewController *)parentVC inputType:(InputType)inputBox returnContent:(ReturnContent)returnContent;
@end
