//
//  ProsonCenterViewController.m
//  XL_Demos
//
//  Created by zhouxiaolu on 16/9/10.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import "ProsonCenterViewController.h"
#import "Person.h"

typedef NS_ENUM(NSInteger, TextFieldUpdataType) {
    TextFieldUpdataType_NickName,
    TextFieldUpdataType_RealName,
    TextFieldUpdataType_Gander,
    TextFieldUpdataType_TelePhone
};

@interface ProsonCenterViewController ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UIActionSheetDelegate>
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) Person *person;
@end



@implementation ProsonCenterViewController
#pragma mark - life cycle -
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.myTableView];
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    //  datasource
    NSDictionary *dic = @{@"nickName" : @"Topredator",
                                    @"realName" : @"~ 路 ~",
                                    @"sex" : @"男",
                                    @"telePhone" : @"15906615096"};
    self.person = [[Person alloc] initWithDic:dic];
}
#pragma mark - tableview datasource and delegate -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"personCenter";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        cell.textLabel.font = [UIFont systemFontOfSize:16.0];
        cell.detailTextLabel.textColor = [UIColor hexChangeFloat:@"9b9b9b"];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.row == 0)
    {
        cell.textLabel.text = @"昵称";
        cell.detailTextLabel.text = self.person.nickName.length ? self.person.nickName : @"";
    }
    else if (indexPath.row == 1)
    {
        cell.textLabel.text = @"真实姓名";
        cell.detailTextLabel.text = self.person.realName.length ? self.person.realName : @"";
    }
    else if (indexPath.row == 2)
    {
        cell.textLabel.text = @"性别";
        cell.detailTextLabel.text = self.person.sex;
    }
    else if (indexPath.row == 3)
    {
        cell.textLabel.text = @"手机号码";
        cell.detailTextLabel.text = self.person.telePhone.length ? self.person.telePhone : @"";
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"请输入昵称" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
        alert.tag = TextFieldUpdataType_NickName;
        UITextField *textField = [alert textFieldAtIndex:0];
        textField.keyboardType = UIKeyboardTypeDefault;
        textField.delegate = self;
        textField.clearsOnBeginEditing = YES;
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [alert show];
    }
    else if (indexPath.row == 1)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"请输入真实姓名" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
        alert.tag = TextFieldUpdataType_RealName;
        UITextField *textField = [alert textFieldAtIndex:0];
        textField.keyboardType = UIKeyboardTypeDefault;
        textField.delegate = self;
        textField.clearsOnBeginEditing = YES;
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [alert show];
    }
    else if (indexPath.row == 2)
    {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"请选择性别"
                                                                 delegate:self
                                                        cancelButtonTitle:@"取消"
                                                   destructiveButtonTitle:nil
                                                        otherButtonTitles:@"男", @"女",nil];
        actionSheet.tag = TextFieldUpdataType_Gander;
        [actionSheet showInView:self.view];
    }
    else if (indexPath.row == 3)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"请输入电话号码" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
        alert.tag = TextFieldUpdataType_TelePhone;
        UITextField *textField = [alert textFieldAtIndex:0];
        textField.keyboardType = UIKeyboardTypeDefault;
        textField.delegate = self;
        textField.clearsOnBeginEditing = YES;
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [alert show];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .01f;
}
#pragma mark - textfield delegate -
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSMutableString *mstr = [NSMutableString stringWithString:textField.text];
    [mstr replaceCharactersInRange:range withString:string];
    if (mstr.length && [mstr characterAtIndex:0] == 32)
        return NO;
    NSString *s = [mstr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (s.length > 14)
        return NO;
    return YES;
}
#pragma UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (1 == buttonIndex)
    {
        UITextField *phoneText = [alertView textFieldAtIndex:0];
        NSString *s = phoneText.text;
        if (s.length == 0)
            NSLog(@"不能为空");
        else
        {
            [self SendUpdateProfileRequest:s WithType:(int)alertView.tag];
        }
        
    }
}

- (void)didPresentAlertView:(UIAlertView *)alertView
{
    if (alertView.tag == TextFieldUpdataType_NickName)
    {
        UITextField *phoneText = [alertView textFieldAtIndex:0];
        phoneText.text = self.person.nickName;
    }
    else if (alertView.tag == TextFieldUpdataType_RealName) {
        UITextField *phoneText = [alertView textFieldAtIndex:0];
        phoneText.text = self.person.realName;
    }
    else if (alertView.tag == TextFieldUpdataType_TelePhone)
    {
        UITextField *phoneText = [alertView textFieldAtIndex:0];
        phoneText.text = self.person.telePhone;
    }
}
#pragma mark - actionSheet Delegate -
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == TextFieldUpdataType_Gander)
    {
        NSString *gender = nil;
        if (buttonIndex == 0) {
            gender = @"男";
        } else if (buttonIndex == 1) {
            gender = @"女";
        }
        if (gender && !gender.isEmpty)
            [self SendUpdateProfileRequest:gender WithType:TextFieldUpdataType_Gander];
    }
}
#pragma mark - private method -
- (void) SendUpdateProfileRequest:(id)value WithType:(TextFieldUpdataType)type
{
    Person *dm = self.person;
    if (type == TextFieldUpdataType_NickName)
    {
        if (![dm.nickName isEqualToString:value]) self.person.nickName = value;
    }
    else if (type == TextFieldUpdataType_RealName)
    {
        if (![dm.realName isEqualToString:value]) self.person.realName = value;
    }
    else if (type == TextFieldUpdataType_Gander)
    {
        if (![dm.sex isEqualToString:value]) self.person.sex = value;
    }
    else if (type == TextFieldUpdataType_TelePhone)
    {
        if (![dm.telePhone isEqualToString:value]) self.person.telePhone = value;
    }
    [self.myTableView reloadData];
}
#pragma mark - setter and getter -
- (UITableView *)myTableView
{
    if (!_myTableView) {
        UITableView *tb = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        tb.dataSource = self;
        tb.delegate = self;
        _myTableView = tb;
    }
    return _myTableView;
}

@end
