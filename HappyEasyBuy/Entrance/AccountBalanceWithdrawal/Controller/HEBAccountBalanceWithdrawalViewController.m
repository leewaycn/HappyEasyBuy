//
//  HEBAccountBalanceWithdrawalViewController.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/28.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBAccountBalanceWithdrawalViewController.h"
#import "HEBAccountBalanceWithdrawalView.h"

@interface HEBAccountBalanceWithdrawalViewController ()

@property(nonatomic, strong) HEBAccountBalanceWithdrawalView *withdrawalView;

@end

@implementation HEBAccountBalanceWithdrawalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleView.title = @"申请提现";
    self.titleView.titleLabel.textColor = UIColorWhite;
}

- (void)setUI {
    HEBAccountBalanceWithdrawalView *withdrawalView = [[HEBAccountBalanceWithdrawalView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    selfClass(withdrawalView);
    [self.baseView addSubview:withdrawalView];
    [withdrawalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.baseView.mas_top);
        make.left.right.bottom.equalTo(self.view);
    }];
    __weak __typeof(self)weakSelf = self;
    withdrawalView.withdrawalSuccess = ^(NSString *money) {
        if (weakSelf.withdrawalSuccess) {
            weakSelf.withdrawalSuccess(money);
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    };
    [self loadNetworking]; 
}

- (void)loadNetworking {
    [self.progressHUD showAnimated:YES];
    __weak __typeof(self)weakSelf = self;
    [Networking postUrl:WithdrawalINFO params:@{@"vipid":getUser_id} callBack:^(id response, MainModel *mainModel, NSError *errorData) {
        [weakSelf dismissProgressHUD];
        if (mainModel.status) {
            weakSelf.withdrawalView.model = [HEBAccountBalanceWithdrawalModel yy_modelWithJSON:mainModel.data];
            
            NSString *account = [NSString stringWithFormat:@"您的余额: %@元", weakSelf.withdrawalView.model.balance];
            [weakSelf.withdrawalView.withdrawalINFO addObject:@{@"title":account, @"search":weakSelf.withdrawalView.model.balance}];
            
            NSString *available = [NSString stringWithFormat:@"今日还可提现: %@ 元", weakSelf.withdrawalView.model.limit_money];
            [weakSelf.withdrawalView.withdrawalINFO addObject:@{@"title":available, @"search":weakSelf.withdrawalView.model.limit_money}];
            
            NSString *min = [NSString stringWithFormat:@"每笔至少提现: %@ 元", weakSelf.withdrawalView.model.least];
            [weakSelf.withdrawalView.withdrawalINFO addObject:@{@"title":min, @"search":weakSelf.withdrawalView.model.least}];

            NSString *max = [NSString stringWithFormat:@"每笔最高提现: %@ 元(银行卡限制)", weakSelf.withdrawalView.model.most];
            [weakSelf.withdrawalView.withdrawalINFO addObject:@{@"title":max, @"search":weakSelf.withdrawalView.model.most}];

            NSString *type = [NSString stringWithFormat:@"提现方式: 银行提现"];
            [weakSelf.withdrawalView.withdrawalINFO addObject:@{@"title":type, @"search":@" "}];
            [weakSelf.withdrawalView reloadData];
        }
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = BASECOLOR;
    self.navigationController.navigationBar.tintColor = UIColorWhite;
}

@end
