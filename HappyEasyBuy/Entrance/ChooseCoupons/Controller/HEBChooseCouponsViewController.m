//
//  HEBChooseCouponsViewController.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/1.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBChooseCouponsViewController.h"
#import "HEBChooseCouponsView.h"

@interface HEBChooseCouponsViewController ()

@end

@implementation HEBChooseCouponsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setUI {
    HEBChooseCouponsView *chooseCouponsView = [[HEBChooseCouponsView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    chooseCouponsView.money = self.money;
    chooseCouponsView.redArr = self.redArr;
    chooseCouponsView.shopReduceArr = self.shopReduceArr;
    [self.baseView addSubview:chooseCouponsView];
    [chooseCouponsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.baseView.mas_top);
        make.left.right.bottom.equalTo(self.view);
    }];
    __weak __typeof(self)weakSelf = self;
    chooseCouponsView.getMoney = ^(NSString *money, NSString *key, NSString *value) {
        if (weakSelf.getMoney) {
            weakSelf.getMoney(money, key, value);
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    };
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.tintColor = UIColorBlack;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (NSArray<HEBFoodSnatchOrderPaymentRedDetailModel *> *)redArr {
    if (!_redArr) {
        _redArr = [NSArray array];
    }
    return _redArr;
}

- (NSArray<HEBFoodSnatchOrderPaymentCouponDetailModel *> *)shopReduceArr {
    if (!_shopReduceArr) {
        _shopReduceArr = [NSArray array];
    }
    return _shopReduceArr;
}

@end
