//
//  HEBorderAffirmViewController.m
//  HappyEasyBuy
//
//  Created by 孙程 on 2017/11/15.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEIntegratedMallOrderViewController.h"
#import "HEBIntegratedMallOrderView.h"
#import "HEBIntegratedMallOrderCell.h"
#import "HEBPaySuccessViewController.h"

@interface HEIntegratedMallOrderViewController ()

/** 确认兑换 */
@property(nonatomic, strong) QMUIButton *submit;

@property(nonatomic, strong) HEBIntegratedMallOrderView *orderView;

@end

@implementation HEIntegratedMallOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单确认";
}

- (void)setUI {
    HEBIntegratedMallOrderView *orderView = [[HEBIntegratedMallOrderView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    selfClass(orderView);
    orderView.isReal = self.isReal;
    [orderView.headerView.icon yy_setImageWithURL:[NSURL URLWithString:self.imgUrl] options:YYWebImageOptionProgressive];
    orderView.headerView.name.text = self.name;
    orderView.integral = self.integral;
    orderView.headerView.count.text = [NSString stringWithFormat:@"数量: %@", self.count];
    orderView.headerView.integral.text = self.integral;
    [self.baseView addSubview:orderView];
    [orderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.baseView.mas_top);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo([self toolView].mas_top);
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = nil;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (UIView *)toolView {
    UIView *toolView = [[UIView alloc] init];
    toolView.backgroundColor = UIColorWhite;
    [self.baseView addSubview:toolView];
    [toolView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_offset(54);
    }];
    QMUILabel *msg = [[QMUILabel alloc] init];
    msg.text = [NSString stringWithFormat:@"兑换积分: %@", self.integral];
    msg.textColor = BASEBLACK;
    msg.font = UIFontMake(16);
    [toolView addSubview:msg];
    [msg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(toolView.mas_centerY);
        make.left.equalTo(toolView.mas_left).offset(15);
    }];
    QMUIButton *submit = [[QMUIButton alloc] init];
    selfClass(submit);
    submit.backgroundColor = BASECOLOR;
    [submit setTitle:@"确认兑换" forState:UIControlStateNormal];
    [submit setTitleColor:UIColorWhite forState:UIControlStateNormal];
    submit.titleLabel.font = UIFontMake(16);
    [toolView addSubview:submit];
    [submit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(toolView.mas_centerY);
        make.width.mas_offset(100);
        make.right.equalTo(toolView.mas_right).offset(-15);
        make.height.equalTo(toolView.mas_height).offset(-15);
    }];
    [submit addTarget:self action:@selector(submitDidClick) forControlEvents:UIControlEventTouchUpInside];
    submit.layer.cornerRadius = 5;
    submit.layer.masksToBounds = YES;
    return toolView;
}

- (void)submitDidClick {
    [self.progressHUD showAnimated:YES];
    __weak __typeof(self)weakSelf = self;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:getUser_id forKey:@"user_id"];
    [params setObject:self.isReal?@"1":@"0" forKey:@"model"];
    [params setObject:self.goods_id forKey:@"id"];
    if (self.isReal) {
        HEBIntegratedMallOrderCell *user = (id)[self.orderView cellForRow:0 inSection:1];
        HEBIntegratedMallOrderCell *mobNumber = (id)[self.orderView cellForRow:1 inSection:1];
        HEBIntegratedMallOrderCell *address = (id)[self.orderView cellForRow:2 inSection:1];
        if (user.infoField.hasText && mobNumber.infoField.hasText && address.infoField.hasText) {
            [params setObject:user.infoField.text forKey:@"name"];
            [params setObject:mobNumber.infoField.text forKey:@"phone"];
            [params setObject:address.infoField.text forKey:@"address"];
        }else {
            [ISMessages showCardAlertWithTitle:@"兑换失败" message:@"请将收货人信息填写完整" duration:2.25 hideOnSwipe:NO hideOnTap:NO alertType:ISAlertTypeError alertPosition:ISAlertPositionTop didHide:nil];
            return;
        }
    }
    [Networking postUrl:IntegralExchange params:params callBack:^(id response, MainModel *mainModel, NSError *errorData) {
        [weakSelf dismissProgressHUD];
        [ISMessages showCardAlertWithTitle:@"操作完成" message:mainModel.msg duration:2.25 hideOnSwipe:NO hideOnTap:NO alertType:!mainModel.status alertPosition:ISAlertPositionBottom didHide:nil];
        if (mainModel.status) {
            HEBPaySuccessViewController *success = [[HEBPaySuccessViewController alloc] init];
            success.money = mainModel.data[@"consume"];
            success.successMsg = @"兑换成功";
            success.imgName = @"积分支付成功";
            success.cellModelArr = @[@{@"title":@"商品说明", @"msg":mainModel.data[@"goods_description"]},
                                     @{@"title":@"订单时间", @"msg":mainModel.data[@"buytime"]},
                                     @{@"title":@"订单号", @"msg":mainModel.data[@"order"]}];
            success.success = ^{
                [weakSelf.navigationController popToRootViewControllerAnimated:YES];
            };
            [weakSelf.navigationController pushViewController:success animated:YES];
        }
    }];
}

@end
