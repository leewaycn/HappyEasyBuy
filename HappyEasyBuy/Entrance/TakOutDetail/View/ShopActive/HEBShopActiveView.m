//
//  HEBShopActiveView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/14.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBShopActiveView.h"
#import "HEBTakOutShopActiveCell.h"
#import "HEBTakOutShopPicView.h"

@interface HEBShopActiveView ()<QMUITableViewDelegate, QMUITableViewDataSource>

@end

@implementation HEBShopActiveView

- (void)loadView {
    self.dataSource = self;
    self.delegate = self;
    HEBTakOutShopActiveHeaderView *headerView = [[HEBTakOutShopActiveHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 160)];
    selfClass(headerView);
    self.tableHeaderView = headerView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.shopINFOArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.shopINFOArr[section].count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    HEBTakOutShopActiveCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[HEBTakOutShopActiveCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }else {
        while (cell.contentView.subviews.lastObject) {
            [cell.contentView.subviews.lastObject removeFromSuperview];
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.dividingLine = YES;
    [cell setCellINFO];
    cell.icon.image = UIImageMake(self.shopINFOArr[indexPath.section][indexPath.row][@"img"]);
    cell.name.text = self.shopINFOArr[indexPath.section][indexPath.row][@"title"];
    cell.detailTextLabel.text = self.shopINFOArr[indexPath.section][indexPath.row][@"des"];
    if (indexPath.section == self.shopINFOArr.count-1) {
        if ([self.shopINFOArr[indexPath.section][indexPath.row][@"arr"] count]) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.selected = UITableViewCellSelectionStyleNone;
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView qmui_clearsSelection];
    if (indexPath.section == self.shopINFOArr.count-1) {
        if ([self.shopINFOArr[indexPath.section][indexPath.row][@"arr"] count]) {
            if (self.getCoupon) {
                self.getCoupon(YES);
            }
        }
    }
}

- (NSArray *)shopINFOArr {
    if (!_shopINFOArr) {
        _shopINFOArr = [NSArray array];
    }
    return _shopINFOArr;
}



@end
