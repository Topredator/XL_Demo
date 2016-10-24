//
//  StoreCell.h
//  XL_Demos
//
//  Created by zhouxiaolu on 16/9/6.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DMShopCar;
typedef NS_ENUM(NSInteger, StorecellType) {
    StorecellType_StoreTitle = 0,   //  商店头
    StorecellType_TotalPrice    //  商品总价
};

typedef void(^StoreCellSelectBlock)(DMShopCar *dm, UIButton *btn);
@interface StoreCell : UITableViewCell
@property (nonatomic, copy) StoreCellSelectBlock selectBlock;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier storecellType:(StorecellType)type;
@end
