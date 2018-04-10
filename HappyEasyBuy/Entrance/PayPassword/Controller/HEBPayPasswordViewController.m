//
//  HEBPayPasswordViewController.m
//  HappyEasyBuy
//
//  Created by Dwang on 2018/1/3.
//  Copyright © 2018年 happyEsayBuy. All rights reserved.
//

#import "HEBPayPasswordViewController.h"
#import "HEBPayPasswordView.h"

@interface HEBPayPasswordViewController ()<UIGestureRecognizerDelegate>

@property(nonatomic, strong) HEBPayPasswordView *payPass;

@end

@implementation HEBPayPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.baseView.backgroundColor = UIColorWithRGBA(1, 1, 1, 0.2);
    self.view.backgroundColor = UIColorWithRGBA(1, 1, 1, 0.2);
    __weak __typeof(self)weakSelf = self;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    }];
    self.baseView.tag = 100;
    tap.delegate = self;
    [self.baseView addGestureRecognizer:tap];
}

- (void)setUI {
    HEBPayPasswordView *payPass = [[HEBPayPasswordView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    selfClass(payPass);
    [self.baseView addSubview:payPass];
    [payPass mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view.mas_centerY);
    }];
    payPass.cellModelArr = @[@{@"title":@"订单信息", @"content":self.payMsg},
                             @{@"title":@"付款方式", @"content":self.payType}];
    payPass.headerView.money.text = self.payMoney;
    [payPass.pay addTarget:self action:@selector(payDidClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)payDidClick {
    if (self.payPass.headerView.payPass.hasText) {
        [self.progressHUD showAnimated:YES];
        __weak __typeof(self)weakSelf = self;
        [Networking postUrl:CheckPayPass params:@{@"paycode":self.payPass.headerView.payPass.text.md5String, @"vip_id":getUser_id} callBack:^(id response, MainModel *mainModel, NSError *errorData) {
            if (mainModel.status) {
                [Networking postUrl:weakSelf.payHost params:weakSelf.params callBack:^(id response, MainModel *mainModel, NSError *errorData) {
                    [weakSelf dismissProgressHUD];
                    if (mainModel.status) {
                        if (weakSelf.payStatusStr) {
                            weakSelf.payStatusStr(mainModel.data[@"oid"]);
                            [weakSelf dismissViewControllerAnimated:YES completion:nil];
                        }
                    }
                    if (weakSelf.payStatus) {
                        weakSelf.payStatus(mainModel.status);
                        [weakSelf dismissViewControllerAnimated:YES completion:nil];
                    }
                }];
            }else {
                [weakSelf dismissProgressHUD];
                 [ISMessages showCardAlertWithTitle:@"支付失败" message:mainModel.msg duration:2.25 hideOnSwipe:NO hideOnTap:NO alertType:ISAlertTypeError alertPosition:ISAlertPositionTop didHide:nil];
            }
        }];
    }else {
        [ISMessages showCardAlertWithTitle:@"支付失败" message:@"请输入您的支付密码" duration:2.25 hideOnSwipe:NO hideOnTap:NO alertType:ISAlertTypeError alertPosition:ISAlertPositionTop didHide:nil];
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    return (touch.view.tag == 100);
}

@end
