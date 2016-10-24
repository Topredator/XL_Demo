//
//  Function.m
//  XL_Demos
//
//  Created by zhouxiaolu on 16/8/30.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import "Function.h"

@implementation Function
+ (Function *)FunctionWithName:(NSString *)name AndImage:(NSString *)image{
    Function *dm = [[Function alloc] init];
    dm.name = name;
    dm.image = image;
    return dm;
}

+(Function *)FunctionWithName:(NSString *)name AndImage:(NSString *)image AndAction:(void (^)(id obj))action
{
    Function *dm = [[Function alloc] init];
    dm.name = name;
    dm.image = image;
    dm.clickAction = action;
    return dm;
}
@end
