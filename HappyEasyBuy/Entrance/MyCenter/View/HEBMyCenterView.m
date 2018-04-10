//
//  HEBMyCenterView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/27.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBMyCenterView.h"
#import "HEBMyCenterCell.h"
#import "HEBBalanceViewController.h"
#import "HEBHappyMoneyViewController.h"
#import "HEBIntegralViewController.h"
#import "HEBFinanceViewController.h"
#import "HEBBillViewController.h"
#import "HEBIndentViewController.h"
#import "HEBAppraiseViewController.h"
#import "HEBLocationViewController.h"
#import "HEBDiscountViewController.h"
#import "HEBLifePayViewController.h"
#import "HEBMerchantViewController.h"
#import "HEBMyMerchantsViewController.h"

@interface HEBMyCenterView ()<QMUITableViewDelegate, QMUITableViewDataSource>

@property(nonatomic, strong) NSArray<NSArray<NSDictionary *> *> *myCenterArr;

@end

@implementation HEBMyCenterView

- (void)loadView {
    HEBMyCenterHeaderView *headerView = [[HEBMyCenterHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 120)];
    selfClass(headerView);
    self.tableHeaderView = headerView;
    self.dataSource = self;
    self.delegate = self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.myCenterArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.myCenterArr[section].count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section==0?CGFLOAT_MIN:35;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return nil;
    }
    NSArray <NSString *>*arr = @[@"乐享金融", @"本地生活"];
    UIView *header = [[UIView alloc] init];
    QMUILabel *lab = [[QMUILabel alloc] init];
    lab.text = arr[section-1];
    lab.textColor = BASEBLACK;
    lab.font = UIFontMake(14);
    [header addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(header.mas_left).offset(15);
        make.bottom.equalTo(header.mas_bottom).offset(-3);
    }];
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    HEBMyCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[HEBMyCenterCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }else {
        while (cell.contentView.subviews.lastObject) {
            [cell.contentView.subviews.lastObject removeFromSuperview];
        }
    }
    if ([self.myCenterArr[indexPath.section][indexPath.row][@"title"] isEqualToString:@"我的积分:"]) {
        cell.userInteractionEnabled = NO;
        cell.accessoryType = UITableViewCellAccessoryNone;
    }else {
        cell.userInteractionEnabled = YES;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.dividingLine = YES;
    cell.detailTextLabel.textColor = BASECOLOR;
    [cell setCellINFO];
    cell.img.image = UIImageMake(self.myCenterArr[indexPath.section][indexPath.row][@"title"]);
    cell.title.text = self.myCenterArr[indexPath.section][indexPath.row][@"title"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView qmui_clearsSelection];
    if (!getUser_id) {
        [ISMessages showCardAlertWithTitle:@"操作失败" message:@"请登录后再进行此操作" duration:2.25 hideOnSwipe:NO hideOnTap:NO alertType:ISAlertTypeError alertPosition:ISAlertPositionTop didHide:nil];
        return;
    }
    HEBMyCenterCell *cell = (id)[tableView cellForRowAtIndexPath:indexPath];
    NSString *title = self.myCenterArr[indexPath.section][indexPath.row][@"title"];
    HEBBaseViewController *vc;
    if ([title isEqualToString:@"余额:"]) {
        vc = [[HEBBalanceViewController alloc] init];
        HEBBalanceViewController *balance = (HEBBalanceViewController *)vc;
        balance.withdrawalSuccess = ^(NSString *money) {
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@元", money];
        };
        balance.topuoSuccess = ^(NSString *money) {
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@元", money];
        };
        [vc setValue:cell.detailTextLabel.text forKeyPath:@"accountBalance"];
    }
    if ([title isEqualToString:@"乐享币:"]) {
        vc = [[HEBHappyMoneyViewController alloc] init];
        HEBHappyMoneyViewController *mvc = (HEBHappyMoneyViewController *)vc;
        mvc.happyMoney = cell.detailTextLabel.text;
        mvc.getHappyMoney = ^(NSString *money) {
            cell.detailTextLabel.text = money;
        };
    }
    if ([title isEqualToString:@"生活缴费"]) {
        vc = [[HEBLifePayViewController alloc] init];
    }
    if ([title isEqualToString:@"金融理财"]) {
        vc = [[HEBFinanceViewController alloc] init];
    }
    if ([title isEqualToString:@"账单"]) {
        vc = [[HEBBillViewController alloc] init];
    }
    if ([title isEqualToString:@"金融产品订单"]) {
        vc = [[HEBIndentViewController alloc] init];
    }
    if ([title isEqualToString:@"我的评价"]) {
        vc = [[HEBAppraiseViewController alloc] init];
    }
    if ([title isEqualToString:@"我的地址"]) {
        vc = [[HEBLocationViewController alloc] init];
    }
    if ([title isEqualToString:@"优惠券"]) {
        vc = [[HEBDiscountViewController alloc] init];
    }
    if ([title isEqualToString:@"商家入驻"]) {
        vc = [[HEBMerchantViewController alloc] init];
    }
    if ([title isEqualToString:@"我是商家"]) {
        vc = [[HEBMyMerchantsViewController alloc] init];
    }
    [self.viewControl.navigationController pushViewController:vc animated:YES];
}

- (NSArray<NSArray<NSDictionary *> *> *)myCenterArr {
    if (!_myCenterArr) {
        _myCenterArr = @[@[@{@"title":@"余额:"},
                           @{@"title":@"乐享币:"},
                           @{@"title":@"我的积分:"},
                           /*@{@"title":@"生活缴费"}*/],
                         /*
                         @[@{@"title":@"金融理财"},
                           @{@"title":@"账单"},
                           @{@"title":@"金融产品订单"}],
                          */
                         @[@{@"title":@"我的评价"},
                           @{@"title":@"我的地址"},
                           @{@"title":@"优惠券"},
                           @{@"title":@"商家入驻"},
                           @{@"title":@"我是商家"}]
                         ];
    }
    return _myCenterArr;
}

@end
