//
//  HEBSearchView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/1.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBSearchView.h"
#import "HEBShopDetailsViewController.h"

@interface HEBSearchView ()<QMUITableViewDataSource, QMUITableViewDelegate>

@end

@implementation HEBSearchView

- (void)loadView {
    self.dataSource = self;
    self.delegate = self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.foodStoresModelArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
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
    [foodStoresView setCellWithModel:self.foodStoresModelArr[indexPath.row]];
    [cell.contentView addSubview:foodStoresView];
    [foodStoresView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(cell.contentView);
    }];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView qmui_clearsSelection];
    HEBShopDetailsViewController *shop = [[HEBShopDetailsViewController alloc] init];
    shop.shop_id = self.foodStoresModelArr[indexPath.row].shopid;
    [self.viewController.navigationController pushViewController:shop animated:YES];
}

- (NSArray<HEBFoodStoresModel *> *)foodStoresModelArr {
    if (!_foodStoresModelArr) {
        _foodStoresModelArr = [NSArray array];
    }
    return _foodStoresModelArr;
}

@end
