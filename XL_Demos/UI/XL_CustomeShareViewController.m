//
//  XL_CustomeShareViewController.m
//  XL_Demos
//
//  Created by zhouxiaolu on 16/8/30.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import "XL_CustomeShareViewController.h"
#import "Function.h"


#define kMarginX 20.f
#define kMarginY 15.f

#define kTextMarginY 6.f
#define kItemWidth 54.f

@interface XL_CustomeShareViewController ()
@property (nonatomic, strong) UIView *bgView; //    背景视图
@property (nonatomic, strong) UIView *popView; //   弹出层视图
@property (nonatomic, strong) NSMutableDictionary *dataDic; //  数据源
@property (nonatomic, assign) ShowType showType; // 展示类型
@property (nonatomic, strong) NSArray *shareDataArr; // 分享的数据源
@end

@implementation XL_CustomeShareViewController
#pragma mark - init method -
+ (void)customeShareViewController:(UIViewController *)parentViewController dataDictionary:(NSDictionary *)dataDictionary showType:(ShowType)showType
{
    XL_CustomeShareViewController *shareVC = [[XL_CustomeShareViewController alloc] init];
    [shareVC showViewController:parentViewController data:dataDictionary showType:showType];
}
- (void)showViewController:(UIViewController *)parentViewController data:(NSDictionary *)data showType:(ShowType)showType
{
    self.showType = showType;
    self.dataDic = [NSMutableDictionary dictionaryWithDictionary:data];
    self.delegate = (id <CustomeShareDelegate>)parentViewController;
    while ([parentViewController parentViewController] && ![parentViewController.navigationController.viewControllers containsObject:parentViewController]) {
        parentViewController = [parentViewController parentViewController];
    }
    self.view.frame = parentViewController.navigationController.view.bounds;
    [parentViewController.navigationController addChildViewController:self];
    [parentViewController.navigationController.view addSubview:self.view];
    
    [self loadPopView];
    [self show];
}
#pragma mark - life cycle method -
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.bgView];
}
#pragma mark - event method -
- (void)dismiss
{
    if ([self parentViewController]) {
        [UIView animateWithDuration:0.3
                         animations:^{
                             _bgView.alpha = 0;
                             CGRect r = _popView.frame;
                             r.origin.y = self.view.frame.size.height;
                             self.popView.frame = r;
                         } completion:^(BOOL finished) {
                             [self.view removeFromSuperview];
                             [self removeFromParentViewController];
                         }];
    }
}
//  点击分享的按钮
- (void)actionShare:(UIButton *)btn
{
    Function *dm = self.shareDataArr[btn.tag - 100];
    if (dm.clickAction)
        dm.clickAction(self);
}
#pragma mark - private method -
//  加载视图
- (void)loadPopView
{
    if (self.showType == ShowType_Share) {
        [self.view addSubview:self.popView];
        
        UIView *shareView = [UIView new];
        shareView.backgroundColor = [UIColor whiteColor];
        [self.popView addSubview:shareView];
        
        UIFont *font = [UIFont systemFontOfSize:16];
        CGFloat baseY = kMarginY;
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, baseY, kScreenFrame_width - 16 * kRatio_Screen, font.pointSize)];
        titleLabel.text = @"分享";
        [shareView addSubview:titleLabel];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = font;
        
        baseY = CGRectGetMaxY(titleLabel.frame) + kMarginY;
        //  两个对象的间距
        CGFloat xgap = (kScreenFrame_width - 20 * kRatio_Screen - kMarginX * 2- kItemWidth * 4) / 3.f;
        
        font = [UIFont systemFontOfSize:12];
        self.shareDataArr = [_delegate getShareDataArr];
        
        CGFloat height = 0;
        for (int m = 0; m < self.shareDataArr.count ; m++) {
            int i = m % 4;
            int j = m / 4;
            height = [self addItemInRect:CGRectMake(kMarginX + (kItemWidth + xgap) * i, baseY + (kItemWidth + 6 + font.pointSize + 20) * j, kItemWidth, kItemWidth + 6 + font.pointSize) WithFunction:[_shareDataArr objectAtIndex:m] superView:shareView];
        }
        
        shareView.frame = CGRectMake(10 * kRatio_Screen, 0, kScreenFrame_width - 20 * kRatio_Screen, height);
        shareView.layer.cornerRadius = 5.f;
        shareView.layer.masksToBounds = YES;
        //  取消按钮
        UIButton *cancleBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMinX(shareView.frame), CGRectGetMaxY(shareView.frame) + 8 * kRatio_Screen, CGRectGetWidth(shareView.frame), 50)];
        [cancleBtn setTitle:@"取  消" forState:UIControlStateNormal];
        cancleBtn.backgroundColor = [UIColor whiteColor];
        [cancleBtn setTitleColor:[UIColor hexChangeFloat:@"db4437"] forState:UIControlStateNormal];
        [cancleBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        cancleBtn.layer.cornerRadius = 5.f;
        cancleBtn.layer.masksToBounds = YES;
        [self.popView addSubview:cancleBtn];
        
        CGSize sz = self.view.bounds.size;
        [self.popView setFrame:CGRectMake(0, sz.height, sz.width - 20 * kRatio_Screen, CGRectGetMaxY(cancleBtn.frame) + 8 * kRatio_Screen)];
    }
}
//  展示
- (void)show
{
    [UIView animateWithDuration:0.3 animations:^{
        _bgView.alpha = 0.5;
        CGRect r = self.popView.frame;
        r.origin.y = self.view.frame.size.height-r.size.height;
        self.popView.frame = r;
    }];
}
//  创建要分享的按钮
- (CGFloat)addItemInRect:(CGRect)r WithFunction:(Function *)func superView:(UIView *)superView
{
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(r.origin.x, r.origin.y, r.size.width, r.size.width)];
    btn.tag = [self.shareDataArr indexOfObject:func] + 100;
    [superView addSubview:btn];
    [btn addTarget:self action:@selector(actionShare:) forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:[UIImage imageNamed:func.image] forState:UIControlStateNormal];
    
    UIFont *f = [UIFont systemFontOfSize:12.f];
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(btn.frame)-10, CGRectGetMaxY(btn.frame)+6, CGRectGetWidth(btn.frame)+20, f.pointSize)];
    lbl.font = f;
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.textColor = [UIColor hexChangeFloat:@"9b9b9b"];
    lbl.text = func.name;
    [superView addSubview:lbl];
    return CGRectGetMaxY(lbl.frame) + 18;
}
#pragma mark - setter and getter method -
- (UIView *)bgView
{
    if (!_bgView) {
        UIView *v = [[UIView alloc] initWithFrame:self.view.bounds];
        v.backgroundColor = [UIColor blackColor];
        v.alpha = 0;
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        [v addGestureRecognizer:tapGR];
        _bgView = v;
    }
    return _bgView;
}
- (UIView *)popView
{
    if (!_popView) {
        CGSize sz = self.view.bounds.size;
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, sz.height, sz.width - 20 * kRatio_Screen, 500)];
        v.backgroundColor = [UIColor clearColor];
        _popView = v;
    }
    return _popView;
}
@end
