//
//  HEBForgetViewController.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/14.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBForgetViewController.h"
#import "HEBForgetView.h"

@interface HEBForgetViewController ()

@property(nonatomic, strong) HEBForgetView *forgetView;

@end

@implementation HEBForgetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"忘记密码";
    self.baseView.scrollEnabled = YES;
    self.baseView.backgroundColor = UIColorHex(#f1f1f1);
}

- (void)setUI {
    HEBForgetView *forgetView = [[HEBForgetView alloc] init];
    selfClass(forgetView);
    [self.baseView addSubview:forgetView];
    [forgetView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.baseView.mas_top).offset(10);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(forgetView.loginPassword.mas_bottom);
    }];
    
    QMUIButton *submit = [[QMUIButton alloc] init];
    submit.titleLabel.font = UIFontMake(16);
    submit.backgroundColor = BASECOLOR;
    [submit setTitle:@"确认" forState:UIControlStateNormal];
    [submit setTitleColor:UIColorWhite forState:UIControlStateNormal];
    [self.baseView addSubview:submit];
    [submit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(forgetView.mas_bottom).offset(15);
        make.left.equalTo(self.view.mas_left).offset(15);
        make.right.equalTo(self.view.mas_right).offset(-15);
        make.height.mas_offset(44);
    }];
    submit.layer.cornerRadius = 10;
    submit.layer.masksToBounds = YES;
    
    [submit addTarget:self action:@selector(submitDidClick) forControlEvents:UIControlEventTouchUpInside];
    
    QMUILabel *msg = [[QMUILabel alloc] init];
    msg.text = @"更换后，将使用新密码重新登录";
    msg.textColor = UIColorGray;
    msg.font = UIFontMake(14);
    [self.baseView addSubview:msg];
    [msg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(submit.mas_bottom).offset(10);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    
}

- (void)submitDidClick {
    __weak __typeof(self)weakSelf = self;
    [self.progressHUD showAnimated:YES];
    [Networking postUrl:ChnagePassword params:@{@"phone":self.forgetView.mobNumber.text,
                                     @"verify":self.forgetView.verification.text,
                                     @"password":self.forgetView.loginPassword.text.md5String} callBack:^(id response, MainModel *mainModel, NSError *errorData) {
        [weakSelf dismissProgressHUD];
                                         [ISMessages showCardAlertWithTitle:nil message:mainModel.msg duration:2.25 hideOnSwipe:NO hideOnTap:NO alertType:!mainModel.status alertPosition:ISAlertPositionTop didHide:nil];
                                         if (mainModel.status) {
                                             [weakSelf.navigationController popViewControllerAnimated:YES];
                                         }
    }];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

@end
