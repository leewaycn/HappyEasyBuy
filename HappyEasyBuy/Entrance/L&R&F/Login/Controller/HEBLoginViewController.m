//
//  HEBLoginViewController.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/14.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBLoginViewController.h"
#import "HEBLoginView.h"
#import "HEBLoginModel.h"

@interface HEBLoginViewController ()

@property(nonatomic, strong) HEBLoginView *loginView;

@end

@implementation HEBLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"登录"];
    self.baseView.scrollEnabled = YES;
}

- (void)setUI {
    /** 视图 */
    HEBLoginView *loginView = [[HEBLoginView alloc]init];
    selfClass(loginView);
    [self.baseView addSubview:loginView];
    [loginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.baseView.mas_top);
        make.left.right.bottom.equalTo(self.view);
    }];
    if (IS_DEBUG) {
        loginView.phoneTextField.text = @"15206839071";
        loginView.codeTextField.text = @"123456";
    }
    __weak __typeof(self)weakSelf = self;
    [loginView.logInBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        if (!weakSelf.loginView.phoneTextField.text.isMobNumber) {
            return ;
        }
        if (weakSelf.loginView.codeTextField.text.length < 6) {
            return;
        }
        [self.progressHUD showAnimated:YES];
        [Networking postUrl:Login params:@{@"phone":weakSelf.loginView.phoneTextField.text, @"password":weakSelf.loginView.codeTextField.text.md5String} callBack:^(id responseObject, MainModel *mainModel, NSError *errorData) {
            [weakSelf dismissProgressHUD];
            [ISMessages showCardAlertWithTitle:nil
                                       message:mainModel.msg
                                      duration:2.25
                                   hideOnSwipe:NO
                                     hideOnTap:NO
                                     alertType:!mainModel.status
                                 alertPosition:(ISAlertPositionTop) didHide:nil];
            if (mainModel.status) {
                HEBLoginModel *model = [HEBLoginModel yy_modelWithJSON:mainModel.data];
                [Tools toolsUserDefaultsSaveOBJ:model.userid forKey:@"userid"];
                [Tools toolsUserDefaultsSaveOBJ:model.head_portrait forKey:@"header"];
                [Tools toolsUserDefaultsSaveOBJ:model.nickname forKey:@"nickName"];
                [Tools toolsUserDefaultsSaveOBJ:weakSelf.loginView.phoneTextField.text forKey:@"userPhoneNumber"];
                [Tools toolsUserDefaultsSaveOBJ:weakSelf.loginView.codeTextField.text.encryptAESString forKey:@"userPassWord"];
                if (weakSelf.getUserINFO) {
                    weakSelf.getUserINFO(model.nickname, model.head_portrait);
                }
                [weakSelf dismissViewControllerAnimated:YES completion:nil];
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }else {
                
            }
        
        }];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = nil;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

@end
