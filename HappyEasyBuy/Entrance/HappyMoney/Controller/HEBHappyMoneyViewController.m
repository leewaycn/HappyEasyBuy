//
//  HEBConsumedViewController.m
//  HappyEasyBuy
//
//  Created by 孙程 on 2017/11/17.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBHappyMoneyViewController.h"
#import "HEBAccountBalanceTopUPView.h"
#import "HEBHappyMoneyView.h"
#import "HEBHappyMoneyTopupRecordViewController.h"

@interface HEBHappyMoneyViewController ()

@end

@implementation HEBHappyMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleView.title = @"乐享币";
    self.titleView.titleLabel.textColor = UIColorWhite;
    self.navigationItem.rightBarButtonItem = [QMUINavigationButton barButtonItemWithImage:[UIImageMake(@"记录") imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] position:(QMUINavigationButtonPositionNone) target:self action:@selector(rightBarButtonItemDidClick)];
}

- (void)setUI {
    HEBHappyMoneyView *happyMoneyView = [[HEBHappyMoneyView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    happyMoneyView.headerView.lab.text = @"乐享币余额（个）";
    happyMoneyView.headerView.content.text = self.happyMoney;
    [self.baseView addSubview:happyMoneyView];
    [happyMoneyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.baseView.mas_top);
        make.left.right.bottom.equalTo(self.view);
    }];
    happyMoneyView.getHappyMoney = ^(NSString *money) {
        if (self.getHappyMoney) {
            self.getHappyMoney(money);
        }
    };
}

- (void)rightBarButtonItemDidClick {
    [self.navigationController pushViewController:[HEBHappyMoneyTopupRecordViewController new] animated:YES];
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
