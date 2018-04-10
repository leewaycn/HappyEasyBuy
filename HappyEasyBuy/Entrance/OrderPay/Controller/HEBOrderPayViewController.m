//
//  HEBOrderPayViewController.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/30.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBOrderPayViewController.h"
#import "HEBOrderPayView.h"
#import <WXApi.h>
#import <AlipaySDK/AlipaySDK.h>
#import "HEBWeChatModel.h"
#import "HEBPayPasswordViewController.h"
#import "HEBPaySuccessViewController.h"
#import "HEBAliPayModel.h"

@interface HEBOrderPayViewController ()

@property(nonatomic, strong) HEBOrderPayView *orderPayView;

@end

@implementation HEBOrderPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.vcTitle?self.vcTitle:@"支付方式";
    if (!self.vcTitle) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(aliPayResult:) name:@"aliPayResult" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(weChatPayResult:) name:@"weChatPayResult" object:nil];
    }else {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(aliPayTopup:) name:@"aliPayTopup" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(weChatTopup:) name:@"weChatTopup" object:nil];
    }
}

- (void)setUI {
    HEBOrderPayView *orderPayView = [[HEBOrderPayView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    orderPayView.hasTitle = self.vcTitle;
    if (self.isHiddenHeader) {
        [orderPayView.header removeFromSuperview];
        orderPayView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    }
    selfClass(orderPayView);
    [self.baseView addSubview:orderPayView];
    [orderPayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.baseView.mas_top);
        make.left.right.bottom.equalTo(self.view);
    }];
    if (!self.vcTitle) {
        [orderPayView.header.icon yy_setImageWithURL:[NSURL URLWithString:self.img] options:YYWebImageOptionProgressive];
        orderPayView.header.name.text = self.objName;
        orderPayView.header.money.text = self.money;
        [orderPayView.pay setTitle:[NSString stringWithFormat:@"确认支付 %@", self.money] forState:UIControlStateNormal];
        [orderPayView.pay addTarget:self action:@selector(payDidClick:) forControlEvents:UIControlEventTouchUpInside];
        if (self.weChatPayFlag.intValue == 1) {
            orderPayView.header.money.font = UIFontMake(16);
            orderPayView.header.name.font = UIFontMake(16);
            [orderPayView.header.money mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(orderPayView.header.icon.mas_right).offset(15);
                make.top.equalTo(orderPayView.header.icon.mas_top).offset(5);
            }];
            [orderPayView.header.name mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(orderPayView.header.money.mas_left);
                make.top.equalTo(orderPayView.header.icon.mas_centerY).offset(3);
            }];
        }
    }else {
        orderPayView.dividingLine = YES;
        QMUILabel *payMsg = [[QMUILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
        payMsg.text = self.vcPayMsg;
        payMsg.backgroundColor = UIColorWhite;
        payMsg.textColor = BASECOLOR;
        payMsg.font = UIFontMake(20);
        orderPayView.tableHeaderView = payMsg;
        [orderPayView.pay setTitle:[NSString stringWithFormat:@"确认支付"] forState:UIControlStateNormal];
        [orderPayView.pay addTarget:self action:@selector(happyPayDidClick:) forControlEvents:UIControlEventTouchUpInside];
    }
   
}

- (void)payDidClick:(QMUIButton *)sender {
    if (self.isHiddenHeader) {
        __weak __typeof(self)weakSelf = self;
        switch (sender.tag) {
            case 0:{
                if ([WXApi isWXAppInstalled]) {
                    [self.progressHUD showAnimated:YES];
                    [Networking postUrl:self.weChatPayHost params:@{@"user_id":getUser_id, @"shop_id":self.shopid, @"total_price":self.total_price, @"type":self.type, @"pay_price":self.pay_price, @"re_money":self.re_money} callBack:^(id response, MainModel *mainModel, NSError *errorData) {
                        [weakSelf dismissProgressHUD];
                        PayReq *payReq = [[PayReq alloc] init];
                        HEBWeChatModel *model = [HEBWeChatModel yy_modelWithJSON:mainModel.data];
                        payReq.sign = model.sign;
                        payReq.nonceStr = model.noncestr;
                        payReq.timeStamp = model.timestamp;
                        payReq.package = model.package;
                        payReq.prepayId = model.prepayid;
                        payReq.partnerId = model.partnerid;
                        [WXApi sendReq:payReq];
                    }];
                }else {
                    [ISMessages showCardAlertWithTitle:@"支付失败" message:@"您当前并未安装微信，所以无法使用此方式进行支付" duration:2.25 hideOnSwipe:NO hideOnTap:NO alertType:ISAlertTypeError alertPosition:ISAlertPositionTop didHide:nil];
                }
        }
                break;
            case 1: {
                [self.progressHUD showAnimated:YES];
                [Networking postUrl:self.aliPayHost params:@{@"user_id":getUser_id, @"shop_id":self.shopid, @"total_price":self.total_price, @"type":self.type, @"pay_price":self.pay_price, @"re_money":self.re_money} callBack:^(id response, MainModel *mainModel, NSError *errorData) {
                    [weakSelf dismissProgressHUD];
                    [[AlipaySDK defaultService] payOrder:mainModel.data fromScheme:AliAppScheme callback:^(NSDictionary *resultDic) {
                        [weakSelf aliPayCallBack:resultDic];
                    }];
                }];
            }break;
            case 2:{
                [self payPasswordWithpayType:@"账户余额" payTypeMsg:@"余额支付" payHost:self.balancePayHost params:self.balanceParams imgName:@"余额支付成功"];
            }break;
            case 3:{
                [self payPasswordWithpayType:@"乐享币" payTypeMsg:@"乐享币支付" payHost:self.happyMoneyPayHost params:self.happyMoneyParmas imgName:@"乐享币支付成功"];
            }break;
            default:
                break;
        }
        
    }else {
    __weak __typeof(self)weakSelf = self;
    switch (sender.tag) {
        case 0:{
            if ([WXApi isWXAppInstalled]) {
                [self.progressHUD showAnimated:YES];
                [Networking postUrl:WXPay params:@{@"orderid":self.orderNumber, @"status":self.weChatPayFlag} callBack:^(id response, MainModel *mainModel, NSError *errorData) {
                    [weakSelf dismissProgressHUD];
                    PayReq *payReq = [[PayReq alloc] init];
                    HEBWeChatModel *model = [HEBWeChatModel yy_modelWithJSON:mainModel.data];
                    payReq.sign = model.sign;
                    payReq.nonceStr = model.noncestr;
                    payReq.timeStamp = model.timestamp;
                    payReq.package = model.package;
                    payReq.prepayId = model.prepayid;
                    payReq.partnerId = model.partnerid;
                    [WXApi sendReq:payReq];
                }];
            }else {
                [ISMessages showCardAlertWithTitle:@"支付失败" message:@"您当前并未安装微信，所以无法使用此方式进行支付" duration:2.25 hideOnSwipe:NO hideOnTap:NO alertType:ISAlertTypeError alertPosition:ISAlertPositionTop didHide:nil];
            }
        }
            break;
        case 1: {
            [self.progressHUD showAnimated:YES];
            [Networking postUrl:self.aliPayHost params:@{self.aliPayKey:self.orderNumber} callBack:^(id response, MainModel *mainModel, NSError *errorData) {
                [weakSelf dismissProgressHUD];
                [[AlipaySDK defaultService] payOrder:mainModel.data fromScheme:AliAppScheme callback:^(NSDictionary *resultDic) {
                    [weakSelf aliPayCallBack:resultDic];
                }];
            }];
        }break;
        case 2: {
            [self payPasswordWithpayType:@"账户余额" payTypeMsg:@"余额支付" payHost:self.balancePayHost params:self.balanceParams imgName:@"余额支付成功"];
        }break;
        case 3: {
            [self payPasswordWithpayType:@"乐享币" payTypeMsg:@"乐享币支付" payHost:self.happyMoneyPayHost params:self.happyMoneyParmas imgName:@"乐享币支付成功"];
        }break;
        default:
            break;
    }
    }
}

- (void)happyPayDidClick:(QMUIButton *)sender {
     __weak __typeof(self)weakSelf = self;
    switch (sender.tag) {
        case 0:{
            if ([WXApi isWXAppInstalled]) {
                [self.progressHUD showAnimated:YES];
                [Networking postUrl:HappyMoneyWeChatPay params:@{@"status":@"9", @"vipid":getUser_id, @"pay_price":self.pay_price, @"consume_num":self.consume_num} callBack:^(id response, MainModel *mainModel, NSError *errorData) {
                    [weakSelf dismissProgressHUD];
                    PayReq *payReq = [[PayReq alloc] init];
                    HEBWeChatModel *model = [HEBWeChatModel yy_modelWithJSON:mainModel.data];
                    payReq.sign = model.sign;
                    payReq.nonceStr = model.noncestr;
                    payReq.timeStamp = model.timestamp;
                    payReq.package = model.package;
                    payReq.prepayId = model.prepayid;
                    payReq.partnerId = model.partnerid;
                    [WXApi sendReq:payReq];
                }];
            }else {
                 [ISMessages showCardAlertWithTitle:@"支付失败" message:@"您当前并未安装微信，所以无法使用此方式进行支付" duration:2.25 hideOnSwipe:NO hideOnTap:NO alertType:ISAlertTypeError alertPosition:ISAlertPositionTop didHide:nil];
            }
        }break;
        case 1:{
            [self.progressHUD showAnimated:YES];
            [Networking postUrl:HappyMoneyAliPay params:@{@"status":@"9", @"vipid":getUser_id, @"pay_price":self.pay_price, @"consume_num":self.consume_num} callBack:^(id response, MainModel *mainModel, NSError *errorData) {
                [weakSelf dismissProgressHUD];
                [[AlipaySDK defaultService] payOrder:mainModel.data fromScheme:AliAppScheme callback:^(NSDictionary *resultDic) {
                    HEBAliPayModel *model = [HEBAliPayModel yy_modelWithDictionary:resultDic];
                    if ([model.resultStatus isEqualToString:@"9000"]) {
                        [self topupSuccess:@"支付宝支付" imgName:@"支付宝支付成功"];
                    }else {
                        [ISMessages showCardAlertWithTitle:@"支付失败" message:model.memo duration:2.25 hideOnSwipe:NO hideOnTap:NO alertType:ISAlertTypeError alertPosition:ISAlertPositionTop didHide:nil];
                    }
                }];
            }];
        }break;
        case 2:{
            __weak __typeof(self)weakSelf = self;
            HEBPayPasswordViewController *pay = [[HEBPayPasswordViewController alloc] init];
            pay.modalPresentationStyle = UIModalPresentationCustom;
            pay.payType = @"账户余额";
            pay.payMsg = @"乐享币充值";
            pay.payMoney = self.pay_price;
            pay.payHost = HappyMoneyBalacePay;
            pay.params = @{@"status":@"9", @"vipid":getUser_id, @"pay_price":self.pay_price, @"consume_num":self.consume_num};
            pay.payStatusStr = ^(NSString *orderNumber) {
                HEBPaySuccessViewController *success = [[HEBPaySuccessViewController alloc] init];
                success.money = [NSString stringWithFormat:@"¥ %@", [weakSelf.pay_price stringByReplacingOccurrencesOfString:@"¥" withString:@""]];
                success.successMsg = @"支付成功";
                success.imgName = @"余额支付成功";
                    success.cellModelArr = @[@{@"title":@"商品", @"msg":@"乐享币充值"},
                                             @{@"title":@"交易时间", @"msg":[Tools getCurrentTimesWithType:@"yyyy年MM月dd日 HH:mm:ss"]},
                                             @{@"title":@"支付方式", @"msg":@"余额"},
                                             @{@"title":@"交易单号", @"msg":orderNumber}];
                success.success = ^{
                    if (weakSelf.paySuccess) {
                        weakSelf.paySuccess();
                    }
                };
                [self.navigationController pushViewController:success animated:YES];
            };
            [self presentViewController:pay animated:YES completion:nil];
        }break;
        default:
            break;
    }
}



- (void)payPasswordWithpayType:(NSString *)payType payTypeMsg:(NSString *)payTypeMsg payHost:(NSString *)payHost params:(NSDictionary *)params imgName:(NSString *)imgName {
    __weak __typeof(self)weakSelf = self;
    HEBPayPasswordViewController *pay = [[HEBPayPasswordViewController alloc] init];
    pay.modalPresentationStyle = UIModalPresentationCustom;
    pay.payType = payType;
    pay.payMsg = self.payMsg;
    pay.payMoney = self.money;
    pay.payHost = payHost;
    pay.params = params;
    pay.payStatus = ^(BOOL status) {
        if (status) {
            [weakSelf paySuccessType:payTypeMsg imgName:imgName];
        }
    };
    [self presentViewController:pay animated:YES completion:nil];
}

- (void)aliPayResult:(NSNotification *)cation {
    [self aliPayCallBack:cation.object];
}

- (void)weChatPayResult:(NSNotification *)cation {
    BaseResp *model = cation.object;
    if (model.errCode == 0) {
        [self topupSuccess:@"微信支付" imgName:@"微信支付成功"];
    }else {
        [ISMessages showCardAlertWithTitle:@"支付失败" message:@"微信支付失败" duration:2.25 hideOnSwipe:NO hideOnTap:NO alertType:ISAlertTypeError alertPosition:ISAlertPositionTop didHide:nil];
    }
}

- (void)aliPayTopup:(NSNotification *)cation {
    HEBAliPayModel *model = [HEBAliPayModel yy_modelWithDictionary:cation.object];
    if ([model.resultStatus isEqualToString:@"9000"]) {
        [self topupSuccess:@"支付宝支付" imgName:@"支付宝支付成功"];
    }else {
        [ISMessages showCardAlertWithTitle:@"支付失败" message:model.memo duration:2.25 hideOnSwipe:NO hideOnTap:NO alertType:ISAlertTypeError alertPosition:ISAlertPositionTop didHide:nil];
    }
}

- (void)weChatTopup:(NSNotification *)cation {
    BaseResp *model = cation.object;
    if (model.errCode == 0) {
        [self topupSuccess:@"微信支付" imgName:@"微信支付成功"];
    }else {
        [ISMessages showCardAlertWithTitle:@"支付失败" message:@"微信支付失败" duration:2.25 hideOnSwipe:NO hideOnTap:NO alertType:ISAlertTypeError alertPosition:ISAlertPositionTop didHide:nil];
    }
}

- (void)topupSuccess:(NSString *)type imgName:(NSString *)imgName {
    __weak __typeof(self)weakSelf = self;
    HEBPaySuccessViewController *success = [[HEBPaySuccessViewController alloc] init];
    success.money = [NSString stringWithFormat:@"¥ %@", [self.pay_price stringByReplacingOccurrencesOfString:@"¥" withString:@""]];
    success.successMsg = @"支付成功";
    success.imgName = imgName;
    success.cellModelArr = @[@{@"title":@"商品", @"msg":@"乐享币充值"},
                             @{@"title":@"交易时间", @"msg":[Tools getCurrentTimesWithType:@"yyyy年MM月dd日 HH:mm:ss"]},
                             @{@"title":@"支付方式", @"msg":type},
                             ];
    success.success = ^{
        if (weakSelf.paySuccess) {
            weakSelf.paySuccess();
        }
    };
    [self.navigationController pushViewController:success animated:YES];
}

- (void)aliPayCallBack:(NSDictionary *)object {
    HEBAliPayModel *model = [HEBAliPayModel yy_modelWithDictionary:object];
    if ([model.resultStatus isEqualToString:@"9000"]) {
        [self paySuccessType:@"支付宝支付" imgName:@"支付宝支付成功"];
    }else {
        [ISMessages showCardAlertWithTitle:@"支付失败" message:model.memo duration:2.25 hideOnSwipe:NO hideOnTap:NO alertType:ISAlertTypeError alertPosition:ISAlertPositionTop didHide:nil];
    }
}

- (void)paySuccessType:(NSString *)type imgName:(NSString *)imgName {
    __weak __typeof(self)weakSelf = self;
    HEBPaySuccessViewController *success = [[HEBPaySuccessViewController alloc] init];
    success.money = [NSString stringWithFormat:@"¥ %@", [self.money stringByReplacingOccurrencesOfString:@"¥" withString:@""]];
    success.successMsg = @"支付成功";
    success.imgName = imgName;
    if (self.isHiddenHeader) {
        success.cellModelArr = @[@{@"title":@"店铺名称", @"msg":self.shopName}];
        success.Hiddenimg = YES;
        success.successMsg = self.paySuccessMsg;
    }else {
        success.cellModelArr = @[@{@"title":@"商品", @"msg":[NSString stringWithFormat:@"%@-%@", self.paySuccessMsg, self.orderNumber]},
                                 @{@"title":@"交易时间", @"msg":[Tools getCurrentTimesWithType:@"yyyy年MM月dd日 HH:mm:ss"]},
                                 @{@"title":@"支付方式", @"msg":type},
                                 @{@"title":@"交易单号", @"msg":self.orderNumber}];
    }
    success.success = ^{
        if (weakSelf.paySuccess) {
            weakSelf.paySuccess();
        }
    };
    [self.navigationController pushViewController:success animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.tintColor = UIColorBlack;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"aliPayResult" object:nil];
     [[NSNotificationCenter defaultCenter] removeObserver:self name:@"weChatPayResult" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"aliPayTopup" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"weChatTopup" object:nil];
}

@end
