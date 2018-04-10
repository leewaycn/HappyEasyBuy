//
//  HEBEditUserINFOView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/6.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBEditUserINFOView.h"

@interface HEBEditUserINFOView ()

/** 获取验证码 */
@property(nonatomic, strong) QMUIButton *getVerification;

/** 记录时间 */
@property(nonatomic, assign) int time;

@end

@implementation HEBEditUserINFOView

- (void)loadView {
    [self loadUserNormal];
    self.backgroundColor = UIColorWhite;
}

- (void)loadUserNormal {
    self.dividingLine = YES;
    QMUILabel *userNormal = [[QMUILabel alloc] init];
    selfClass(userNormal);
    [self addSubview:userNormal];
    [userNormal mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(25);
        make.top.equalTo(self.mas_top);
        make.height.mas_offset(44);
    }];
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = UIColorHex(#e7e7e7);
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(userNormal.mas_bottom);
        make.height.mas_offset(1);
    }];
}

- (void)loadNickName {
    QMUITextField *nickName = [[QMUITextField alloc] init];
    nickName.clearButtonMode = UITextFieldViewModeWhileEditing;
    nickName.placeholder = @"请输入新昵称";
    selfClass(nickName);
    [self addSubview:nickName];
    [nickName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userNormal.mas_bottom);
        make.left.equalTo(self.mas_left).offset(25);
        make.right.equalTo(self.mas_right).offset(-25);
        make.height.mas_offset(44);
    }];
}

- (void)loadMobNumber {
    QMUITextField *mobNumber = [[QMUITextField alloc] init];
    mobNumber.keyboardType = UIKeyboardTypeNumberPad;
    mobNumber.placeholder = @"请输入手机号";
    selfClass(mobNumber);
    mobNumber.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self addSubview:mobNumber];
    [mobNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userNormal.mas_bottom);
        make.left.equalTo(self.mas_left).offset(25);
        make.right.equalTo(self.mas_right).offset(-25);
        make.height.mas_offset(44);
    }];
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = UIColorHex(#e7e7e7);
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom);
        make.left.right.equalTo(self);
        make.top.equalTo(mobNumber.mas_bottom);
        make.height.mas_offset(1);
    }];
    
    QMUIButton *getVerification = [[QMUIButton alloc] init];
    selfClass(getVerification);
    [getVerification setTitle:@"获取验证码" forState:UIControlStateNormal];
    [getVerification setTitleColor:UIColorGray forState:UIControlStateNormal];
    getVerification.titleLabel.font = UIFontMake(14);
    [self addSubview:getVerification];
    [getVerification mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom);
        make.right.equalTo(self.mas_right);
        make.size.mas_offset(CGSizeMake(100, 44));
    }];
    [getVerification addTarget:self action:@selector(getVerificationDidClick) forControlEvents:UIControlEventTouchUpInside];
    
    QMUITextField *verification = [[QMUITextField alloc] init];
    verification.keyboardType = UIKeyboardTypeNumberPad;
    selfClass(verification);
    verification.placeholder = @"请输入验证码";
    [self addSubview:verification];
    [verification mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom);
        make.left.equalTo(self.mas_left).offset(25);
        make.height.mas_offset(44);
        make.right.equalTo(getVerification.mas_left);
    }];
}

- (void)loadPassword {
    QMUITextField *oldPassword = [[QMUITextField alloc] init];
    selfClass(oldPassword);
    oldPassword.clearButtonMode = UITextFieldViewModeWhileEditing;
    oldPassword.placeholder = @"请输入旧密码";
    [self addSubview:oldPassword];
    [oldPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userNormal.mas_bottom);
        make.left.equalTo(self.mas_left).offset(25);
        make.right.equalTo(self.mas_right).offset(-25);
        make.height.mas_offset(44);
    }];
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = UIColorHex(#e7e7e7);
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(oldPassword.mas_bottom);
        make.height.mas_offset(1);
    }];
    QMUITextField *password1 = [[QMUITextField alloc] init];
    password1.secureTextEntry = YES;
    selfClass(password1);
    password1.clearButtonMode = UITextFieldViewModeWhileEditing;
    password1.placeholder = @"请输入新密码";
    [self addSubview:password1];
    [password1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom);
        make.left.equalTo(self.mas_left).offset(25);
        make.right.equalTo(self.mas_right).offset(-25);
        make.height.mas_offset(44);
    }];
    UIView *line2 = [[UIView alloc] init];
    line2.backgroundColor = UIColorHex(#e7e7e7);
    [self addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(password1.mas_bottom);
        make.height.mas_offset(1);
    }];
    QMUITextField *password2 = [[QMUITextField alloc] init];
    selfClass(password2);
    password2.secureTextEntry = YES;
    password2.clearButtonMode = UITextFieldViewModeWhileEditing;
    password2.placeholder = @"请确认新密码";
    [self addSubview:password2];
    [password2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line2.mas_bottom);
        make.left.equalTo(self.mas_left).offset(25);
        make.right.equalTo(self.mas_right).offset(-25);
        make.height.mas_offset(44);
    }];
}

- (void)loadForgetPayPass {
    QMUIButton *getVerification = [[QMUIButton alloc] init];
    selfClass(getVerification);
    [getVerification setTitle:@"获取验证码" forState:UIControlStateNormal];
    [getVerification setTitleColor:UIColorGray forState:UIControlStateNormal];
    getVerification.titleLabel.font = UIFontMake(14);
    [self addSubview:getVerification];
    [getVerification mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userNormal.mas_bottom);
        make.right.equalTo(self.mas_right);
        make.size.mas_offset(CGSizeMake(100, 44));
    }];
    __weak __typeof(self)weakSelf = self;
    [getVerification addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        weakSelf.time = 60;
        QMUIButton *btn = sender;
        [Networking postUrl:PasswordSendMsg params:@{@"phone":weakSelf.userNormal.text} callBack:^(id response, MainModel *mainModel, NSError *errorData) {
            if (mainModel.status) {
                btn.enabled = NO;
                [NSTimer scheduledTimerWithTimeInterval:1.0 block:^(NSTimer * _Nonnull timer) {
                    if (weakSelf.time < 1) {
                        [timer invalidate];
                        timer = nil;
                        btn.enabled = YES;
                        [btn setTitle:@"重新获取" forState:UIControlStateNormal];
                    }else {
                        weakSelf.time = weakSelf.time - 1;
                        [btn setTitle:[NSString stringWithFormat:@"%d", weakSelf.time] forState:UIControlStateNormal];
                    }
                } repeats:YES];
            }else {
                [ISMessages showCardAlertWithTitle:@"发送验证码失败" message:mainModel.msg duration:2.25 hideOnSwipe:NO hideOnTap:NO alertType:ISAlertTypeError alertPosition:ISAlertPositionTop didHide:nil];
            }
        }];
    }];
    
    QMUITextField *verification = [[QMUITextField alloc] init];
    verification.keyboardType = UIKeyboardTypeNumberPad;
    selfClass(verification);
    verification.placeholder = @"请输入验证码";
    [self addSubview:verification];
    [verification mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userNormal.mas_bottom);
        make.left.equalTo(self.mas_left).offset(25);
        make.height.mas_offset(44);
        make.right.equalTo(getVerification.mas_left);
    }];
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = UIColorHex(#e7e7e7);
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(verification.mas_bottom);
        make.height.mas_offset(1);
    }];
    
    QMUITextField *password1 = [[QMUITextField alloc] init];
    password1.secureTextEntry = YES;
    selfClass(password1);
    password1.clearButtonMode = UITextFieldViewModeWhileEditing;
    password1.placeholder = @"请输入新支付密码";
    [self addSubview:password1];
    [password1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom);
        make.left.equalTo(self.mas_left).offset(25);
        make.right.equalTo(self.mas_right).offset(-25);
        make.height.mas_offset(44);
    }];
    
}

- (void)getVerificationDidClick {
    if (!self.mobNumber.text.isMobNumber) {
        [ISMessages showCardAlertWithTitle:@"发送验证码失败" message:@"请检查手机号码是否正确" duration:2.25 hideOnSwipe:NO hideOnTap:NO alertType:ISAlertTypeError alertPosition:ISAlertPositionTop didHide:nil];
        return;
    }
    __weak __typeof(self)weakSelf = self;
    [self.viewControl.progressHUD showAnimated:YES];
    [Networking postUrl:EditMobSendMsg params:@{@"upmobile":self.mobNumber.text, @"vipid":getUser_id} callBack:^(id response, MainModel *mainModel, NSError *errorData) {
        [self.viewControl dismissProgressHUD];
        if (mainModel.status) {
            weakSelf.getVerification.enabled = NO;
            weakSelf.time = 60;
            [weakSelf.getVerification setTitle:@"60" forState:UIControlStateNormal];
            [NSTimer scheduledTimerWithTimeInterval:1.f block:^(NSTimer * _Nonnull timer) {
                if (weakSelf.time < 1) {
                    [timer invalidate];
                    timer = nil;
                    weakSelf.getVerification.enabled = YES;
                    [weakSelf.getVerification setTitle:@"获取验证码" forState:UIControlStateNormal];
                }else {
                weakSelf.time = weakSelf.time - 1;
                [weakSelf.getVerification setTitle:[NSString stringWithFormat:@"%d", weakSelf.time] forState:UIControlStateNormal];
                }
            } repeats:YES];
            weakSelf.objid = response[@"id"];
        }else {
             [ISMessages showCardAlertWithTitle:@"发送验证码失败" message:mainModel.msg duration:2.25 hideOnSwipe:NO hideOnTap:NO alertType:ISAlertTypeError alertPosition:ISAlertPositionTop didHide:nil];
        }
    }];
}

@end
