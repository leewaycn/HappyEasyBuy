//
//  HEBLocationView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/26.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBLocationView.h"
#import "HEBLocationCell.h"
#import "HEBShippingAddressViewController.h"

@interface HEBLocationView ()<QMUITableViewDataSource, QMUITableViewDelegate>

@end

@implementation HEBLocationView

- (void)loadView {
    self.dividingLine = YES;
    self.dataSource = self;
    self.delegate = self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.locationModelArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    HEBLocationCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[HEBLocationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }else {
        while (cell.contentView.subviews.lastObject) {
            [cell.contentView.subviews.lastObject removeFromSuperview];
        }
    }
    [cell setCellINFO];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    HEBLocationModel *model = self.locationModelArr[indexPath.section];
    cell.address.text = [NSString stringWithFormat:@"%@%@", model.location, model.address];
    cell.userINFO.text = [NSString stringWithFormat:@"%@ %@ %@", model.name, model.call?@"女士":@"先生", model.mobile];
    return cell;
}

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    __weak __typeof(self)weakSelf = self;
    UITableViewRowAction *editor = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"编辑" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        if (weakSelf.cellStyleChange) {
            weakSelf.cellStyleChange();
        }
        HEBShippingAddressViewController *ship = [[HEBShippingAddressViewController alloc] init];
        ship.title = @"编辑收货地址";
        ship.locationModel = weakSelf.locationModelArr[indexPath.section];
        ship.locationChange = ^(HEBLocationModel *model) {
            [weakSelf.locationModelArr replaceObjectAtIndex:indexPath.section withObject:model];
            [weakSelf reloadSection:indexPath.section withRowAnimation:UITableViewRowAnimationNone];
        };
        [self.viewControl.navigationController pushViewController:ship animated:YES];
    }];
    
    UITableViewRowAction *remove = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        if (weakSelf.cellStyleChange) {
            weakSelf.cellStyleChange();
        }
        [weakSelf.viewControl.progressHUD showAnimated:YES];
        [Networking postUrl:DelUserAddressList params:@{@"id":weakSelf.locationModelArr[indexPath.section].locationid, @"user_id":getUser_id} callBack:^(id response, MainModel *mainModel, NSError *errorData) {
            weakSelf.viewControl.progressHUD.label.text = mainModel.msg;
            [weakSelf.viewControl.progressHUD hideAnimated:YES afterDelay:1.25];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf.viewControl dismissProgressHUD];
            });
            if (mainModel.status) {
                [weakSelf.locationModelArr removeObjectAtIndex:indexPath.section];
                if (weakSelf.locationModelArr.count) {
                    [weakSelf deleteSection:indexPath.section withRowAnimation:UITableViewRowAnimationNone];
                }else {
                    [weakSelf reloadData];
                }
            }
        }];
    }];
    return @[remove, editor];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView qmui_clearsSelection];
    HEBLocationModel *model = self.locationModelArr[indexPath.section];
    __weak __typeof(self)weakSelf = self;
    if (!self.getConsignee) {
        HEBShippingAddressViewController *ship = [[HEBShippingAddressViewController alloc] init];
        ship.title = @"编辑收货地址";
        ship.locationModel = model;
        ship.locationChange = ^(HEBLocationModel *model) {
            [weakSelf.locationModelArr replaceObjectAtIndex:indexPath.section withObject:model];
            [weakSelf reloadSection:indexPath.section withRowAnimation:UITableViewRowAnimationNone];
        };
        [self.viewControl.navigationController pushViewController:ship animated:YES];
    }else {
        NSLog(@"返回打印信息");
        if (self.consigneeINFO) {
            self.consigneeINFO(model);
        }
    }
}


- (NSMutableArray *)locationModelArr {
    if (!_locationModelArr) {
        _locationModelArr = [NSMutableArray array];
    }
    return _locationModelArr;
}

@end
