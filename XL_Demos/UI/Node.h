//
//  Node.h
//  XL_Demos
//
//  Created by zhouxiaolu on 16/7/21.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Node : NSObject
/**
 *  节点名称
 */
@property (nonatomic, copy) NSString *nodeName;
/**
 *  遍历构造器
 *
 *  @param nodeName 节点名称
 *
 *  @return 节点
 */
+ (instancetype)nodeWithNodeName:(NSString *)nodeName;
/**
 *  存放子节点数组
 */
@property (nonatomic, strong, readonly) NSMutableArray <Node *> *childNodes;

/**
 *  添加子节点
 *
 *  @param node 节点
 */
- (void)addNode:(Node *)node;
/**
 *  删除子节点
 *
 *  @param node 节点
 */
- (void)removeNode:(Node *)node;
/**
 *  得到子节点
 *
 *  @param index 节点位置
 */
- (Node *)getNodeWithIndex:(NSInteger)index;

/**
 *  操作
 */
- (void)operation;
@end
