//
//  HEBBalanceRecordView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2018/1/11.
//  Copyright © 2018年 happyEsayBuy. All rights reserved.
//

#import "HEBBalanceRecordView.h"
#import "HEBBalanceRecordCell.h"

@interface HEBBalanceRecordView ()<QMUITableViewDelegate, QMUITableViewDataSource>

@end

@implementation HEBBalanceRecordView

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
    return 60;
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
    HEBBalanceRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[HEBBalanceRecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }else {
        while (cell.contentView.subviews.lastObject) {
            [cell.contentView.subviews.lastObject removeFromSuperview];
        }
    }
    cell.userInteractionEnabled = NO;
    [cell setCellINFO];
    HEBBalanceRecordModel *model = self.recordModelArr[indexPath.section];
    cell.time.text = model.time;
    cell.pay.text = nil;
    if (model.orderid.length) {
        cell.money.text = [NSString stringWithFormat:@"+%@", model.price];
        if (!model.username.length) {
            cell.pay.text = [NSString stringWithFormat:@"%@ -%@", model.payway, model.price];
            cell.order.text = [NSString stringWithFormat:@"订单号: %@", model.orderid];
        }else {
            cell.order.text = [NSString stringWithFormat:@"账号: %@", model.username];
        }
    }else {
        cell.order.text = [NSString stringWithFormat:@"%@: %@", model.txyh, model.txcard];
        cell.money.text = [NSString stringWithFormat:@"-%@", model.price];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView qmui_clearsSelection];
    
}

- (NSMutableArray<HEBBalanceRecordModel *> *)recordModelArr {
    if (!_recordModelArr) {
        _recordModelArr = [NSMutableArray array];
    }
    return _recordModelArr;
}

@end
