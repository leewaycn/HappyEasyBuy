//
//  HEBSetViewController.m
//  HappyEasyBuy
//
//  Created by 孙程 on 2017/11/16.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBSetViewController.h"
#import "HEBLoginViewController.h"
#import "HEBBaseNavigationController.h"
#import "HEBSetTabView.h"

@interface HEBSetViewController ()

@end

@implementation HEBSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
}

- (void)setUI {
    HEBSetTabView *settingView = [[HEBSetTabView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    [settingView.logout addTarget:self action:@selector(logoutDidClick) forControlEvents:UIControlEventTouchUpInside];
    [self.baseView addSubview:settingView];
    [settingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.baseView.mas_top);
        make.left.right.bottom.equalTo(self.view);
    }];
}

- (void)logoutDidClick {
    @"header".removeUserDefaultsINFO = YES;
    @"userPhoneNumber".removeUserDefaultsINFO = YES;
    @"userPassWord".removeUserDefaultsINFO = YES;
    @"nickName".removeUserDefaultsINFO = YES;
    @"userid".removeUserDefaultsINFO = YES;
    if (self.Logout) {
        self.Logout(YES);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = nil;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

@end
