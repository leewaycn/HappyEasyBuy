//
//  HEBAccountBalanceTopUPViewController.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/28.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBAccountBalanceTopUPViewController.h"
#import "HEBAccountBalanceTopUPView.h"
#import "HEBPaySuccessViewController.h"
#import "HEBWeChatModel.h"
#import "HEBAliPayModel.h"
#import <WXApiObject.h>

@interface HEBAccountBalanceTopUPViewController ()

@property(nonatomic, strong) HEBAccountBalanceTopUPView *topup;

@end

@implementation HEBAccountBalanceTopUPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账户充值";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(balanceWeChatPay:) name:@"balanceWeChatPay" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(balanceAliPay:) name:@"balanceAliPay" object:nil];
}

- (void)setUI {
    HEBAccountBalanceTopUPView *topup = [[HEBAccountBalanceTopUPView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    selfClass(topup);
    [self.baseView addSubview:topup];
    [topup mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.baseView.mas_top);
        make.left.right.bottom.equalTo(self.view);
    }];
}

- (void)balanceWeChatPay:(NSNotification *)cation {
    BaseResp *model = cation.object;
    if (model.errCode == 0) {
        [self loadSuccessImg:@"微信支付成功" paytype:@"微信支付"];
    }else {
        [ISMessages showCardAlertWithTitle:@"支付失败" message:@"微信支付失败" duration:2.25 hideOnSwipe:NO hideOnTap:NO alertType:ISAlertTypeError alertPosition:ISAlertPositionTop didHide:nil];
    }
}

- (void)balanceAliPay:(NSNotification *)cation {
    HEBAliPayModel *model = [HEBAliPayModel yy_modelWithDictionary:cation.object];
    if ([model.resultStatus isEqualToString:@"9000"]) {
        [self loadSuccessImg:@"支付宝支付成功" paytype:@"支付宝支付"];
    }else {
        [ISMessages showCardAlertWithTitle:@"支付失败" message:model.memo duration:2.25 hideOnSwipe:NO hideOnTap:NO alertType:ISAlertTypeError alertPosition:ISAlertPositionTop didHide:nil];
    }
}

- (void)loadSuccessImg:(NSString *)img paytype:(NSString *)payType {
    HEBPaySuccessViewController *success = [[HEBPaySuccessViewController alloc] init];
    success.imgName = img;
    success.money = self.topup.money;
    success.successMsg = @"支付成功";
    success.cellModelArr = @[@{@"title":@"支付方式", @"msg":payType}];
    __weak __typeof(self)weakSelf = self;
    success.success = ^{
        if (weakSelf.getMoney) {
            weakSelf.getMoney(weakSelf.topup.money);
        }
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    [self.navigationController pushViewController:success animated:YES];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"balanceWeChatPay" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"balanceAliPay" object:nil];
}

@end
