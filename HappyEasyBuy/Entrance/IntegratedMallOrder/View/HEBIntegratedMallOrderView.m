//
//  HEBIntegratedMallOrderView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/18.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBIntegratedMallOrderView.h"
#import "HEBIntegratedMallOrderCell.h"
#import "HEBLocationViewController.h"
#import "HEBLocationModel.h"

@interface HEBIntegratedMallOrderView ()<QMUITableViewDelegate, QMUITableViewDataSource>

@end

@implementation HEBIntegratedMallOrderView

- (void)loadView {
    self.dataSource = self;
    self.delegate = self;
    HEBIntegratedMallOrderHeaderView *headerView = [[HEBIntegratedMallOrderHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    selfClass(headerView);
    self.tableHeaderView = headerView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.isReal+1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section==0?1:3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSArray <NSString *>*arr = @[@"积分兑换", @"地址"];
    UIView *header = [[UIView alloc] init];
    QMUILabel *title = [[QMUILabel alloc] init];
    title.text = arr[section];
    title.font = UIFontMake(16);
    [header addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(header.mas_bottom);
        make.left.equalTo(header.mas_left).offset(15);
    }];
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    HEBIntegratedMallOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[HEBIntegratedMallOrderCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }else {
        while (cell.contentView.subviews.lastObject) {
            [cell.contentView.subviews.lastObject removeFromSuperview];
        }
    }
    cell.detailTextLabel.text = nil;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setCellINFO];
    if (indexPath.section) {
        cell.dividingLine = YES;
        NSArray <NSString *>*arr = @[@"收货人:", @"电话:", @"收货地址:"];
        NSArray <NSString *>*desArr = @[@"请输入姓名", @"请输入手机号", @"请输入地址"];
        cell.title.text = arr[indexPath.row];
        cell.selectINFO.hidden = !(indexPath.row==0);
        cell.infoField.placeholder = desArr[indexPath.row];
        if (indexPath.row == 0) {
            [cell.infoField mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(cell.contentView);
                make.left.equalTo(cell.title.mas_right).offset(5);
                make.right.equalTo(cell.selectINFO.mas_left).offset(-5);
            }];
        }
        if (indexPath.row == 1) {
            cell.infoField.maximumTextLength = 11;
            cell.infoField.keyboardType = UIKeyboardTypeNumberPad;
        }
        [cell.selectINFO addTarget:self action:@selector(selectINFODidClick) forControlEvents:UIControlEventTouchUpInside];
    }else {
        cell.detailTextLabel.text = self.integral;
        cell.title.text = @"积分数量:";
        cell.selectINFO.hidden = YES;
        cell.infoField.hidden = YES;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView qmui_clearsSelection];
    
}

- (void)selectINFODidClick {
    __weak __typeof(self)weakSelf = self;
    HEBLocationViewController *location = [[HEBLocationViewController alloc] init];
    location.getConsignee = YES;
    location.getConsigneeINFO = ^(HEBLocationModel *model) {
        HEBIntegratedMallOrderCell *user = (id)[weakSelf cellForRow:0 inSection:1];
        user.infoField.text = [NSString stringWithFormat:@"%@(%@)", model.name, model.call?@"女士":@"先生"];
        HEBIntegratedMallOrderCell *mobNumber = (id)[weakSelf cellForRow:1 inSection:1];
        mobNumber.infoField.text = model.mobile;
        HEBIntegratedMallOrderCell *address = (id)[weakSelf cellForRow:2 inSection:1];
        address.infoField.text = [NSString stringWithFormat:@"%@%@", model.location, model.address];
    };
    [self.viewControl.navigationController pushViewController:location animated:YES];
}

@end
