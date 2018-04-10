//
//  HEBShopDetailsView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/25.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBShopDetailsView.h"
#import "HEBPackageDetailsViewController.h"

@interface HEBShopDetailsView ()<QMUITableViewDelegate, QMUITableViewDataSource>

@end

@implementation HEBShopDetailsView

- (void)loadView {
    self.dataSource = self;
    self.delegate = self;
    HEBShopDetailsHeaderView *headerView = [[HEBShopDetailsHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 280+(IS_58INCH_SCREEN?10:0))];
    selfClass(headerView);
    self.tableHeaderView = headerView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section==0?1:self.setMealArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section==0?44:80;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section==1&&self.setMealArr.count?44:section==0?10:CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1 && self.setMealArr.count) {
        UIView *header = [[UIView alloc] init];
        header.backgroundColor = UIColorWhite;
        QMUILabel *labe = [[QMUILabel alloc] init];
        labe.text = @"套餐管理";
        labe.textColor = BASEBLACK;
        labe.font = UIFontMake(16);
        [header addSubview:labe];
        [labe mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(header.mas_centerY);
            make.left.equalTo(header.mas_left).offset(20);
        }];
        return header;
    }
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
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.section == 0) {
        UIImageView *img = [[UIImageView alloc] initWithImage:UIImageMake(@"店铺优惠券")];
        [cell.contentView addSubview:img];
        [img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(cell.contentView.mas_centerY);
            make.left.equalTo(cell.contentView.mas_left).offset(20);
        }];
        QMUILabel *lab = [[QMUILabel alloc] init];
        lab.textColor = BASEBLACK;
        lab.text = @"领取优惠券";
        lab.font = UIFontMake(12);
        [cell.contentView addSubview:lab];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(img.mas_centerY);
            make.left.equalTo(img.mas_right).offset(10);
        }];
    }else {
        cell.dividingLine = YES;
        HEBSetMealView *setMealView = [[HEBSetMealView alloc] init];
        [setMealView setMealViewWithModel:self.setMealArr[indexPath.row]];
        [cell.contentView addSubview:setMealView];
        [setMealView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.right.equalTo(cell.contentView);
        }];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView qmui_clearsSelection];
    if (indexPath.section == 0) {
        if (self.couponsArr.count) {
            HEBGetCouponsView *getCoupons = [[HEBGetCouponsView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT)];
            getCoupons.cellModelArr = self.couponsArr;
            [self.window addSubview:getCoupons];
            [UIView animateWithDuration:1.25 animations:^{
                getCoupons.top = 0;
            }];
            @weakify(getCoupons);
            getCoupons.getDidSelectCoupons = ^(NSString *coupons_id) {
                if (getUser_id) {
                    MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:weak_getCoupons animated:YES];
                    [hub showAnimated:YES];
                    [Networking postUrl:GetCoupon params:@{@"uid":getUser_id, @"cid":coupons_id} callBack:^(id response, MainModel *mainModel, NSError *errorData) {
                        hub.label.text = mainModel.msg;
                        [hub hideAnimated:YES afterDelay:1.25];
                    }];
                }else {
                    ISAlertNotLoginMessage;
                }
            };
        }else {
            [ISMessages showCardAlertWithTitle:@"暂无优惠券"
                        message:@"当前商家暂未推出优惠券"
                        duration:2.25
                        hideOnSwipe:NO
                        hideOnTap:NO
                        alertType:(ISAlertTypeInfo)
                        alertPosition:(ISAlertPositionTop) didHide:nil];
        }
    }else {
        HEBPackageDetailsViewController *pack = [[HEBPackageDetailsViewController alloc] init];
        pack.objid = self.setMealArr[indexPath.row].f_id;
        [self.viewController.navigationController pushViewController:pack animated:YES];
    }
}

- (NSArray<HEBShopSetMealModel *> *)setMealArr {
    if (!_setMealArr) {
        _setMealArr = [NSArray array];
    }
    return _setMealArr;
}

- (NSArray<HEBGetCouponsModel *> *)couponsArr {
    if (!_couponsArr) {
        _couponsArr = [NSArray array];
    }
    return _couponsArr;
}

@end
