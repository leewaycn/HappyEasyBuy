//
//  HEBBalanceView.m
//  HappyEasyBuy
//
//  Created by 孙程 on 2017/11/17.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBBalanceView.h"
#import "HEBMyCenterCell.h"
#import "HEBAccountBalanceTopUPViewController.h"
#import "HEBAccountBalanceWithdrawalViewController.h"
#import "HEBAccountBalanceTransferViewController.h"

@interface HEBBalanceView ()<QMUITableViewDelegate, QMUITableViewDataSource>

@property(nonatomic, strong) NSArray<NSString *> *cellModelArr;

@end

@implementation HEBBalanceView

- (void)loadView {
    self.dataSource = self;
    self.delegate = self;
    HEBBalanceHeaderView *headerView = [[HEBBalanceHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    selfClass(headerView);
    self.tableHeaderView = headerView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cellModelArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    HEBMyCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[HEBMyCenterCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }else {
        while (cell.contentView.subviews.lastObject) {
            [cell.contentView.subviews.lastObject removeFromSuperview];
        }
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.dividingLine = YES;
    [cell setCellINFO];
    cell.img.image = UIImageMake(self.cellModelArr[indexPath.row]);
    cell.title.text = self.cellModelArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView qmui_clearsSelection];
    __weak __typeof(self)weakSelf = self;
    if ([self.cellModelArr[indexPath.row] isEqualToString:@"充值"]) {
       HEBAccountBalanceTopUPViewController *vc = [[HEBAccountBalanceTopUPViewController alloc] init];
        
        vc.getMoney = ^(NSString *money) {
            self.headerView.content.text = [NSString stringWithFormat:@"%.2f元", money.floatValue+[self.headerView.content.text stringByReplacingOccurrencesOfString:@"元" withString:@""].floatValue];
            if (weakSelf.topuoSuccess) {
                weakSelf.topuoSuccess(self.headerView.content.text);
            }
        };
        [self.viewControl.navigationController pushViewController:vc animated:YES];
    }
    if ([self.cellModelArr[indexPath.row] isEqualToString:@"提现"]) {
        HEBAccountBalanceWithdrawalViewController *vc = [[HEBAccountBalanceWithdrawalViewController alloc] init];
       [self.viewControl.navigationController pushViewController:vc animated:YES];
        vc.withdrawalSuccess = ^(NSString *money) {
            weakSelf.headerView.content.text = [NSString stringWithFormat:@"%@元", money];
            if (weakSelf.withdrawalSuccess) {
                weakSelf.withdrawalSuccess(money);
            }
        };
    }
    if ([self.cellModelArr[indexPath.row] isEqualToString:@"转账"]) {
       HEBAccountBalanceTransferViewController *vc = [[HEBAccountBalanceTransferViewController alloc] init];
        vc.paySuccess = ^(NSString *money) {
            self.headerView.content.text = [NSString stringWithFormat:@"%.2f元", [self.headerView.content.text stringByReplacingOccurrencesOfString:@"元" withString:@""].floatValue - money.floatValue];
            if (weakSelf.withdrawalSuccess) {
                weakSelf.withdrawalSuccess(self.headerView.content.text);
            }
        };
        [self.viewControl.navigationController pushViewController:vc animated:YES];
    }
    
}

- (NSArray<NSString *> *)cellModelArr {
    if (!_cellModelArr) {
        _cellModelArr = @[@"充值", @"提现", @"转账"];
    }
    return _cellModelArr;
}

@end
