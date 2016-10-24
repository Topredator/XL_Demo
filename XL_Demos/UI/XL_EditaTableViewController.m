//
//  XL_EditaTableViewController.m
//  XL_Demos
//
//  Created by zhouxiaolu on 16/7/23.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import "XL_EditaTableViewController.h"


#define kHeadView_Height  160

@interface XL_EditaTableViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *editTableView;
@property (nonatomic, strong) NSMutableArray *datasArr;
@property (nonatomic, strong) UILabel *userNameLabel;
@property (nonatomic, strong) UILabel *introduceLabel;
@property (nonatomic, strong) UIView *headBackView;

@property (nonatomic, strong) UIImageView *headView;
@end

@implementation XL_EditaTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    NSArray *arr = @[@"皑如山上雪，皎若云间月",
                                @"闻君有两意，故来相决绝",
                                @"今日斗酒会，明旦沟水头",
                                @"躞蹀御沟上，沟水东西流",
                                @"凄凄复凄凄，嫁娶不须啼",
                                @"愿得一人心，白首不相离",
                                @"竹竿何袅袅，鱼尾何簁簁",
                                @"男儿重意气，何用钱刀为"];
    self.datasArr = [NSMutableArray arrayWithArray:arr];
    [self loadHeadView];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    WS(vs);
    [self.view addSubview:self.editTableView];
    [_editTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(vs.view).insets(UIEdgeInsetsZero);
    }];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
- (void)loadHeadView
{
    
    self.headView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenFrame_width, kHeadView_Height)];
    self.headView.contentMode = UIViewContentModeScaleToFill;
    self.headView.image = [UIImage imageNamed:@"appicon120"];
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    UIVisualEffectView *effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
    effectview.frame = CGRectMake(0, 0, CGRectGetWidth(_headView.frame), CGRectGetHeight(_headView.frame));
    effectview.alpha = 1;
    [self.headView addSubview:effectview];
    self.headBackView = [UIView new];
    //    背景图
    _headBackView.frame = CGRectMake(0, 0, kScreenFrame_width, kHeadView_Height);
    
    [self.headView addSubview:self.headBackView];
    
    UIImageView *head = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenFrame_width - 62)/2, 15 , 62 , 62 )];
    head.image = [UIImage imageNamed:@"appicon120"];
    [self.headView addSubview:head];
    head.layer.cornerRadius = 31 ;
    head.layer.masksToBounds = YES;
    
    
    self.userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, head.frame.origin.y + head.frame.size.height + 8 , kScreenFrame_width, 20 )];
    _userNameLabel.font = [UIFont fontWithName:@"iconfont" size:16 ];
    _userNameLabel.text = @"纳兰性德";
    _userNameLabel.textAlignment = 1;
    _userNameLabel.font = [UIFont systemFontOfSize:16  ];
    _userNameLabel.textColor = [UIColor whiteColor];
    [_headView addSubview:_userNameLabel];
    
    self.introduceLabel = [[UILabel alloc] initWithFrame:CGRectMake((kScreenFrame_width - 229 )/2, _userNameLabel.frame.origin.y + _userNameLabel.frame.size.height + 10 , 229 , 16 )];
    _introduceLabel.alpha = .7;
    _introduceLabel.text = @"人生若只如初见，何事秋风悲画扇";
    _introduceLabel.textAlignment = 1;
    _introduceLabel.font = [UIFont systemFontOfSize:12 ];
    _introduceLabel.textColor = _userNameLabel.textColor;
    [_headView addSubview:self.introduceLabel];
    
    self.editTableView.tableHeaderView = _headView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat width = kScreenFrame_width; // 图片宽度
    CGFloat yOffset = scrollView.contentOffset.y;  // 偏移的y值
    if (yOffset < 0) {
        CGFloat totalOffset = kHeadView_Height + ABS(yOffset);
        CGFloat f = totalOffset / kHeadView_Height;
        self.headBackView.frame =  CGRectMake(- (width * f - width) / 2, yOffset, width * f, totalOffset); //拉伸后的图片的frame应该是同比例缩放。
    }

}

#pragma mark - tableview datasource and delegate -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datasArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[[UITableViewCell class] description]];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[[UITableViewCell class] description]];
    }
    cell.textLabel.text = self.datasArr[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return .1f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .1f;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //此处的EditingStyle可等于任意UITableViewCellEditingStyle，该行代码只在iOS8.0以前版本有作用，也可以不实现
    editingStyle = UITableViewCellEditingStyleDelete;
}
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //设置删除按钮
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除"handler:^(UITableViewRowAction *action,NSIndexPath *indexPath) {
        //        更新数据
        [self.datasArr removeObjectAtIndex:indexPath.row];
        
        //        更新UI
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    }];
    
    //设置收藏按钮
    
    UITableViewRowAction *collectRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"收藏"handler:^(UITableViewRowAction *action,NSIndexPath *indexPath) {
        
        collectRowAction.backgroundColor = [UIColor greenColor];
        
        //实现收藏功能
        NSLog(@"收藏成功");
        
    }];
    
    //设置置顶按钮
    
    UITableViewRowAction *topRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"置顶" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        
        [self.datasArr exchangeObjectAtIndex:indexPath.row withObjectAtIndex:0];
        
        NSIndexPath *firstIndexPath = [NSIndexPath indexPathForRow:0 inSection:indexPath.section];
        
        [tableView moveRowAtIndexPath:indexPath toIndexPath:firstIndexPath];
        
        [_editTableView reloadData];
        
    }];
    
    // 设置按钮的背景颜色
    topRowAction.backgroundColor = [UIColor blueColor];
    
    collectRowAction.backgroundColor = [UIColor grayColor];
    
    return  @[deleteRowAction,collectRowAction,topRowAction];//可以通过调整数组的顺序而改变按钮的排序
    
    
}
#pragma mark - setter and getter method -
- (UITableView *)editTableView
{
    if (!_editTableView) {
        UITableView *tb = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        tb.dataSource = self;
        tb.delegate = self;
        _editTableView = tb;
    }
    return _editTableView;
}
@end
