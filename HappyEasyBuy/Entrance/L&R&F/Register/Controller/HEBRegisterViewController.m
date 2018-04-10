//
//  HEBRegisterViewController.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/14.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBRegisterViewController.h"
#import "HEBRegisterView.h"

@interface HEBRegisterViewController ()

@property(nonatomic, strong) HEBRegisterView *registerView;

@end

@implementation HEBRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    self.baseView.scrollEnabled = YES;
    self.baseView.backgroundColor = UIColorHex(#f1f1f1);
}

- (void)setUI {
    HEBRegisterView *registerView = [[HEBRegisterView alloc] init];
    selfClass(registerView);
    [self.baseView addSubview:registerView];
    [registerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.baseView.mas_top).offset(10);
        make.right.left.equalTo(self.view);
        make.bottom.equalTo(registerView.payPassword.mas_bottom);
    }];
    
    QMUIButton *senderRegister = [[QMUIButton alloc] init];
    senderRegister.titleLabel.font = UIFontMake(16);
    senderRegister.backgroundColor = BASECOLOR;
    [senderRegister setTitle:@"注册" forState:UIControlStateNormal];
    [senderRegister setTitleColor:UIColorWhite forState:UIControlStateNormal];
    [self.baseView addSubview:senderRegister];
    [senderRegister mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(registerView.mas_bottom).offset(15);
        make.left.equalTo(self.view.mas_left).offset(15);
        make.right.equalTo(self.view.mas_right).offset(-15);
        make.height.mas_offset(44);
    }];
    senderRegister.layer.cornerRadius = 10;
    senderRegister.layer.masksToBounds = YES;
    [senderRegister addTarget:self action:@selector(senderRegisterDidClick) forControlEvents:UIControlEventTouchUpInside];
    
    QMUIButton *goLogin = [[QMUIButton alloc] init];
    goLogin.titleLabel.font = UIFontMake(14);
    [goLogin setTitle:@"已有账号？去登录" forState:UIControlStateNormal];
    [goLogin setTitleColor:BASECOLOR forState:UIControlStateNormal];
    [self.baseView addSubview:goLogin];
    [goLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(-5);
        make.top.equalTo(senderRegister.mas_bottom).offset(10);
    }];
    __weak __typeof(self)weakSelf = self;
    [goLogin addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
}

- (void)senderRegisterDidClick {
    __weak __typeof(self)weakSelf = self;
    if (self.registerView.mobNumber.text.isMobNumber &&
        self.registerView.verification.hasText &&
        self.registerView.loginPassword.hasText &&
        self.registerView.payPassword.hasText) {
        [self.progressHUD showAnimated:YES];
        [Networking postUrl:Register params:@{@"phone":self.registerView.mobNumber.text,
                                              @"verify":self.registerView.verification.text,
                                              @"password":self.registerView.loginPassword.text.md5String,
                                              @"paycode":self.registerView.payPassword.text.md5String
                                              } callBack:^(id response, MainModel *mainModel, NSError *errorData) {
                                                  [weakSelf dismissProgressHUD];
                                                  [ISMessages showCardAlertWithTitle:nil message:mainModel.msg duration:2.25 hideOnSwipe:NO hideOnTap:NO alertType:!mainModel.status alertPosition:ISAlertPositionTop didHide:nil];
                                                  if (mainModel.status) {
                                                      [weakSelf.navigationController popViewControllerAnimated:YES];
                                                  }
                                              }];
    }else {
        [ISMessages showCardAlertWithTitle:@"注册失败" message:@"您好像有什么东西没有填写正确" duration:2.25 hideOnSwipe:NO hideOnTap:NO alertType:ISAlertTypeError alertPosition:ISAlertPositionTop didHide:nil];
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

@end
