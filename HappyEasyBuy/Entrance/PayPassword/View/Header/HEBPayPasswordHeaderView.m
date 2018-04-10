//
//  HEBPayPasswordView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2018/1/3.
//  Copyright © 2018年 happyEsayBuy. All rights reserved.
//

#import "HEBPayPasswordHeaderView.h"

@implementation HEBPayPasswordHeaderView

- (void)loadView {
    self.backgroundColor = UIColorWhite;
    QMUILabel *title = [[QMUILabel alloc] init];
    title.text = @"确认付款";
    title.font = UIFontMake(22);
    title.textColor = BASEBLACK;
    [self addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(10);
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    QMUIButton *close = [[QMUIButton alloc] init];
    [close setBackgroundImage:UIImageMake(@"外卖_弹窗关闭") forState:UIControlStateNormal];
    [self addSubview:close];
    [close mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(15);
        make.centerY.equalTo(title.mas_centerY);
        make.size.mas_offset(close.currentBackgroundImage.size);
    }];
    [close addTarget:self action:@selector(closeDidClick) forControlEvents:UIControlEventTouchUpInside];
    
    QMUILabel *password = [[QMUILabel alloc] init];
    password.text = @"支付密码:";
    password.font = UIFontMake(14);
    password.textColor = BASEBLACK;
    [self addSubview:password];
    [password mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(title.mas_bottom).offset(30);
        make.left.equalTo(close.mas_left);
        make.width.mas_offset(80);
    }];
    
    QMUITextField *payPass = [[QMUITextField alloc] init];
    selfClass(payPass);
    payPass.borderStyle = UITextBorderStyleRoundedRect;
    payPass.secureTextEntry = YES;
    payPass.clearButtonMode = UITextFieldViewModeWhileEditing;
    payPass.placeholder = @"请输入支付密码";
    payPass.font = UIFontMake(16);
    [self addSubview:payPass];
    [payPass mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(password.mas_centerY);
        make.left.equalTo(password.mas_right);
        make.right.equalTo(self.mas_right).offset(-15);
        make.height.mas_offset(40);
    }];
    
    QMUILabel *money = [[QMUILabel alloc] init];
    selfClass(money);
    money.font = UIFontMake(26);
    [self addSubview:money];
    [money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(payPass.mas_bottom).offset(10);
    }];
    
}

- (void)closeDidClick {
    [self.viewControl dismissViewControllerAnimated:YES completion:nil];
}

@end
