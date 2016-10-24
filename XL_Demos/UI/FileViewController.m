//
//  FileViewController.m
//  XL_Demos
//
//  Created by zhouxiaolu on 16/7/21.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import "FileViewController.h"

#import "File.h"
#import "FileCell.h"

@interface FileViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation FileViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = self.file.fileName;
    [self.view addSubview:self.tableView];
    WS(vs);
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(vs.view).insets(UIEdgeInsetsZero);
    }];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.file.childFiles.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FileCell *cell = [tableView dequeueReusableCellWithIdentifier:[[FileCell class] description]];
    if (!cell) {
        cell = [[FileCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[[FileCell class] description]];
    }
    
    cell.data = self.file.childFiles[indexPath.row];
    cell.viewController = self;
    [cell configFileContent];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 15 + 50 + 5 + 20 + 15;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return .1f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .1f;
}
#pragma mark - setter and getter method -
- (UITableView *)tableView
{
    if (!_tableView) {
        UITableView *tb = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        tb.dataSource = self;
        tb.delegate = self;
        _tableView = tb;
    }
    return _tableView;
}


@end
