//
//  Node.m
//  XL_Demos
//
//  Created by zhouxiaolu on 16/7/21.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import "Node.h"


@interface Node ()
@property (nonatomic, strong) NSMutableArray <Node *> *childNodes;
@end

@implementation Node

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.childNodes = [NSMutableArray array];
    }
    return self;
}
+ (instancetype)nodeWithNodeName:(NSString *)nodeName
{
    Node *node = [[Node alloc] init];
    node.nodeName = nodeName;
    return node;
}
- (void)addNode:(Node *)node
{
    [self.childNodes addObject:node];
}
- (void)removeNode:(Node *)node
{
    [self.childNodes removeObject:node];
}
- (Node *)getNodeWithIndex:(NSInteger)index
{
    if (index >= self.childNodes.count)
        return nil;
    else
        return self.childNodes[index];
}
- (void)operation
{
    NSLog(@"nodeName -- > %@", self.nodeName);
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"[NodeName] -- > %@", self.nodeName];
}

@end
