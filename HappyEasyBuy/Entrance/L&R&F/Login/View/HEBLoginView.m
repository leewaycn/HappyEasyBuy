//
//  HEBLoginView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/14.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBLoginView.h"
#import "HEBForgetViewController.h"
#import "HEBRegisterViewController.h"

@interface HEBLoginView()

@end

@implementation HEBLoginView

- (void)loadView {
    
    UIImageView *IMG = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"logo"]];
    [self addSubview:IMG];
    
    [IMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.width.height.mas_equalTo(110);
        make.top.equalTo(self.mas_top).offset(40);
    }];
    
    /** 手机号码 */
    QMUITextField *phoneTextField = [[QMUITextField alloc]init];
    phoneTextField.maximumTextLength = 11;
    phoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    selfClass(phoneTextField);
    phoneTextField.placeholder = @"请输入手机号码";
    phoneTextField.font = UIFontMake(15);
    [self addSubview:phoneTextField];
    [phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10);
        make.trailing.equalTo(self.mas_trailing).offset(-10);
        make.top.equalTo(IMG.mas_bottom).offset(50);
        make.height.mas_offset(30);
        
    }];
    phoneTextField.qmui_borderPosition = QMUIBorderViewPositionBottom;
    phoneTextField.qmui_borderWidth = 1;
    phoneTextField.qmui_borderColor = UIColorMakeWithRGBA(0, 0, 0, 0.2);
    
    /** 密码输入框 */
    QMUITextField *codeTextField = [[QMUITextField alloc]init];
    selfClass(codeTextField);
    codeTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self addSubview:codeTextField];
    codeTextField.placeholder = @"请输入密码";
    codeTextField.secureTextEntry = YES;
    codeTextField.font = UIFontMake(15);
    [codeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(phoneTextField.mas_left);
        make.trailing.equalTo(phoneTextField.mas_trailing);
        make.top.equalTo(phoneTextField.mas_bottom).offset(15);
        make.height.mas_offset(30);
    }];
    codeTextField.qmui_borderPosition = QMUIBorderViewPositionBottom;
    codeTextField.qmui_borderWidth = 1;
    codeTextField.qmui_borderColor = UIColorMakeWithRGBA(0, 0, 0, 0.2);
    
    /** 忘记密码按钮 */
    QMUIButton *forgotBtn = [[QMUIButton alloc]init];
    [forgotBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    forgotBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [forgotBtn setTitleColor:[UIColor colorWithRed:239/255.0 green:117/255.0 blue:50/255.0 alpha:1.0/1.0] forState:UIControlStateNormal];
    [forgotBtn addTarget:self action:@selector(forgotPassword) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:forgotBtn];
    
    [forgotBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(codeTextField.mas_bottom).offset(15);
        make.right.equalTo(self.mas_right).offset(-10);
    }];
    
    /** 登录按钮 */
    QMUIButton *logInBtn = [[QMUIButton alloc]init];
    selfClass(logInBtn);
    [logInBtn setImage:UIImageMake(@"denglu") forState:UIControlStateNormal];
    [self addSubview:logInBtn];
    [logInBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(forgotBtn.mas_bottom).offset(20);
    }];
    
    /** 注册按钮 */
    UIButton *registerBtn = [[UIButton alloc]init];
    [registerBtn setTitle:@"没有账号，去注册" forState:UIControlStateNormal];
    registerBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [registerBtn setTitleColor:[UIColor colorWithRed:239/255.0 green:117/255.0 blue:50/255.0 alpha:1.0/1.0] forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(gotoRegis) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:registerBtn];
    
    [registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-10);
        make.top.equalTo(logInBtn.mas_bottom).offset(15);
    }];
    
}

- (void)forgotPassword
{
    HEBForgetViewController *forgetVc = [HEBForgetViewController new];
    [self.viewControl.navigationController pushViewController:forgetVc animated:YES];
}

- (void)gotoRegis
{
    HEBRegisterViewController *regis = [HEBRegisterViewController new];
    [self.viewControl.navigationController pushViewController:regis animated:YES];
}
@end
