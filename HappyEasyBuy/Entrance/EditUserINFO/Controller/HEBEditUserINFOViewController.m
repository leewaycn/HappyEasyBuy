//
//  HEBEditUserINFOViewController.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/6.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBEditUserINFOViewController.h"
#import "HEBEditUserINFOView.h"

@interface HEBEditUserINFOViewController ()

/** 提交更改 */
@property(nonatomic, strong) QMUIButton *submit;

@end

@implementation HEBEditUserINFOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.baseView.scrollEnabled = YES;
    self.baseView.backgroundColor = UIColorHex(#f1f1f1);
}

- (void)setUI {
    HEBEditUserINFOView *editUserINFOView = [[HEBEditUserINFOView alloc] init];
    editUserINFOView.userNormal.text = self.userNormal;
    [self.baseView addSubview:editUserINFOView];
    
    QMUIButton *submit = [[QMUIButton alloc] init];
    selfClass(submit);
    submit.backgroundColor = BASECOLOR;
    [submit setTitle:@"确认" forState:UIControlStateNormal];
    [submit setTitleColor:UIColorWhite forState:UIControlStateNormal];
    [self.baseView addSubview:submit];
    [submit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(editUserINFOView.mas_bottom).offset(25);
        make.left.equalTo(editUserINFOView.mas_left).offset(25);
        make.right.equalTo(editUserINFOView.mas_right).offset(-25);
        make.height.mas_offset(44);
    }];
    submit.layer.cornerRadius = 5;
    submit.layer.masksToBounds = YES;
    
    QMUILabel *msg = [[QMUILabel alloc] init];
    msg.font = UIFontMake(14);
    msg.textColor = UIColorGray;
    [self.baseView addSubview:msg];
    [msg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(submit.mas_bottom).offset(15);
    }];
    __weak __typeof(self)weakSelf = self;
    if ([self.title isEqualToString:@"更换昵称"]) {
        [editUserINFOView loadNickName];
        [editUserINFOView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.baseView.mas_top);
            make.left.right.equalTo(self.view);
            make.bottom.equalTo(editUserINFOView.nickName.mas_bottom);
        }];
        msg.text = @"更换后，新昵称将作为用户昵称";
        [self.submit addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            [editUserINFOView.nickName resignFirstResponder];
            if (!editUserINFOView.nickName.hasText) {
                [ISMessages showCardAlertWithTitle:@"修改失败" message:@"请输入新昵称" duration:2.25 hideOnSwipe:NO hideOnTap:NO alertType:(ISAlertTypeError) alertPosition:(ISAlertPositionTop) didHide:nil];
                return ;
            }
            [weakSelf.progressHUD showAnimated:YES];
            [Networking postUrl:EditNickName params:@{@"vipid":getUser_id, @"nickname":editUserINFOView.nickName.text} callBack:^(id response, MainModel *mainModel, NSError *errorData) {
                [weakSelf dismissProgressHUD];
                if (mainModel.status) {
                    if (weakSelf.NickNameChange) {
                        weakSelf.NickNameChange(mainModel.data);
                        [weakSelf.navigationController popViewControllerAnimated:YES];
                    }
                    [Tools toolsUserDefaultsSaveOBJ:mainModel.data forKey:@"nickName"];
                }
            }];
        }];
    }else if ([self.title isEqualToString:@"更换手机号"]) {
        [editUserINFOView loadMobNumber];
        [editUserINFOView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.baseView.mas_top);
            make.left.right.equalTo(self.view);
            make.bottom.equalTo(editUserINFOView.verification.mas_bottom);
        }];
        msg.text = @"更换后，新手机号将作为登录账号";
        [self.submit addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            [editUserINFOView.verification resignFirstResponder];
            [editUserINFOView.mobNumber resignFirstResponder];
            if (!editUserINFOView.mobNumber.text.isMobNumber || !editUserINFOView.verification.hasText) {
                [ISMessages showCardAlertWithTitle:@"修改失败" message:@"请检查信息是否填写完整" duration:2.25 hideOnSwipe:NO hideOnTap:NO alertType:ISAlertTypeError alertPosition:ISAlertPositionTop didHide:nil];
                return;
            }else {
                [weakSelf.progressHUD showAnimated:YES];
                [Networking postUrl:SaveMob params:@{@"vipid":getUser_id, @"id":editUserINFOView.objid, @"data":editUserINFOView.verification.text.removeSpace, @"phone":editUserINFOView.mobNumber.text.removeSpace} callBack:^(id response, MainModel *mainModel, NSError *errorData) {
                    [weakSelf dismissProgressHUD];
                    if (mainModel.status) {
                        [Tools toolsUserDefaultsSaveOBJ:editUserINFOView.mobNumber.text.removeSpace forKey:@"userPhoneNumber"];
                        if (weakSelf.MobNumberChange) {
                            weakSelf.MobNumberChange(editUserINFOView.mobNumber.text.removeSpace);
                            [weakSelf.navigationController popViewControllerAnimated:YES];
                        }
                    }else {
                        [ISMessages showCardAlertWithTitle:@"修改失败" message:mainModel.msg duration:2.25 hideOnSwipe:NO hideOnTap:NO alertType:ISAlertTypeError alertPosition:ISAlertPositionTop didHide:nil];
                    }
                }];
            }
        }];
    }else if ([self.title isEqualToString:@"更换登录密码"]){
        [editUserINFOView loadPassword];
        msg.text = @"更换后，将使用新密码重新登录";
        [editUserINFOView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.baseView.mas_top);
            make.left.right.equalTo(self.view);
            make.bottom.equalTo(editUserINFOView.password2.mas_bottom);
        }];
        [self.submit addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            [editUserINFOView.oldPassword resignFirstResponder];
            [editUserINFOView.password1 resignFirstResponder];
            [editUserINFOView.password2 resignFirstResponder];
            if (!editUserINFOView.oldPassword.hasText ||
                !editUserINFOView.password1.hasText ||
                !editUserINFOView.password2.hasText ||
                !([editUserINFOView.password1.text.removeSpace isEqualToString:editUserINFOView.password2.text.removeSpace])) {
                [ISMessages showCardAlertWithTitle:@"修改失败" message:@"请检查信息是否正确" duration:2.25 hideOnSwipe:NO hideOnTap:NO alertType:ISAlertTypeError alertPosition:ISAlertPositionTop didHide:nil];
            }else {
                [Networking postUrl:EditPassword params:@{@"oldpass":editUserINFOView.oldPassword.text.removeline.md5String, @"newpass":editUserINFOView.password1.text.removeSpace.md5String, @"phone":getUser_phone} callBack:^(id response, MainModel *mainModel, NSError *errorData) {
                    if (mainModel.status) {
                        if (weakSelf.PasswordChange) {
                            weakSelf.PasswordChange(editUserINFOView.password1.text.removeSpace);
                            [Tools toolsUserDefaultsSaveOBJ:editUserINFOView.password1.text.removeSpace.encryptAESString forKey:@"userPassWord"];
                            [weakSelf.navigationController popViewControllerAnimated:YES];
                        }
                    }else {
                        [ISMessages showCardAlertWithTitle:@"修改失败" message:mainModel.msg duration:2.25 hideOnSwipe:NO hideOnTap:NO alertType:ISAlertTypeError alertPosition:ISAlertPositionTop didHide:nil];
                    }
                }];
            }
        }];
    }else if ([self.title isEqualToString:@"更换支付密码"]) {
        [editUserINFOView loadPassword];
        msg.text = @"更换后，新支付密码将作为支付密码";
        [editUserINFOView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.baseView.mas_top);
            make.left.right.equalTo(self.view);
            make.bottom.equalTo(editUserINFOView.password2.mas_bottom);
        }];
        [self.submit addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            [editUserINFOView.oldPassword resignFirstResponder];
            [editUserINFOView.password1 resignFirstResponder];
            [editUserINFOView.password2 resignFirstResponder];
            if (!editUserINFOView.oldPassword.hasText ||
                !editUserINFOView.password1.hasText ||
                !editUserINFOView.password2.hasText ||
                !([editUserINFOView.password1.text.removeSpace isEqualToString:editUserINFOView.password2.text.removeSpace])) {
                [ISMessages showCardAlertWithTitle:@"修改失败" message:@"请检查信息是否正确" duration:2.25 hideOnSwipe:NO hideOnTap:NO alertType:ISAlertTypeError alertPosition:ISAlertPositionTop didHide:nil];
            }else {
                [weakSelf.progressHUD showAnimated:YES];
                [Networking postUrl:EditPayPassword params:@{@"phone":getUser_phone, @"newpaycode":editUserINFOView.password1.text.removeSpace.md5String, @"oldpaycode":editUserINFOView.oldPassword.text.removeSpace.md5String} callBack:^(id response, MainModel *mainModel, NSError *errorData) {
                    [weakSelf dismissProgressHUD];
                    if (mainModel.status) {
                        [weakSelf.navigationController popViewControllerAnimated:YES];
                    }else {
                        [ISMessages showCardAlertWithTitle:@"修改失败" message:mainModel.msg duration:2.25 hideOnSwipe:NO hideOnTap:NO alertType:ISAlertTypeError alertPosition:ISAlertPositionTop didHide:nil];
                    }
                }];
            }
        }];
    }else {
        [editUserINFOView loadForgetPayPass];
        [editUserINFOView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.baseView.mas_top);
            make.left.right.equalTo(self.view);
            make.bottom.equalTo(editUserINFOView.password1.mas_bottom);
        }];
        msg.text = @"更换后，将使用新密码支付";
        [self.submit addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            if (!editUserINFOView.verification.hasText ||
                !editUserINFOView.password1.hasText) {
                [ISMessages showCardAlertWithTitle:@"修改失败" message:@"请检查信息是否正确" duration:2.25 hideOnSwipe:NO hideOnTap:NO alertType:ISAlertTypeError alertPosition:ISAlertPositionTop didHide:nil];
            }else {
                [weakSelf.progressHUD showAnimated:YES];
                [Networking postUrl:ReSetPayCode params:@{@"phone":getUser_phone, @"paycode":editUserINFOView.password1.text.removeSpace.md5String, @"verify":editUserINFOView.verification.text} callBack:^(id response, MainModel *mainModel, NSError *errorData) {
                    [weakSelf dismissProgressHUD];
                    if (mainModel.status) {
                        [weakSelf.navigationController popViewControllerAnimated:YES];
                    }else {
                        [ISMessages showCardAlertWithTitle:@"修改失败" message:mainModel.msg duration:2.25 hideOnSwipe:NO hideOnTap:NO alertType:ISAlertTypeError alertPosition:ISAlertPositionTop didHide:nil];
                    }
                }];
            }
        }];
    }
    
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

@end
