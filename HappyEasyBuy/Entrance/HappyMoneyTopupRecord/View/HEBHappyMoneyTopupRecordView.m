//
//  HEBHappyMoneyTopupRecordView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2018/1/10.
//  Copyright © 2018年 happyEsayBuy. All rights reserved.
//

#import "HEBHappyMoneyTopupRecordView.h"
#import "HEBHappyMoneyTopupRecordCell.h"

@interface HEBHappyMoneyTopupRecordView ()<QMUITableViewDelegate, QMUITableViewDataSource>

@end

@implementation HEBHappyMoneyTopupRecordView

- (void)loadView {
    self.dataSource = self;
    self.delegate = self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.recordModelArr.count;
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
    HEBHappyMoneyTopupRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[HEBHappyMoneyTopupRecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }else {
        while (cell.contentView.subviews.lastObject) {
            [cell.contentView.subviews.lastObject removeFromSuperview];
        }
    }
    cell.userInteractionEnabled = NO;
    [cell setCellINFO];
    HEBHappyMoneyTopupRecordModel *model = self.recordModelArr[indexPath.section];
    cell.order.text = [NSString stringWithFormat:@"订单号: %@", model.orderid];
    cell.type.text = @"充值";
    cell.money.text = [NSString stringWithFormat:@"+%@", model.consume_num];
    cell.time.text = model.pay_time;
    cell.payMoney.text = [NSString stringWithFormat:@"%@ -%@", model.pay_type==1?@"微信":@"支付宝", model.pay_price];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView qmui_clearsSelection];
    
}

- (NSMutableArray<HEBHappyMoneyTopupRecordModel *> *)recordModelArr {
    if (!_recordModelArr) {
        _recordModelArr = [NSMutableArray array];
    }
    return _recordModelArr;
}

@end
