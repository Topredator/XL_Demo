//
//  XL_Customer.h
//  XL_Demos
//
//  Created by zhouxiaolu on 16/7/8.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XL_Customer;
@protocol CustomerProtocol <NSObject>
@required
- (void)customer:(XL_Customer *)customer productNum:(NSInteger)productNum;
@end


@interface XL_Customer : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, weak) id <CustomerProtocol> delegate;


//  买商品行为
- (void)buyProductCount:(NSInteger)count;
@end
