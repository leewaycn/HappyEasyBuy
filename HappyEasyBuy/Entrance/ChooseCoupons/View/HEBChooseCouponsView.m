//
//  HEBChooseCouponsView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/1.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBChooseCouponsView.h"
#import "HEBGetCouponsCell.h"

@interface HEBChooseCouponsView ()<QMUITableViewDelegate, QMUITableViewDataSource>

@end

@implementation HEBChooseCouponsView

- (void)loadView {
    self.dataSource = self;
    self.delegate = self;
    self.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.redArr.count?self.redArr.count:self.shopReduceArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 15;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    HEBGetCouponsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[HEBGetCouponsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }else {
        while (cell.contentView.subviews.lastObject) {
            [cell.contentView.subviews.lastObject removeFromSuperview];
        }
    }
    [cell setCell];
    if (self.redArr.count) {
        HEBFoodSnatchOrderPaymentRedDetailModel *model = self.redArr[indexPath.section];
        if (self.money >= model.reducemoney.floatValue) {
            cell.userInteractionEnabled = YES;
            cell.bgView.backgroundColor = BASECOLOR;
            [cell.pickUp setTitle:@"可使用" forState:UIControlStateNormal];
        }else {
            cell.userInteractionEnabled = NO;
            cell.bgView.backgroundColor = UIColorGray;
            [cell.pickUp setTitle:@"未满足条件" forState:UIControlStateNormal];
        }
        cell.reduce.text = [NSString stringWithFormat:@"¥ %@", model.reducemoney];
        cell.conditions.text = [NSString stringWithFormat:@"满 %@ 使用", model.reducemoney];
        cell.aging.text = [NSString stringWithFormat:@"有效期至 %@", model.endtime];
    }else {
        HEBFoodSnatchOrderPaymentCouponDetailModel *model = self.shopReduceArr[indexPath.section];
        if (self.money >= model.usemoney.floatValue) {
            cell.userInteractionEnabled = YES;
            cell.bgView.backgroundColor = BASECOLOR;
            [cell.pickUp setTitle:@"可使用" forState:UIControlStateNormal];
        }else {
            cell.userInteractionEnabled = NO;
            cell.bgView.backgroundColor = UIColorGray;
            [cell.pickUp setTitle:@"未满足条件" forState:UIControlStateNormal];
        }
        cell.reduce.text = [NSString stringWithFormat:@"¥ %@", model.money];
        cell.conditions.text = [NSString stringWithFormat:@"满 %@ 使用", model.usemoney];
        cell.aging.text = [NSString stringWithFormat:@"有效期至 %@", model.etime];
    }
    cell.pickUp.userInteractionEnabled = NO;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView qmui_clearsSelection];
    if (self.redArr.count) {
        HEBFoodSnatchOrderPaymentRedDetailModel *model = self.redArr[indexPath.section];
        if (self.getMoney) {
            self.getMoney([NSString stringWithFormat:@"¥ %.2f", self.money-model.reducemoney.floatValue], @"lxhb_id", model.objid);
        }
    }else {
        HEBFoodSnatchOrderPaymentCouponDetailModel *model = self.shopReduceArr[indexPath.section];
        if (self.getMoney) {
            self.getMoney([NSString stringWithFormat:@"¥ %.2f", self.money-model.money.floatValue], @"yhq_id", model.lid);
        }
    }
}

- (NSArray<HEBFoodSnatchOrderPaymentRedDetailModel *> *)redArr {
    if (!_redArr) {
        _redArr = [NSArray array];
    }
    return _redArr;
}

- (NSArray<HEBFoodSnatchOrderPaymentCouponDetailModel *> *)shopReduceArr {
    if (!_shopReduceArr) {
        _shopReduceArr = [NSArray array];
    }
    return _shopReduceArr;
}

@end
