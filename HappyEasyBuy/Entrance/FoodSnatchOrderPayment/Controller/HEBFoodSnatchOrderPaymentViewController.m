//
//  HEBFoodSnatchOrderPaymentViewController.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/29.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBFoodSnatchOrderPaymentViewController.h"
#import "HEBFoodSnatchOrderPaymentView.h"
#import "HEBOrderPayViewController.h"
#import "HEBChooseCouponsViewController.h"

@interface HEBFoodSnatchOrderPaymentViewController ()

/** 主体视图 */
@property(nonatomic, strong) HEBFoodSnatchOrderPaymentView *orderPaymentView;

/** 记录可用优惠券数量 */
@property(nonatomic, assign) int count;

/** 提交订单 */
@property(nonatomic, strong) QMUIButton *submit;

/** 请求的订单参数 */
@property(nonatomic, strong) NSMutableDictionary *param;

@property(nonatomic, copy) NSString *key;

@property(nonatomic, copy) NSString *value;

@end

@implementation HEBFoodSnatchOrderPaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setUI {
    QMUIButton *submit = [[QMUIButton alloc] init];
    selfClass(submit);
    [submit setTitle:@"提交订单" forState:UIControlStateNormal];
    [submit setTitleColor:UIColorWhite forState:UIControlStateNormal];
    submit.backgroundColor = BASECOLOR;
    submit.titleLabel.font = UIFontMake(18);
    [self.baseView addSubview:submit];
    [submit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.left.equalTo(self.view);
        make.height.mas_offset(44);
    }];
    HEBFoodSnatchOrderPaymentView *orderPaymentView = [[HEBFoodSnatchOrderPaymentView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    selfClass(orderPaymentView);
    [self.baseView addSubview:orderPaymentView];
    [orderPaymentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.baseView.mas_top);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(submit.mas_top);
    }];
    [self loadNetworking];
}

- (void)loadNetworking {
    [self.progressHUD showAnimated:YES];
    __weak __typeof(self)weakSelf = self;
    [Networking postUrl:FoodOrderDetail params:@{@"f_id":self.objid, @"user_id":getUser_id} callBack:^(id response, MainModel *mainModel, NSError *errorData) {
        [weakSelf dismissProgressHUD];
        weakSelf.orderPaymentView.header.backgroundColor = UIColorWhite;
        if (mainModel.status) {
            weakSelf.orderPaymentView.header.hidden = NO;
            HEBFoodSnatchOrderPaymentModel *model = [HEBFoodSnatchOrderPaymentModel yy_modelWithJSON:mainModel.data];
            [weakSelf loadHeaderINFO:model];
            HEBFoodSnatchOrderPaymentCouponModel *couponModel = [HEBFoodSnatchOrderPaymentCouponModel yy_modelWithJSON:response[@"couponList"]];
            weakSelf.orderPaymentView.shopReduceArr = [NSArray yy_modelArrayWithClass:[HEBFoodSnatchOrderPaymentCouponDetailModel class] json:couponModel.shopCoupon];
            weakSelf.orderPaymentView.redArr = [NSArray yy_modelArrayWithClass:[HEBFoodSnatchOrderPaymentRedDetailModel class] json:couponModel.Coupon];
            QMUITableViewCell *shopCell = [weakSelf.orderPaymentView cellForRow:0 inSection:0];
            QMUITableViewCell *redCell = [weakSelf.orderPaymentView cellForRow:1 inSection:0];
            QMUITableViewCell *moneyCell = [weakSelf.orderPaymentView cellForRow:0 inSection:1];
            moneyCell.detailTextLabel.text = [NSString stringWithFormat:@"¥ %@", model.f_price];
            if (weakSelf.orderPaymentView.shopReduceArr.count) {
                weakSelf.count = 0;
                [weakSelf.orderPaymentView.shopReduceArr enumerateObjectsUsingBlock:^(HEBFoodSnatchOrderPaymentCouponDetailModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if (model.f_price.floatValue >= obj.usemoney.floatValue) {
                        weakSelf.count = weakSelf.count+1;
                    }
                }];
                if (weakSelf.count > 0) {
                    shopCell.detailTextLabel.text = [NSString stringWithFormat:@"%d张可用优惠券", weakSelf.count];
                }else {
                    shopCell.userInteractionEnabled = NO;
                    shopCell.accessoryType = UITableViewCellAccessoryNone;
                    shopCell.detailTextLabel.text = @"暂无可用优惠券";
                }
            }else {
                shopCell.userInteractionEnabled = NO;
                shopCell.accessoryType = UITableViewCellAccessoryNone;
                shopCell.detailTextLabel.text = @"暂无可用优惠券";
            }
            if (weakSelf.orderPaymentView.redArr.count) {
                weakSelf.count = 0;
                [weakSelf.orderPaymentView.redArr enumerateObjectsUsingBlock:^(HEBFoodSnatchOrderPaymentRedDetailModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if (model.f_price.floatValue >= obj.reducemoney.floatValue) {
                        weakSelf.count = weakSelf.count+1;
                    }
                }];
                if (weakSelf.count > 0) {
                    redCell.detailTextLabel.text = [NSString stringWithFormat:@"%d张可用优惠券", weakSelf.count];
                }else {
                    redCell.userInteractionEnabled = NO;
                    redCell.accessoryType = UITableViewCellAccessoryNone;
                    redCell.detailTextLabel.text = @"暂无可用优惠券";
                }
            }else {
                redCell.userInteractionEnabled = NO;
                redCell.accessoryType = UITableViewCellAccessoryNone;
                redCell.detailTextLabel.text = @"暂无可用优惠券";
            }
            
            weakSelf.orderPaymentView.getCellDidClick = ^(NSString *title) {
                moneyCell.detailTextLabel.text = [NSString stringWithFormat:@"¥ %.2f", weakSelf.orderPaymentView.header.count.text.intValue*model.f_price.floatValue];
                [weakSelf.param removeAllObjects];
                weakSelf.param = nil;
                HEBChooseCouponsViewController *choose = [[HEBChooseCouponsViewController alloc] init];
                choose.title = title;
                if ([title isEqualToString:@"商家优惠券"]) {
                    choose.shopReduceArr = weakSelf.orderPaymentView.shopReduceArr;
                }else {
                    choose.redArr = weakSelf.orderPaymentView.redArr;
                }
                choose.money = moneyCell.detailTextLabel.text.removeSpace.removeMoneySymbol.floatValue;
                choose.getMoney = ^(NSString *money, NSString *key, NSString *value) {
                    moneyCell.detailTextLabel.text = money;
                    weakSelf.value = value;
                    weakSelf.key = key;
                    [weakSelf.param setObject:value forKey:key];
                };
                [weakSelf.navigationController pushViewController:choose animated:YES];
            };
            
            [weakSelf.submit addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
                [weakSelf submitOrderINFO:model cell:moneyCell];
            }];
        }
    }];
}

- (void)submitOrderINFO:(HEBFoodSnatchOrderPaymentModel *)model cell:(QMUITableViewCell *)moneyCell {
    if (self.orderPaymentView.phoneNum.text.isMobNumber) {
        [self.param setObject:self.orderPaymentView.phoneNum.text forKey:@"order_tel"];
        [self.param setObject:self.orderPaymentView.header.count.text forKey:@"order_num"];
        QMUITableViewCell *cell = [self.orderPaymentView cellForRow:0 inSection:1];
        [self.param setObject:cell.detailTextLabel.text.removeSpace.removeMoneySymbol forKey:@"order_price"];
    }else {
        [ISMessages showCardAlertWithTitle:@"提交失败" message:@"请检查手机号是否正确。。。"
                                  duration:2.25
                               hideOnSwipe:NO
                                 hideOnTap:NO
                                 alertType:ISAlertTypeError
                             alertPosition:ISAlertPositionTop didHide:nil];
        return;
    }
    [self.progressHUD showAnimated:YES];
    __weak __typeof(self)weakSelf = self;
    [Networking postUrl:FoodPackage params:self.param callBack:^(id response, MainModel *mainModel, NSError *errorData) {
        [weakSelf dismissProgressHUD];
        if (mainModel.status) {
            HEBOrderPayViewController *pay = [[HEBOrderPayViewController alloc] init];
            pay.objName = model.f_name;
            pay.money = moneyCell.detailTextLabel.text;
            pay.img = model.f_pic;
            pay.orderNumber = mainModel.data[@"number"];
            pay.weChatPayFlag = @"8";
            pay.aliPayKey = @"orderid";
            pay.aliPayHost = GoodsFoodAliPay;
            pay.balancePayHost = GoodsBalancePay;
            pay.happyMoneyPayHost = GoodHappyMoneyPay;
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            [params setObject:mainModel.data[@"number"] forKey:@"number"];
            [params setObject:moneyCell.detailTextLabel.text.removeSpace.removeMoneySymbol forKey:@"order_payprice"];
            if (self.key.length) {
                [params setObject:self.value forKey:self.key];
            }
           NSMutableDictionary *balanceParams = params;
            [balanceParams setObject:@"3" forKey:@"order_pay_type"];
            pay.balanceParams = balanceParams;
            NSMutableDictionary *happyMoneyParmas = params;
            [happyMoneyParmas setObject:@"4" forKey:@"order_pay_type"];
            pay.happyMoneyParmas = happyMoneyParmas;
            pay.payMsg = model.f_name;
            pay.paySuccessMsg = @"美食订单";
            @weakify(pay);
            pay.paySuccess = ^{
                [weak_pay.navigationController.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if ([obj isKindOfClass:[NSClassFromString(@"HEBShopDetailsViewController") class]]) {
                        [weak_pay.navigationController popToViewController:obj animated:YES];
                    }
                }];
            };
            [weakSelf.navigationController pushViewController:pay animated:YES];
        }else {
            [ISMessages showCardAlertWithTitle:@"提交失败" message:@"请稍后再试"
                                      duration:2.25
                                   hideOnSwipe:NO
                                     hideOnTap:NO
                                     alertType:ISAlertTypeError
                                 alertPosition:ISAlertPositionTop didHide:nil];
        }
    }];
}

- (void)loadHeaderINFO:(HEBFoodSnatchOrderPaymentModel *)model {
    [self.orderPaymentView.header.icon yy_setImageWithURL:[NSURL URLWithString:model.f_pic] options:(YYWebImageOptionProgressive)];
    self.orderPaymentView.header.name.text = model.f_name;
    self.orderPaymentView.header.des.text = model.f_name_account;
    self.orderPaymentView.header.unitPrice.text = [NSString stringWithFormat:@"¥ %@", model.f_price];
    self.orderPaymentView.header.money.text = [NSString stringWithFormat:@"¥ %@", model.f_price];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.tintColor = UIColorBlack;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (NSMutableDictionary *)param {
    if (!_param) {
        _param = [NSMutableDictionary dictionary];
        [_param setObject:self.shop_id forKey:@"order_sid"];
        [_param setObject:self.objid forKey:@"order_fid"];
        [_param setObject:getUser_id forKey:@"order_uid"];
    }
    return _param;
}

@end
