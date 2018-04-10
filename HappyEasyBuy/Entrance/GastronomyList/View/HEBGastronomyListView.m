//
//  HEBGastronomyListView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/24.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBGastronomyListView.h"
#import "HEBShopDetailsViewController.h"

@interface HEBGastronomyListView ()<QMUITableViewDelegate, QMUITableViewDataSource>


@end

@implementation HEBGastronomyListView

- (void)loadView {
    self.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    self.dataSource = self;
    self.delegate = self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.foodStoresModelArrM.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    QMUITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[QMUITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }else {
        while (cell.contentView.subviews.lastObject) {
            [cell.contentView.subviews.lastObject removeFromSuperview];
        }
    }
    cell.dividingLine = YES;
    HEBFoodStoresView *foodStoresView = [[HEBFoodStoresView alloc] init];
    [foodStoresView setCellWithModel:self.foodStoresModelArrM[indexPath.row]];
    [cell.contentView addSubview:foodStoresView];
    [foodStoresView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(cell.contentView);
    }];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView qmui_clearsSelection];
    HEBShopDetailsViewController *shop = [[HEBShopDetailsViewController alloc] init];
    shop.shop_id = self.foodStoresModelArrM[indexPath.row].shopid;
    [self.viewController.navigationController pushViewController:shop animated:YES];
}

- (NSMutableArray<HEBFoodStoresModel *> *)foodStoresModelArrM {
    if (!_foodStoresModelArrM) {
        _foodStoresModelArrM = [NSMutableArray array];
    }
    return _foodStoresModelArrM;
}

@end
