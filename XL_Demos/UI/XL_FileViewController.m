//
//  XL_FileViewController.m
//  XL_Demos
//
//  Created by zhouxiaolu on 16/7/21.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import "XL_FileViewController.h"

#import "File.h"
#import "FileCell.h"

@interface XL_FileViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *fileTableView;

@property (nonatomic, strong) File *rootFile;

@end

@implementation XL_FileViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    WS(vs);
    [self.view addSubview:self.fileTableView];
    [_fileTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(vs.view).insets(UIEdgeInsetsZero);
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.rootFile = [File fileWithFileType:FileType_Folder fileName:@"root"];
    
    //  Level - A
    File *folderA = [File fileWithFileType:FileType_Folder fileName:@"Folder-A-1"];
    [self.rootFile addFile:folderA];
    [self.rootFile addFile:[File fileWithFileType:FileType_File fileName:@"File-A-1"]];
    [self.rootFile addFile:[File fileWithFileType:FileType_File fileName:@"File-A-2"]];
    [self.rootFile addFile:[File fileWithFileType:FileType_File fileName:@"File-A-3"]];
    
    //  Level - B
    File *folderB_1 = [File fileWithFileType:FileType_Folder fileName:@"Folder-B-1"];
    [folderA addFile:folderB_1];
    [folderA addFile:[File fileWithFileType:FileType_File fileName:@"File-B-1"]];
    [folderA addFile:[File fileWithFileType:FileType_File fileName:@"File-B-2"]];
    File *folderB_2 = [File fileWithFileType:FileType_Folder fileName:@"Folder-B-2"];
    [folderA addFile:folderB_2];
    
    //  Level - C
    File *folderC_1 = [File fileWithFileType:FileType_Folder fileName:@"Folder-C-1"];
    [folderB_1 addFile:folderC_1];
    [folderB_1 addFile:[File fileWithFileType:FileType_File fileName:@"File-C-1"]];
    
    [folderB_2 addFile:[File fileWithFileType:FileType_File fileName:@"File-C-2"]];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.rootFile.childFiles.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FileCell *cell = [tableView dequeueReusableCellWithIdentifier:[[FileCell class] description]];
    if (!cell) {
        cell = [[FileCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[[FileCell class] description]];
    }
    cell.data = self.rootFile.childFiles[indexPath.row];
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
- (UITableView *)fileTableView
{
    if (!_fileTableView) {
        UITableView *tb = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        tb.dataSource = self;
        tb.delegate = self;
        _fileTableView = tb;
    }
    return _fileTableView;
}

@end
