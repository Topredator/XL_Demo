//
//  ZXL_ConfigInputBoxViewController.m
//  XL_Demos
//
//  Created by zhouxiaolu on 16/8/2.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import "ZXL_ConfigInputBoxViewController.h"

@interface ZXL_ConfigInputBoxViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *inputTF; //  输入框
@property (nonatomic, copy) NSString *inPutStr; // 记载输入内容
@property (nonatomic, strong) UIView *bgView; // 背景view
@property (nonatomic, strong) UIView *popView; // 弹出的视图
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, assign) NSTimeInterval lastTime; //   记录上次时间选择
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, assign) InputType inputType;

@end

@implementation ZXL_ConfigInputBoxViewController
#pragma mark - init method -
+ (void)showConfigInputBox:(UIViewController *)parentVC inputType:(InputType)inputBox returnContent:(ReturnContent)returnContent
{
    ZXL_ConfigInputBoxViewController *configVC = [[ZXL_ConfigInputBoxViewController alloc] init];
    [configVC showInputBox:parentVC inputType:inputBox returnContent:returnContent];
}

- (void)showInputBox:(UIViewController *)parentVC inputType:(InputType)inputType returnContent:(ReturnContent)returnContent
{
    self.inputType = inputType;
    self.delegate = (id <ConfigInputBoxDelegate>)parentVC;
    self.ReturnContent = returnContent;
    while ([parentVC parentViewController] && ![parentVC.navigationController.viewControllers containsObject:parentVC]) {
        parentVC = [parentVC parentViewController];
    }
    self.view.frame = parentVC.navigationController.view.bounds;
    [parentVC.navigationController addChildViewController:self];
    [parentVC.navigationController.view addSubview:self.view];
    [self loadInputVC];
    [self showPop];
}
#pragma mark - life cycle -
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.bgView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
}
#pragma mark - event method - 
- (void)keyboardWillShow:(NSNotification *)notification
{
    NSValue* aValue = [[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    CGFloat keyboardHeight = keyboardRect.size.height;
    CGRect rect = self.popView.frame;
    rect.origin.y = kScreenFrame_height - keyboardHeight - 40;
    self.popView.frame = rect;
}
- (void)dismiss
{
    if ([self parentViewController]) {
        [UIView animateWithDuration:0.3
                         animations:^{
                             _bgView.alpha = 0;
                             CGRect r = _popView.frame;
                             r.origin.y = self.view.frame.size.height;
                             _popView.frame = r;
                         } completion:^(BOOL finished) {
                             [self.view removeFromSuperview];
                             [self removeFromParentViewController];
                         }];
    }
}
- (void)leftBtnAction:(UIButton *)btn
{
    if ([btn.titleLabel.text isEqualToString:@"取消"]) {
        [self dismiss];
    } else {
        self.inPutStr = @"";
        [btn setTitle:@"取消" forState:UIControlStateNormal];
        [self.rightBtn setTitle:@"下一步" forState:UIControlStateNormal];
        if (self.inputType == InputType_Int ||
            self.inputType == InputType_Text) {
            self.inputTF.text = @"";
        }
    }
}
- (void)rightBtnAction:(UIButton *)btn
{
    if ([btn.titleLabel.text isEqualToString:@"下一步"]) {
        [self.leftBtn setTitle:@"上一步" forState:UIControlStateNormal];
        [btn setTitle:@"完成" forState:UIControlStateNormal];
        if (self.inputType == InputType_Int ||
            self.inputType == InputType_Text)
        {
            self.inPutStr = self.inputTF.text;
            self.inputTF.text = @"";
        } else {
            self.lastTime = self.datePicker.date.timeIntervalSince1970 * 1000;
            self.inPutStr = [self formatTime:self.datePicker.date.timeIntervalSince1970 * 1000];
        }
        
    } else {
        if (self.inputType == InputType_Date) {
            if (self.lastTime >= self.datePicker.date.timeIntervalSince1970 * 1000) {
                return;
            } else {
                self.inPutStr = [self.inPutStr stringByAppendingString:[NSString stringWithFormat:@"~%@", [self formatTime:self.datePicker.date.timeIntervalSince1970 * 1000]]];
            }
        } else {
            self.inPutStr = [self.inPutStr stringByAppendingString:[NSString stringWithFormat:@"~%@", self.inputTF.text]];
        }
        __weak NSString *str = self.inPutStr;
        self.ReturnContent(str);
        [self dismiss];
    }
}
#pragma mark - private method - 
- (void)loadInputVC
{
    [self.view addSubview:self.popView];
    [self.popView addSubview:self.leftBtn];
    [self.popView addSubview:self.rightBtn];
    if (self.inputType == InputType_Int) {
        self.inputTF.keyboardType = UIKeyboardTypeNumberPad;
        self.inputTF.hidden = NO;
        [self.popView addSubview:self.inputTF];
    } else if (self.inputType == InputType_Text) {
        self.inputTF.keyboardType = UIKeyboardTypeDefault;
        self.inputTF.hidden = NO;
        [self.popView addSubview:self.inputTF];
    }
}
- (void)showPop
{
    if (self.inputType == InputType_Int ||
        self.inputType == InputType_Text) {
        [self.inputTF becomeFirstResponder];
    }
    [UIView animateWithDuration:0.3 animations:^{
        _bgView.alpha = 0.5;
        if (self.inputType == InputType_Date) {
            CGRect rect = self.popView.frame;
            rect.origin.y = kScreenFrame_height - 240 - 40;
            self.popView.frame = rect;
            [self.view addSubview:self.datePicker];
        }
    }];
}
- (NSString *)formatTime:(NSTimeInterval)t
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:t/1000];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents * components = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit |NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit) fromDate:date];
    return [NSString stringWithFormat:@"%04ld.%02ld.%02ld", (long)components.year, (long)components.month, (long)components.day];
}
#pragma mark - setter and getter methods -
- (UIView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:self.view.bounds];
        _bgView.backgroundColor = [UIColor blackColor];
        _bgView.alpha = 0;
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        [_bgView addGestureRecognizer:tapGR];
    }
    return _bgView;
}
- (UIView *)popView
{
    if (!_popView) {
        CGSize sz = self.view.bounds.size;
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, sz.height, sz.width, 40)];
        v.backgroundColor = [UIColor whiteColor];
        _popView = v;
    }
    return _popView;
}
- (UITextField *)inputTF
{
    if (!_inputTF) {
        UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(70, 5, kScreenFrame_width - (10 + 50 + 10) * 2, 30)];
        tf.delegate = self;
        tf.placeholder = @"请输入";
        _inputTF = tf;
    }
    return _inputTF;
}
- (UIButton *)leftBtn
{
    if (!_leftBtn) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, 50, 40)];
        [btn setTitle:@"取消" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor hexChangeFloat:@"ff5607"] forState:UIControlStateNormal];
        btn.titleLabel.font = kFont(15);
        [btn addTarget:self action:@selector(leftBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        _leftBtn = btn;
    }
    return _leftBtn;
}
- (UIButton *)rightBtn
{
    if (!_rightBtn) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenFrame_width - 60, 0, 50, 40)];
        [btn setTitle:@"下一步" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor hexChangeFloat:@"ff5607"] forState:UIControlStateNormal];
        btn.titleLabel.font = kFont(15);
        [btn addTarget:self action:@selector(rightBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        _rightBtn = btn;
    }
    return _rightBtn;
}
- (UIDatePicker *)datePicker
{
    if (!_datePicker) {
        UIDatePicker *datePicker = [[UIDatePicker alloc] init] ;
        datePicker.datePickerMode = UIDatePickerModeDate;
        datePicker.frame = CGRectMake(0, CGRectGetMaxY(_popView.frame), kScreenFrame_width, 240);
        [datePicker setDate:[NSDate date] animated:YES];
        datePicker.maximumDate = [NSDate date];
        datePicker.backgroundColor = [UIColor whiteColor];
        _datePicker = datePicker;
    }
    return _datePicker;
}



@end
