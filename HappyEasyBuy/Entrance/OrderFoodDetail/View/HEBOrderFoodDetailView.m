//
//  HEBOrderFoodDetailView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/20.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBOrderFoodDetailView.h"
#import "HEBOrderFoodDetailShopINFOView.h"
#import "HEBMapViewController.h"

@interface HEBOrderFoodDetailView ()<QMUITableViewDelegate, QMUITableViewDataSource>

@end

@implementation HEBOrderFoodDetailView

- (void)loadView {
    HEBOrderFoodDetailHeaderView *headerView = [[HEBOrderFoodDetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80)];
    selfClass(headerView);
    self.tableHeaderView = headerView;
    self.dataSource = self;
    self.delegate = self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.orderModel.group?4:3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.orderModel.group) {
        return section==0||section==1?1:section==2?self.orderModel.group.count+1:6;
    }
    return section==0||section==1?1:5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section==1?65:44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section==0?10:44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section != 0) {
        NSArray *arr;
        if (self.orderModel.group) {
            arr = @[@"商家信息", @"套餐", @"订单信息"];
        }else {
            arr = @[@"商家信息", @"订单信息"];
        }
        UIView *header = [[UIView alloc] init];
        header.bottomLine = YES;
        header.backgroundColor = UIColorWhite;
        QMUILabel *title = [[QMUILabel alloc] init];
        title.font = UIFontMake(16);
        title.text = arr[section-1];
        [header addSubview:title];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(header.mas_left).offset(20);
            make.centerY.equalTo(header.mas_centerY);
        }];
        return header;
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    QMUITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[QMUITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }else {
        while (cell.contentView.subviews.lastObject) {
            [cell.contentView.subviews.lastObject removeFromSuperview];
        }
    }
    cell.userInteractionEnabled = NO;
    cell.textLabel.text = nil;
    cell.detailTextLabel.text = nil;
    __weak __typeof(self)weakSelf = self;
    if (indexPath.section == 0) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@ %@",(self.orderModel.mname?@"取票码:":@"核销码:"), self.orderModel.order_code];
        cell.detailTextLabel.text = self.orderModel.order_statusStr;
        cell.detailTextLabel.textColor = BASECOLOR;
    }else if (indexPath.section == 1) {
        cell.userInteractionEnabled = YES;
        HEBOrderFoodDetailShopINFOView *shopINFO = [[HEBOrderFoodDetailShopINFOView alloc] init];
        shopINFO.shopName.text = self.orderModel.name;
        shopINFO.address.text = self.orderModel.address;
        [shopINFO.map addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            HEBMapViewController *map = [[HEBMapViewController alloc] init];
            map.shopName = weakSelf.orderModel.name;
            map.address = weakSelf.orderModel.address;
            map.lat = weakSelf.orderModel.lat.doubleValue;
            map.lon = weakSelf.orderModel.lng.doubleValue;
            [weakSelf.viewControl.navigationController pushViewController:map animated:YES];
        }];
        [shopINFO.callPhone addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            weakSelf.orderModel.phone.callPhone = YES;
        }];
        [cell.contentView addSubview:shopINFO];
        [shopINFO mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell.contentView);
        }];
    }else if (indexPath.section == 2 && self.orderModel.group) {
        if (indexPath.row == 0) {
            QMUILabel *all = [[QMUILabel alloc] init];
            all.text = @"全部";
            all.font = UIFontMake(16);
            [cell.contentView addSubview:all];
            [all mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(cell.contentView);
            }];
        }else {
            cell.bottomLine = YES;
            @weakify(cell);
            HEBOrderFoodDetailPackModel *model = [HEBOrderFoodDetailPackModel yy_modelWithJSON:self.orderModel.group[indexPath.row-1]];
            NSArray <NSString *> *packArr = @[model.t_name, [NSString stringWithFormat:@"%@份", model.t_num], [NSString stringWithFormat:@"¥ %@", model.t_price]];
            [packArr enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                QMUILabel *pack = [[QMUILabel alloc] init];
                pack.textAlignment = NSTextAlignmentCenter;
                pack.textColor = BASEBLACK;
                pack.font = UIFontMake(16);
                pack.text = obj;
                [weak_cell.contentView addSubview:pack];
                [pack mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.bottom.equalTo(weak_cell.contentView);
                    make.width.mas_offset(SCREEN_WIDTH/packArr.count);
                    make.left.equalTo(weak_cell.contentView.mas_left).offset(idx*(SCREEN_WIDTH/packArr.count));
                }];
            }];
        }
    }else if (indexPath.section == (self.orderModel.group?3:2) && self.orderModel) {
        cell.bottomLine = YES;
        NSArray <NSDictionary *>*orderArr = @[@{@"title":@"订单号码", @"msg":self.orderModel.order_number},
                                              @{@"title":@"下单时间", @"msg":self.orderModel.order_time},
                                              @{@"title":@"购买手机号", @"msg":self.orderModel.order_tel},
                                              @{@"title":@"数量", @"msg":self.orderModel.order_num},
                                              @{@"title":@"总价", @"msg":[NSString stringWithFormat:@"¥ %@", self.orderModel.order_price]},
                                              @{@"title":@"实付", @"msg":[NSString stringWithFormat:@"¥ %@", self.orderModel.order_payprice]}];
        QMUILabel *title = [[QMUILabel alloc] init];
        title.text = orderArr[indexPath.row][@"title"];
        title.font = UIFontMake(16);
        title.textColor = UIColorGray;
        [cell.contentView addSubview:title];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(cell.contentView.mas_centerY);
            make.left.equalTo(cell.contentView.mas_left).offset(20);
            make.width.mas_offset(100);
        }];

        QMUILabel *msg = [[QMUILabel alloc] init];
        msg.text = orderArr[indexPath.row][@"msg"];
        msg.font = UIFontMake(16);
        msg.textColor = BASEBLACK;
        [cell.contentView addSubview:msg];
        [msg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(cell.contentView.mas_centerY);
            make.left.equalTo(title.mas_right);
        }];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView qmui_clearsSelection];
    
}

@end
