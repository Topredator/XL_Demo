//
//  BaseDm.h
//  XL_Demos
//
//  Created by zhouxiaolu on 16/9/1.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface BaseDm : NSObject
/**
 *  初始化
 *
 *  @param dic 对象字典
 *
 *  @return 对象
 */
- (instancetype)initWithDic:(NSDictionary *)dic;

-(NSDictionary *)convertFromDic:(NSDictionary *)obj;
/**
 *  对象转字典
 *
 *  @return 对象字典
 */
-(NSMutableDictionary *)convertToDic;
@end
