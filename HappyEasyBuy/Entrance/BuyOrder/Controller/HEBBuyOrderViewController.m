//
//  HEBBuyOrderViewController.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/5.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBBuyOrderViewController.h"
#import "HEBBuyOrderView.h"

@interface HEBBuyOrderViewController ()
@property(nonatomic, strong) HEBBuyOrderView *orderView;
@end

@implementation HEBBuyOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"买单";
}

- (void)setUI {
    HEBBuyOrderView *orderView = [[HEBBuyOrderView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    orderView.shopid = self.shop_id;
    orderView.shopName = self.shopName;
    selfClass(orderView);
    [self.baseView addSubview:orderView];
    [orderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.baseView.mas_top);
        make.left.right.bottom.equalTo(self.view);
    }];
    [self loadNetworking];
}

- (void)loadNetworking {
    [self.progressHUD showAnimated:YES];
    __weak __typeof(self)weakSelf = self;
    [Networking postUrl:PayMsg params:@{@"user_id":getUser_id, @"type":self.type, @"shop_id":self.shop_id} callBack:^(id response, MainModel *mainModel, NSError *errorData) {
        [weakSelf dismissProgressHUD];
        if (mainModel.status) {
            weakSelf.orderView.full = [mainModel.data[@"full"] floatValue];
            weakSelf.orderView.reduction = [mainModel.data[@"reduce"] floatValue];
            weakSelf.orderView.fullReduction.text = [NSString stringWithFormat:@"满%.2f减%.2f", weakSelf.orderView.full, weakSelf.orderView.reduction];
            weakSelf.orderView.shopCoupon = [NSArray yy_modelArrayWithClass:[HEBFoodSnatchOrderPaymentCouponDetailModel class] json:response[@"couponList"][@"shopCoupon"]];
            weakSelf.orderView.Coupon = [NSArray yy_modelArrayWithClass:[HEBFoodSnatchOrderPaymentRedDetailModel class] json:response[@"couponList"][@"Coupon"]];
        }
    }];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = nil;
    self.navigationController.navigationBar.tintColor = UIColorBlack;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

@end
