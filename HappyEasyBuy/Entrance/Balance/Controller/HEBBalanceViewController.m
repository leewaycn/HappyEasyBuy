//
//  HEBBalanceViewController.m
//  HappyEasyBuy
//
//  Created by 孙程 on 2017/11/17.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBBalanceViewController.h"
#import "HEBBalanceView.h"
#import "HEBBalanceRecordViewController.h"

@interface HEBBalanceViewController ()

@end

@implementation HEBBalanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleView.title = @"余额";
    self.titleView.titleLabel.textColor = UIColorWhite;
    self.navigationItem.rightBarButtonItem = [QMUINavigationButton barButtonItemWithImage:[UIImageMake(@"记录") imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] position:(QMUINavigationButtonPositionNone) target:self action:@selector(rightBarButtonItemDidClick)];
}

- (void)setUI {
    HEBBalanceView *balanceView = [[HEBBalanceView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    balanceView.headerView.lab.text = @"账户余额（元）";
    balanceView.headerView.content.text = self.accountBalance;
    [self.baseView addSubview:balanceView];
    [balanceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.baseView.mas_top);
        make.left.right.bottom.equalTo(self.view);
    }];
    __weak __typeof(self)weakSelf = self;
    balanceView.withdrawalSuccess = ^(NSString *money) {
        if (weakSelf.withdrawalSuccess) {
            weakSelf.withdrawalSuccess(money);
        }
    };
    balanceView.topuoSuccess = ^(NSString *money) {
        if (weakSelf.topuoSuccess) {
            weakSelf.topuoSuccess(money);
        }
    };
}

- (void)rightBarButtonItemDidClick {
    [self.navigationController pushViewController:[[HEBBalanceRecordViewController alloc] init] animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = BASECOLOR;
    self.navigationController.navigationBar.tintColor = UIColorWhite;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
   self.navigationController.navigationBar.barTintColor = nil;
}

@end
