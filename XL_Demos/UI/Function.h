//
//  Function.h
//  XL_Demos
//
//  Created by zhouxiaolu on 16/8/30.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Function : NSObject
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *image;

@property(nonatomic,copy)void(^clickAction)(id obj);

+(Function *)FunctionWithName:(NSString *)name AndImage:(NSString *)image AndAction:(void (^)(id obj))action;
+ (Function *)FunctionWithName:(NSString *)name AndImage:(NSString *)image;
@end
