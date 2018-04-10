//
//  HEBDiscountView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/29.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBDiscountView.h"
#import "HEBGetCouponsCell.h"

@interface HEBDiscountView ()<QMUITableViewDataSource, QMUITableViewDelegate>

@end

@implementation HEBDiscountView

- (void)loadView {
    self.dataSource = self;
    self.delegate = self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.modelArr.count;
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
    return 10;
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
    HEBDiscountModel *model = self.modelArr[indexPath.section];
    cell.userInteractionEnabled = NO;
    [cell setCell];
    [cell.pickUp setTitle:[NSString stringWithFormat:@"¥ %@", model.money] forState:UIControlStateNormal];
    cell.reduce.text = model.shop_name;
    cell.conditions.text = [NSString stringWithFormat:@"%@", model.yh_des];
    cell.aging.text = [NSString stringWithFormat:@"有效期 %@-%@", model.stime.timeStampYYYYMMDDPoint, model.etime.timeStampYYYYMMDDPoint];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView qmui_clearsSelection];
}

- (NSArray<HEBDiscountModel *> *)modelArr {
    if (!_modelArr) {
        _modelArr = [NSArray array];
    }
    return _modelArr;
}

@end
