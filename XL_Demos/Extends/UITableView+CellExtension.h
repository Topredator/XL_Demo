//
//  UITableView+CellExtension.h
//  XL_Demos
//
//  Created by zhouxiaolu on 16/9/28.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BaseCustomeCell;
@class XL_CellAdapter;

@interface CellType : NSObject
@property (nonatomic, copy) NSString *className;
@property (nonatomic, copy) NSString *reuseIdentifier;
+ (instancetype)cellTypeWithClassName:(NSString *)className reuseIdentifer:(NSString *)reuseIdentifier;
+ (instancetype)cellTypeWithClassName:(NSString *)className;
@end
//  内联函数
NS_INLINE CellType *cellClass(NSString *className, NSString *reuseIdentifier)
{
    return [CellType cellTypeWithClassName:className reuseIdentifer:reuseIdentifier.length ? reuseIdentifier : className];
}

@interface UITableView (CellExtension)
//  注册cell
- (void)registerCellClass:(NSArray <CellType *>*)cellClassArray;

/**
 Dequeue and load content

 @param adapter   Adapter
 @param indexPath IndexPath

 @return BaseCustomeCell
 */
- (BaseCustomeCell *)dequeueAndLoadContentReusableCellFromAdapter:(XL_CellAdapter *)adapter
                                                        indexPath:(NSIndexPath *)indexPath;

/**
 Dequeue and load content

 @param adapter    Adapter
 @param indexPath  IndexPath
 @param controller Controller

 @return BaseCustomeCell
 */
- (BaseCustomeCell *)dequeueAndLoadContentReusableCellFromAdapter:(XL_CellAdapter *)adapter
                                                        indexPath:(NSIndexPath *)indexPath
                                                       controller:(UIViewController *)controller;
@end




