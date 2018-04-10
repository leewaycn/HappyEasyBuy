//
//  HEBOrderListView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/19.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBOrderListView.h"
#import "HEBOrderListCell.h"
#import "HEBOrderPayViewController.h"
#import "HEBPostCommentsViewController.h"
#import "HEBOrderFoodDetailViewController.h"
#import "HEBOrderHotelDetailViewController.h"
#import "HEBOrderTakOutDetailViewController.h"
#import "HEBOrderIntegratedDetailViewController.h"

@interface HEBOrderListView ()<QMUITableViewDelegate, QMUITableViewDataSource>

@end

@implementation HEBOrderListView

- (void)loadView {
    self.dataSource = self;
    self.delegate = self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.orderlistArrM.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    HEBOrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[HEBOrderListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }else {
        while (cell.contentView.subviews.lastObject) {
            [cell.contentView.subviews.lastObject removeFromSuperview];
        }
    }
    cell.userInteractionEnabled = YES;
    cell.backgroundColor = self.backgroundColor;
    [cell setCellINFO];
    HEBOrderListModel *model = self.orderlistArrM[indexPath.section];
    [cell.icon yy_setImageWithURL:[NSURL URLWithString:model.pic] options:YYWebImageOptionProgressive];
    cell.name.text = model.name;
    cell.time.text = model.ctime;
    if (model.type) {
        cell.money.text = [NSString stringWithFormat:@"¥ %@", model.money];
        cell.status.hidden = model.statusHidden;
        cell.status.userInteractionEnabled = model.statusEnabled;
        [cell.status setTitle:model.statusStr forState:UIControlStateNormal];
        cell.status.tag = indexPath.section;
        if (model.status == 1) {
            [cell.status addTarget:self action:@selector(orderPay:) forControlEvents:UIControlEventTouchUpInside];
        }else if (model.status == 5) {
            [cell.status addTarget:self action:@selector(postComments:) forControlEvents:UIControlEventTouchUpInside];
        }else if (model.type == 2 && model.status == 3) {
            [cell.status addTarget:self action:@selector(changeOrderStatus:) forControlEvents:UIControlEventTouchUpInside];
        }
    }else {
        cell.money.font = UIFontMake(16);
        cell.money.text = [NSString stringWithFormat:@"%@积分", model.money];
        cell.status.userInteractionEnabled = NO;
        [cell.status setTitle:@"X 1" forState:UIControlStateNormal];
        [cell.status setTitleColor:BASEBLACK forState:UIControlStateNormal];
        cell.status.layer.borderWidth = 0;
        [cell.name mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(cell.contentView.mas_centerY).offset(-5);
            make.left.equalTo(cell.icon.mas_right).offset(15);
        }];
        [cell.money mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(cell.contentView.mas_centerY).offset(5);
            make.left.equalTo(cell.name.mas_left);
        }];
        cell.userInteractionEnabled = !self.isVirtual;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView qmui_clearsSelection];
    HEBOrderListModel *model = self.orderlistArrM[indexPath.section];
    if (model.type == 1 || model.type == 3 || model.type == 2) {
        HEBOrderFoodDetailViewController *orderDetail = [[HEBOrderFoodDetailViewController alloc] init];
        orderDetail.url = model.type == 1?OrderFoodDetail:model.type==2?OrderMoveDetail:OrderFootDetail;
        orderDetail.orderid = model.oid;
        [self.viewControl.navigationController pushViewController:orderDetail animated:YES];
    }else if (model.type == 4) {
        HEBOrderHotelDetailViewController *hotel = [[HEBOrderHotelDetailViewController alloc] init];
        hotel.orderid = model.oid;
        [self.viewControl.navigationController pushViewController:hotel animated:YES];
    }else if (model.type == 5) {
        HEBOrderTakOutDetailViewController *takeout = [[HEBOrderTakOutDetailViewController alloc] init];
        takeout.orderid = model.oid;
        [self.viewControl.navigationController pushViewController:takeout animated:YES];
    }else {
        HEBOrderIntegratedDetailViewController *integr = [[HEBOrderIntegratedDetailViewController alloc] init];
        integr.orderid = model.order;
        [self.viewControl.navigationController pushViewController:integr animated:YES];
    }
}

- (void)orderPay:(QMUIButton *)sender {
    HEBOrderListModel *model = self.orderlistArrM[sender.tag];
    HEBOrderPayViewController *pay = [[HEBOrderPayViewController alloc] init];
    pay.money = model.money;
    pay.objName = model.name;
    pay.img = model.pic;
    pay.orderNumber = model.ordernumber;
    switch (model.type) {
        case 1:
            pay.weChatPayFlag = @"8";
            pay.aliPayHost = GoodsFoodAliPay;
            pay.aliPayKey = @"orderid";
            pay.payMsg = model.name;
            pay.paySuccessMsg = @"美食订单";
            pay.balancePayHost = GoodsBalancePay;
            pay.balanceParams = @{@"number":model.ordernumber,
                                  @"order_payprice":model.money,
                                  @"order_pay_type":@"3"
                                  };
            pay.happyMoneyPayHost = GoodHappyMoneyPay;
            pay.happyMoneyParmas = @{@"number":model.ordernumber,
                                     @"order_payprice":model.money,
                                     @"order_pay_type":@"4"
                                     };
            break;
        case 5:
            pay.weChatPayFlag = @"1";
            pay.aliPayHost = TakeOutAliPay;
            pay.aliPayKey = @"oid";
            pay.payMsg = @"外卖订单";
            pay.paySuccessMsg = @"本地生活订单";
            pay.balancePayHost = TakeOutBalancePay;
            pay.balanceParams = @{@"oid":model.ordernumber,
                                  @"pay_price":model.money,
                                  @"pay_type":@"3"
                                  };
            pay.happyMoneyPayHost = TakeOutHappyMoneyPay;
            pay.happyMoneyParmas = @{@"oid":model.ordernumber,
                                     @"pay_price":model.money,
                                     @"pay_type":@"4"
                                     };
            break;
        default:
            break;
    }
    
    __weak __typeof(self)weakSelf = self;
    @weakify(pay);
    @weakify(sender);
    pay.paySuccess = ^{
        [weak_pay.navigationController popViewControllerAnimated:NO];
        [weak_pay.navigationController.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[NSClassFromString(@"HEBOrderListViewController") class]]) {
                [weak_pay.navigationController popToViewController:obj animated:YES];
            }
        }];
        [weakSelf.orderlistArrM[weak_sender.tag] setStatus:2];
        if (weak_sender.tag) {
            HEBOrderListModel *listModel = weakSelf.orderlistArrM.firstObject;
            if (listModel.status == 1) {
                [weakSelf.orderlistArrM removeObjectAtIndex:weak_sender.tag];
                [weakSelf deleteSection:sender.tag withRowAnimation:UITableViewRowAnimationNone];
            }else {
                [weakSelf reloadSection:weak_sender.tag withRowAnimation:UITableViewRowAnimationNone];
            }
        }else {
            HEBOrderListModel *listModel = weakSelf.orderlistArrM.lastObject;
            if (listModel.status == 1) {
                [weakSelf.orderlistArrM removeObjectAtIndex:weak_sender.tag];
                [weakSelf deleteSection:sender.tag withRowAnimation:UITableViewRowAnimationNone];
            }else {
                [weakSelf reloadSection:weak_sender.tag withRowAnimation:UITableViewRowAnimationNone];
            }
        }
    };
    [self.viewController.navigationController pushViewController:pay animated:YES];
}

- (void)postComments:(QMUIButton *)sender {
    HEBOrderListModel *model = self.orderlistArrM[sender.tag];
    HEBPostCommentsViewController *comments = [[HEBPostCommentsViewController alloc] init];
    comments.shop_id = model.shopid;
    comments.orderNumber = model.ordernumber;
    comments.type = [NSString stringWithFormat:@"%d", model.type];
    __weak __typeof(self)weakSelf = self;
    comments.CommentSuccess = ^{
        [weakSelf.orderlistArrM removeObjectAtIndex:sender.tag];
        [weakSelf reloadData];
    };
    [self.viewController.navigationController pushViewController:comments animated:YES];
}

- (void)changeOrderStatus:(QMUIButton *)sender {
    QMUIAlertController *alert = [QMUIAlertController alertControllerWithTitle:@"提示" message:@"订单确认" preferredStyle:QMUIAlertControllerStyleAlert];
    [alert addAction:[QMUIAlertAction actionWithTitle:@"确认" style:QMUIAlertActionStyleDefault handler:^(QMUIAlertAction *action) {
        [self.viewControl.progressHUD showAnimated:YES];
        HEBOrderListModel *model = self.orderlistArrM[sender.tag];
        __weak __typeof(self)weakSelf = self;
        [Networking postUrl:ChangeOrderStatus params:@{@"type":[NSString stringWithFormat:@"%d", model.type], @"ordernumber":model.ordernumber, @"status":@"5"} callBack:^(id response, MainModel *mainModel, NSError *errorData) {
            [weakSelf.viewControl dismissProgressHUD];
            [ISMessages showCardAlertWithTitle:nil message:response[@"mag"] duration:2.25 hideOnSwipe:NO hideOnTap:NO alertType:!mainModel.status alertPosition:ISAlertPositionTop didHide:nil];
            if (mainModel.status) {
                [model setType:5];
                [model setStatusHidden:YES];
                [weakSelf.orderlistArrM replaceObjectAtIndex:sender.tag withObject:model];
                [weakSelf reloadRow:0 inSection:sender.tag withRowAnimation:UITableViewRowAnimationNone];
            }
        }];
    }]];
    [alert addAction:[QMUIAlertAction actionWithTitle:@"取消" style:QMUIAlertActionStyleCancel handler:^(QMUIAlertAction *action) {}]];
    [alert showWithAnimated:YES];
    
}

- (NSMutableArray<HEBOrderListModel *> *)orderlistArrM {
    if (!_orderlistArrM) {
        _orderlistArrM = [NSMutableArray array];
    }
    return _orderlistArrM;
}

@end
