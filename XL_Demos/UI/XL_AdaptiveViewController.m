//
//  XL_AdaptiveViewController.m
//  XL_Demos
//
//  Created by zhouxiaolu on 16/7/15.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import "XL_AdaptiveViewController.h"

#import "UITableView+FDTemplateLayoutCell.h"
#import "XL_Adaptive.h"
#import "XL_AdaptiveCell.h"


#define kCellIdentifier  @"Topredator"

@interface XL_AdaptiveViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *myTableview;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, copy) NSArray *jsonArr;
@end

@implementation XL_AdaptiveViewController
#pragma mark - life cycle method -

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    WS(vs);
    [self.view addSubview:self.myTableview];
    self.myTableview.fd_debugLogEnabled = YES;
    [self.myTableview registerClass:[XL_AdaptiveCell class] forCellReuseIdentifier:kCellIdentifier];
    [_myTableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(vs.view).insets(UIEdgeInsetsZero);
    }];
    [self configTestData:^{
        self.dataArr = @[].mutableCopy;
        [self.dataArr addObjectsFromArray:self.jsonArr];
        [self.myTableview reloadData];
    }];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

#pragma mark - private method -
- (void)configTestData:(void (^) (void))test
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // Data from `data.json`
        NSString *dataFilePath = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:dataFilePath];
        NSDictionary *rootDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *feedDicts = rootDict[@"feed"];
        
        // Convert to `FDFeedEntity`
        NSMutableArray *entities = @[].mutableCopy;
        [feedDicts enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [entities addObject:[[XL_Adaptive alloc] initWithData:obj]];
        }];
        self.jsonArr = entities;
        dispatch_async(dispatch_get_main_queue(), ^{
            !test ? : test();
        });
    });
}
- (void)configureCell:(XL_AdaptiveCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.fd_enforceFrameLayout = NO; // Enable to use "-sizeThatFits:"
    cell.adaptive = self.dataArr[indexPath.row];
}


#pragma mark - tableview datasource and delegate -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XL_AdaptiveCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableView fd_heightForCellWithIdentifier:kCellIdentifier cacheByIndexPath:indexPath configuration:^(XL_AdaptiveCell *cell) {
        [self configureCell:cell atIndexPath:indexPath];
    }];

}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return .1f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .1f;
}
#pragma mark - setter and getter methods -
- (UITableView *)myTableview
{
    if (!_myTableview) {
        UITableView *tb = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        tb.dataSource = self;
        tb.delegate = self;
        _myTableview = tb;
    }
    return _myTableview;
}
@end
