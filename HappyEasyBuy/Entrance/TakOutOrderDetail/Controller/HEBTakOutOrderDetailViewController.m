//
//  HEBTakOutOrderDetailViewController.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/15.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBTakOutOrderDetailViewController.h"
#import "HEBTakOutOrderDetailView.h"
#import "HEBOrderPayViewController.h"
#import "HEBTakOutDetailViewController.h"

@interface HEBTakOutOrderDetailViewController ()

@property(nonatomic, strong) HEBTakOutOrderDetailView *orderView;

/** 需支付金额 */
@property(nonatomic, strong) QMUILabel *payMoney;

/** 优惠金额 */
@property(nonatomic, strong) QMUILabel *reduce;

/** 提交 */
@property(nonatomic, strong) QMUIButton *submit;

/** 请求参数 */
@property(nonatomic, strong) NSMutableDictionary *params;

@property(nonatomic, copy) NSString *key;

@property(nonatomic, copy) NSString *value;

@end

@implementation HEBTakOutOrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
}

- (void)setUI {
    HEBTakOutOrderDetailView *orderView = [[HEBTakOutOrderDetailView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    selfClass(orderView);
    orderView.money = self.money;
    [self.baseView addSubview:orderView];
    [orderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.top.equalTo(self.baseView.mas_top);
        make.left.equalTo(self.view.mas_left).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.bottom.equalTo([self payOrderINFOView].mas_top);
    }];
    __weak __typeof(self)weakSelf = self;
    orderView.getReduceMoney = ^(CGFloat reduce, NSString *key, NSString *value) {
        weakSelf.key = key;
        weakSelf.value = value;
        weakSelf.reduce.text = [NSString stringWithFormat:@"已优惠 %.2f", reduce];
        weakSelf.payMoney.text = [NSString stringWithFormat:@"¥ %.2f", weakSelf.payMoney.text.removeSpace.removeMoneySymbol.floatValue-reduce];
        if (reduce) {
            [weakSelf.params setObject:value forKey:key];
        }else {
            [weakSelf.params removeAllObjects];
            weakSelf.params = nil;
        }
    };
    orderView.getMsg = ^(NSString *msg) {
        [weakSelf.params setObject:msg forKey:@"msg"];
    };
    orderView.getAddressid = ^(NSString *addressid) {
        [weakSelf.params setObject:addressid forKey:@"address"];
        [weakSelf loadNetworking:@{@"user_id":getUser_id,
                                   @"shop_id":self.shop_id,
                                   @"money":self.money,
                                   @"address_id":addressid
                                   }];
    };
    [self loadNetworking:@{@"user_id":getUser_id,
                           @"shop_id":self.shop_id,
                           @"money":self.money}];
    self.baseView.backgroundColor = orderView.backgroundColor;
    
}

- (void)loadNetworking:(NSDictionary *)params {
    [self.progressHUD showAnimated:YES];
    __weak __typeof(self)weakSelf = self;
    [Networking postUrl:BuyCheck params:params
               callBack:^(id response, MainModel *mainModel, NSError *errorData) {
        [weakSelf dismissProgressHUD];
                   if (mainModel.status) {
                       HEBTakOutOrderDetailModel *orderModel = [HEBTakOutOrderDetailModel yy_modelWithJSON:mainModel.data];
                       weakSelf.payMoney.text = [NSString stringWithFormat:@"¥ %.2f", weakSelf.money.floatValue+orderModel.shop_info.delivery.floatValue];
                       [orderModel.address setServe:orderModel.serve];
                       weakSelf.orderView.useINFOModel = orderModel.address;
                       [weakSelf.params setObject:weakSelf.orderView.useINFOModel.objid?weakSelf.orderView.useINFOModel.objid:@"" forKey:@"address"];
                       [weakSelf.params setObject:orderModel.goods_list.yy_modelToJSONString forKey:@"goodslist"];
                       [weakSelf.orderView reloadSection:0 withRowAnimation:UITableViewRowAnimationNone];
                       weakSelf.orderView.shopINFOModel = orderModel.shop_info;
                       weakSelf.orderView.foodlistArr = [NSArray yy_modelArrayWithClass:[HEBTakOutBuyCarModel class] json:orderModel.goods_list];
                       [weakSelf.orderView reloadSection:1 withRowAnimation:UITableViewRowAnimationNone];
                       weakSelf.orderView.couponsArr = @[[NSArray yy_modelArrayWithClass:[HEBFoodSnatchOrderPaymentCouponDetailModel class] json:orderModel.shop_coupon], [NSArray yy_modelArrayWithClass:[HEBFoodSnatchOrderPaymentRedDetailModel class] json:orderModel.coupon]];
                       [weakSelf.orderView reloadSection:2 withRowAnimation:UITableViewRowAnimationNone];
                   }
    }];
}

- (void)submitDidClick {
    if (![self.params[@"address"] length]) {
        [ISMessages showCardAlertWithTitle:@"提交失败" message:@"请选择收货地址" duration:2.25 hideOnSwipe:NO hideOnTap:NO alertType:ISAlertTypeError alertPosition:ISAlertPositionTop didHide:nil];
        return;
    }
    [self.params setObject:self.payMoney.text.removeMoneySymbol.removeSpace forKey:@"payprice"];
    [self.progressHUD showAnimated:YES];
    __weak __typeof(self)weakSelf = self;
    [Networking postUrl:TakeOutSaveOrder params:self.params callBack:^(id response, MainModel *mainModel, NSError *errorData) {
        [weakSelf dismissProgressHUD];
        if (mainModel.status) {
            HEBOrderPayViewController *pay = [[HEBOrderPayViewController alloc] init];
            pay.weChatPayFlag = @"1";
            pay.orderNumber = mainModel.data[@"oid"];
            pay.objName = weakSelf.orderView.shopINFOModel.name;
            pay.money = [NSString stringWithFormat:@"¥ %@", weakSelf.payMoney.text];
            pay.aliPayKey = @"oid";
            pay.aliPayHost = TakeOutAliPay;
            pay.img = weakSelf.orderView.shopINFOModel.pic;
            pay.balancePayHost = TakeOutBalancePay;
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            [params setObject:mainModel.data[@"oid"] forKey:@"oid"];
            [params setObject:weakSelf.payMoney.text forKey:@"pay_price"];
            if (self.key.length) {
                [params setObject:self.value forKey:self.key];
            }
            NSMutableDictionary *balanceParams = params;
            [balanceParams setObject:@"3" forKey:@"pay_type"];
            pay.balanceParams = balanceParams;
            pay.happyMoneyPayHost = TakeOutHappyMoneyPay;
            NSMutableDictionary *happyMoneyParmas = params;
            [happyMoneyParmas setObject:@"4" forKey:@"pay_type"];
            pay.happyMoneyParmas = happyMoneyParmas;
            pay.payMsg = @"外卖订单";
            pay.paySuccessMsg = @"本地生活订单";
            @weakify(pay);
            pay.paySuccess = ^{
                [weak_pay.navigationController.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if ([obj isKindOfClass:[NSClassFromString(@"HEBTakOutDetailViewController") class]]) {
                        [weak_pay.navigationController popToViewController:obj animated:YES];
                    }
                }];
            };
            [weakSelf.navigationController pushViewController:pay animated:YES];
        }
    }];
}

- (UIView *)payOrderINFOView {
    UIView *paybgView = [[UIView alloc] init];
    paybgView.backgroundColor = UIColorWhite;
    [self.baseView addSubview:paybgView];
    [paybgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_offset(44);
    }];
    QMUILabel *reduce = [[QMUILabel alloc] init];
    reduce.text = @"已优惠¥ 0.00";
    selfClass(reduce);
    reduce.font = UIFontMake(16);
    reduce.textColor = BASEBLACK;
    [paybgView addSubview:reduce];
    [reduce mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(paybgView.mas_centerY);
        make.left.equalTo(paybgView.mas_left).offset(15);
    }];
    
    QMUIButton *submit = [[QMUIButton alloc] init];
    selfClass(submit);
    submit.backgroundColor = BASECOLOR;
    [submit setTitle:@"提交订单" forState:UIControlStateNormal];
    [submit setTitleColor:UIColorWhite forState:UIControlStateNormal];
    submit.titleLabel.font = UIFontMake(18);
    [paybgView addSubview:submit];
    [submit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(paybgView);
        make.width.mas_offset(100);
    }];
    [submit addTarget:self action:@selector(submitDidClick) forControlEvents:UIControlEventTouchUpInside];
    
    QMUILabel *payMoney = [[QMUILabel alloc] init];
    selfClass(payMoney);
    payMoney.font = UIFontMake(22);
    payMoney.textColor = BASECOLOR;
    [paybgView addSubview:payMoney];
    [payMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(paybgView.mas_centerY);
        make.right.equalTo(submit.mas_left).offset(-15);
    }];
    
    QMUILabel *msg = [[QMUILabel alloc] init];
    msg.font = UIFontMake(16);
    msg.textColor = BASEBLACK;
    msg.text = @"合计";
    [paybgView addSubview:msg];
    [msg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(paybgView.mas_centerY);
        make.right.equalTo(payMoney.mas_left).offset(-5);
    }];
    
    return paybgView;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (NSMutableDictionary *)params {
    if (!_params) {
        _params = [NSMutableDictionary dictionary];
        [_params setObject:getUser_id forKey:@"vipid"];
        [_params setObject:self.shop_id forKey:@"shopid"];
        [_params setObject:@"1" forKey:@"paytype"];
    }
    return _params;
}

@end
