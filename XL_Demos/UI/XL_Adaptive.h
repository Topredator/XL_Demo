//
//  XL_Adaptive.h
//  XL_Demos
//
//  Created by zhouxiaolu on 16/7/15.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XL_Adaptive : NSObject
@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSString *content;
@property (nonatomic, copy, readonly) NSString *username;
@property (nonatomic, copy, readonly) NSString *time;
@property (nonatomic, copy, readonly) NSString *imageName;


- (instancetype)initWithData:(NSDictionary  *)dict;
@end
