//
//  HEBForgetView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/14.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBForgetView.h"

@interface HEBForgetView()

@property(nonatomic, assign) int time;

@property(nonatomic, strong) QMUIButton *sendMsg;

@end

@implementation HEBForgetView

- (void)loadView {
    self.backgroundColor = UIColorWhite;
    self.time = 60;
    self.backgroundColor = UIColorWhite;
    QMUITextField *mobNumber = [[QMUITextField alloc] init];
    mobNumber.keyboardType = UIKeyboardTypeNumberPad;
    selfClass(mobNumber);
    mobNumber.placeholder = @"请输入手机号码";
    mobNumber.clearButtonMode = UITextFieldViewModeWhileEditing;
    mobNumber.font = UIFontMake(16);
    mobNumber.bottomLine = YES;
    mobNumber.maximumTextLength = 11;
    [self addSubview:mobNumber];
    [mobNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left).offset(5);
        make.right.equalTo(self.mas_right).offset(-5);
        make.height.mas_offset(44);
    }];
    
    QMUIButton *sendMsg = [[QMUIButton alloc] init];
    selfClass(sendMsg);
    [sendMsg setTitle:@"获取验证码" forState:UIControlStateNormal];
    [sendMsg setTitleColor:UIColorGray forState:UIControlStateNormal];
    sendMsg.titleLabel.font = UIFontMake(14);
    sendMsg.bottomLine = YES;
    [self addSubview:sendMsg];
    [sendMsg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mobNumber.mas_bottom).offset(5);
        make.right.equalTo(mobNumber.mas_right);
        make.size.mas_offset(CGSizeMake(80, 44));
    }];
    [sendMsg addTarget:self action:@selector(sendMsgDidClick) forControlEvents:UIControlEventTouchUpInside];
    
    QMUITextField *verification = [[QMUITextField alloc] init];
    selfClass(verification);
    verification.placeholder = @"请输入短信验证码";
    verification.keyboardType = UIKeyboardTypeNumberPad;
    verification.font = UIFontMake(16);
    verification.clearButtonMode = UITextFieldViewModeWhileEditing;
    verification.maximumTextLength = 6;
    verification.bottomLine = YES;
    [self addSubview:verification];
    [verification mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(sendMsg.mas_left);
        make.left.equalTo(mobNumber);
        make.top.bottom.equalTo(sendMsg);
    }];
    
    QMUITextField *loginPassword = [[QMUITextField alloc] init];
    loginPassword.secureTextEntry = YES;
    selfClass(loginPassword);
    loginPassword.placeholder = @"请输入新密码";
    loginPassword.font = UIFontMake(16);
    loginPassword.bottomLine = YES;
    loginPassword.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self addSubview:loginPassword];
    [loginPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(mobNumber);
        make.top.equalTo(verification.mas_bottom).offset(5);
    }];
}

- (void)sendMsgDidClick {
    __weak __typeof(self)weakSelf = self;
    if (self.mobNumber.text.isMobNumber) {
        [Networking postUrl:PasswordSendMsg params:@{@"phone":self.mobNumber.text} callBack:^(id response, MainModel *mainModel, NSError *errorData) {
            if (mainModel.status) {
                [ISMessages showCardAlertWithTitle:@"发送成功" message:mainModel.msg duration:2.25 hideOnSwipe:NO hideOnTap:NO alertType:ISAlertTypeSuccess alertPosition:ISAlertPositionTop didHide:nil];
                weakSelf.sendMsg.userInteractionEnabled = NO;
                [NSTimer scheduledTimerWithTimeInterval:1.0 block:^(NSTimer * _Nonnull timer) {
                    weakSelf.time--;
                    [weakSelf.sendMsg setTitle:[NSString stringWithFormat:@"%d秒", weakSelf.time] forState:UIControlStateNormal];
                    if (weakSelf.time == 0) {
                        [timer invalidate];
                        timer = nil;
                        [weakSelf.sendMsg setTitle:@"重新获取" forState:UIControlStateNormal];
                        weakSelf.sendMsg.userInteractionEnabled = YES;
                        weakSelf.time = 60;
                    }
                } repeats:YES];
            }
        }];
    }else {
        [ISMessages showCardAlertWithTitle:@"发送失败" message:@"请检查输入的手机号是否正确" duration:2.25 hideOnSwipe:NO hideOnTap:NO alertType:ISAlertTypeError alertPosition:ISAlertPositionTop didHide:nil];
    }
}

@end
