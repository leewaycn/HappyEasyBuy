//
//  HEBAccountBalanceTransferViewController.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/28.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBAccountBalanceTransferViewController.h"
#import "HEBAccountBalanceTransferView.h"
#import "HEBPayPasswordViewController.h"
#import "HEBPaySuccessViewController.h"
#import <WXApi.h>
#import <AlipaySDK/AlipaySDK.h>
#import "HEBWeChatModel.h"
#import "HEBAliPayModel.h"

@interface HEBAccountBalanceTransferViewController ()

@property(nonatomic, strong) HEBAccountBalanceTransferView *transferView;

@property(nonatomic, copy) NSString *money;

@end

@implementation HEBAccountBalanceTransferViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"转账";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(transferWeCaht:) name:@"transferWeCaht" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(transferAli:) name:@"transferAli" object:nil];
}

- (void)setUI {
    HEBAccountBalanceTransferView *transferView = [[HEBAccountBalanceTransferView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    selfClass(transferView);
    [self.baseView addSubview:transferView];
    [transferView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.baseView.mas_top);
        make.left.right.bottom.equalTo(self.view);
    }];
    transferView.getPayType = ^(NSInteger payType, NSString *money, NSString *user) {
        NSDictionary *params = @{@"user_id":getUser_id, @"money":money, @"transfer_id":user};
        self.money = money;
        switch (payType) {
            case 0:{
                [self.progressHUD showAnimated:YES];
                [Networking postUrl:TransferWeChatPay params:@{@"user_id":getUser_id, @"price":money} callBack:^(id response, MainModel *mainModel, NSError *errorData) {
                    [self dismissProgressHUD];
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
            }break;
            case 1:{
                [self.progressHUD showAnimated:YES];
                [Networking postUrl:TransferAliPay params:@{@"user_id":getUser_id, @"price":money} callBack:^(id response, MainModel *mainModel, NSError *errorData) {
                    [self dismissProgressHUD];
                    [[AlipaySDK defaultService] payOrder:mainModel.data fromScheme:AliAppScheme callback:^(NSDictionary *resultDic) {
                        HEBAliPayModel *model = [HEBAliPayModel yy_modelWithDictionary:resultDic];
                        if ([model.resultStatus isEqualToString:@"9000"]) {
                            [self.navigationController popViewControllerAnimated:YES];
                        }else {
                            [ISMessages showCardAlertWithTitle:@"支付失败" message:model.memo duration:2.25 hideOnSwipe:NO hideOnTap:NO alertType:ISAlertTypeError alertPosition:ISAlertPositionTop didHide:nil];
                        }
                    }];
                }];
            }break;
            case 2:{
                [self.progressHUD showAnimated:YES];
                [Networking postUrl:Balance params:@{@"user_id":getUser_id} callBack:^(id response, MainModel *mainModel, NSError *errorData) {
                    [self dismissProgressHUD];
                    if ([mainModel.data floatValue] >= money.floatValue) {
                        HEBPayPasswordViewController *pass = [[HEBPayPasswordViewController alloc] init];
                        pass.modalPresentationStyle = UIModalPresentationCustom;
                        pass.payType = @"账户余额";
                        pass.payMsg = @"余额转账";
                        pass.payMoney = [NSString stringWithFormat:@"¥ %@", money];
                        pass.payHost = BalanceTransfer;
                        pass.params = params;
                        pass.payStatus = ^(BOOL status) {
                            if (self.paySuccess) {
                                self.paySuccess(money);
                                [self.navigationController popViewControllerAnimated:YES];
                            }
                        };
                        [self presentViewController:pass animated:YES completion:nil];
                    }else {
                        [ISMessages showCardAlertWithTitle:@"转账失败" message:@"您当前账户余额不足" duration:2.25 hideOnSwipe:NO hideOnTap:NO alertType:ISAlertTypeError alertPosition:ISAlertPositionTop didHide:nil];
                    }
                }];
                
            }break;
            default:
                break;
        }
    };
}

- (void)transferWeCaht:(NSNotification *)cation {
    BaseResp *model = cation.object;
    if (model.errCode == 0) {
            [self.navigationController popViewControllerAnimated:YES];
    }else {
        [ISMessages showCardAlertWithTitle:@"支付失败" message:@"微信支付失败" duration:2.25 hideOnSwipe:NO hideOnTap:NO alertType:ISAlertTypeError alertPosition:ISAlertPositionTop didHide:nil];
    }
}

- (void)transferAli:(NSNotification *)cation {
    HEBAliPayModel *model = [HEBAliPayModel yy_modelWithDictionary:cation.object];
    if ([model.resultStatus isEqualToString:@"9000"]) {
        [self.navigationController popViewControllerAnimated:YES];
    }else {
        [ISMessages showCardAlertWithTitle:@"支付失败" message:model.memo duration:2.25 hideOnSwipe:NO hideOnTap:NO alertType:ISAlertTypeError alertPosition:ISAlertPositionTop didHide:nil];
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"transferWeCaht" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"transferAli" object:nil];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

@end
