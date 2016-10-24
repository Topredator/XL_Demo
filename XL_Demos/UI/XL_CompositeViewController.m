//
//  XL_CompositeViewController.m
//  XL_Demos
//
//  Created by zhouxiaolu on 16/7/21.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import "XL_CompositeViewController.h"

#import "Node.h"

@interface XL_CompositeViewController ()

@property (nonatomic, strong) Node *rootNode;
@end

@implementation XL_CompositeViewController
- (void)setNavigationBarAction
{
    [super setNavigationBarAction];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    /**
     *  组合模式，将对象组合成树形结构以表示“部分-整体”的层次结构，组合模式使得用户对单个对象和组合对象的使用具有一致性。掌握组合模式的重点是要理解清楚 “部分/整体” 还有 ”单个对象“ 与 "组合对象" 的含义。
     */
    
    //  根节点
    self.rootNode = [Node nodeWithNodeName:@"A"];
    
    //一级节点
    //  A --> B、C、D
    [self.rootNode addNode:[Node nodeWithNodeName:@"B"]];
    Node *C = [Node nodeWithNodeName:@"C"];
    [self.rootNode addNode:C];
    [self.rootNode addNode:[Node nodeWithNodeName:@"D"]];
    
    NSLog(@"A -- > %@", self.rootNode.childNodes);
    //  二级节点
    //  C --> E、F
    [C addNode:[Node nodeWithNodeName:@"E"]];
    [C addNode:[Node nodeWithNodeName:@"F"]];
    
    NSLog(@"C -- > %@", C.childNodes);
    
}

@end
