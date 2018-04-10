//
//  HEBHappyMoneyView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/28.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBHappyMoneyView.h"
#import "HEBMyCenterCell.h"
#import "HEBHappyMoneyTopUpViewController.h"

@interface HEBHappyMoneyView ()<QMUITableViewDelegate, QMUITableViewDataSource>

@property(nonatomic, strong) NSArray<NSString *> *cellModelArr;

@end

@implementation HEBHappyMoneyView

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
    if ([self.cellModelArr[indexPath.row] isEqualToString:@"充值"]) {
        HEBHappyMoneyTopUpViewController *topup = [[HEBHappyMoneyTopUpViewController alloc] init];
        topup.getHappyMoney = ^(NSString *moeny) {
            self.headerView.content.text = [NSString stringWithFormat:@"%.2f个", [self.headerView.content.text stringByReplacingOccurrencesOfString:@"" withString:@"个"].floatValue + moeny.floatValue];
            if (self.getHappyMoney) {
                self.getHappyMoney(self.headerView.content.text);
            }
        };
        [self.viewControl.navigationController pushViewController:topup animated:YES];
    }
}

- (NSArray<NSString *> *)cellModelArr {
    if (!_cellModelArr) {
        _cellModelArr = @[@"充值"];
    }
    return _cellModelArr;
}
@end
