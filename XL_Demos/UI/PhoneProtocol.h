//
//  PhoneProtocol.h
//  XL_Demos
//
//  Created by zhouxiaolu on 16/7/8.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PhoneProtocol <NSObject>
@required
//  打电话
- (void)phoneCall;
//  发短信
- (void)sendMessages;
@end
