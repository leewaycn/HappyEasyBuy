//
//  HEBOrderHotelDetailView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/21.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBOrderHotelDetailView.h"
#import "HEBMapViewController.h"
#import "HEBHotelDetailViewController.h"

@interface HEBOrderHotelDetailView ()<QMUITableViewDataSource, QMUITableViewDelegate>

@end

@implementation HEBOrderHotelDetailView

- (void)loadView {
    self.delegate = self;
    self.dataSource = self;
    HEBOrderHotelDetailHeaderView *headerView = [[HEBOrderHotelDetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    selfClass(headerView);
    self.tableHeaderView = headerView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.hotelModel?4:0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section==0?1:section==1?3:section==2?3:2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section==1&&indexPath.row==0?50:indexPath.section==1&&indexPath.row==1?70:44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section==0||section==1?CGFLOAT_MIN:30;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section != 0 && section != 1) {
        NSArray <NSString *>* arr = @[@"预定信息", @"订单信息"];
        UIView *header = [[UIView alloc] init];
        header.backgroundColor = UIColorWhite;
        QMUILabel *msg = [[QMUILabel alloc] init];
        msg.text = arr[section-2];
        msg.font = UIFontMake(16);
        [header addSubview:msg];
        [msg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(header.mas_centerY);
            make.left.equalTo(header.mas_left).offset(15);
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
    @weakify(cell);
    cell.textLabel.text = nil;
    cell.detailTextLabel.text = nil;
    cell.detailTextLabel.textColor = BASECOLOR;
    cell.userInteractionEnabled = NO;
    if (indexPath.section == 0) {
        cell.textLabel.text = self.hotelModel.order_statusStr;
        cell.detailTextLabel.text = self.hotelModel.order_price;
    }else if (indexPath.section == 1 && indexPath.row == 0) {
        cell.bottomLine = YES;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.userInteractionEnabled = YES;
        cell.detailTextLabel.text = @"查看商家";
        QMUILabel *title = [[QMUILabel alloc] init];
        title.text = self.hotelModel.h_name;
        title.font = UIFontMake(16);
        [cell.contentView addSubview:title];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cell.contentView.mas_left).offset(15);
            make.top.equalTo(cell.contentView.mas_top).offset(5);
        }];
        QMUILabel *address = [[QMUILabel alloc] init];
        address.textColor = UIColorGray;
        address.font = UIFontMake(14);
        address.text = self.hotelModel.h_address;
        [cell.contentView addSubview:address];
        [address mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(title.mas_left);
            make.bottom.equalTo(cell.contentView.mas_bottom).offset(-3);
        }];
    }else if (indexPath.section == 1 && indexPath.row == 1) {
        cell.bottomLine = YES;
        QMUILabel *title = [[QMUILabel alloc] init];
        title.text = self.hotelModel.r_name;
        title.font = UIFontMake(16);
        [cell.contentView addSubview:title];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cell.contentView.mas_left).offset(15);
            make.top.equalTo(cell.contentView.mas_top).offset(5);
        }];
        NSArray <NSString *>*arr = @[[NSString stringWithFormat:@"入住 %@", self.hotelModel.order_cometime],
                                     [NSString stringWithFormat:@"离店 %@", self.hotelModel.order_leavetime],
                                     [NSString stringWithFormat:@"共 %@ 晚", self.hotelModel.order_num]];
        [arr enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            QMUILabel *msg = [[QMUILabel alloc] init];
            msg.text = obj;
            msg.textAlignment = NSTextAlignmentCenter;
            msg.font = UIFontMake(14);
            msg.textColor = UIColorGray;
            [weak_cell.contentView addSubview:msg];
            [msg mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(weak_cell.contentView.mas_centerY);
                make.width.mas_offset(SCREEN_WIDTH/arr.count);
                make.left.equalTo(weak_cell.contentView.mas_left).offset(idx*(SCREEN_WIDTH/arr.count));
            }];
        }];
        QMUILabel *infoMsg = [[QMUILabel alloc] init];
        infoMsg.text = self.hotelModel.info;
        infoMsg.textColor = UIColorGray;
        infoMsg.font = UIFontMake(14);
        [cell.contentView addSubview:infoMsg];
        [infoMsg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(cell.contentView.mas_bottom).offset(-5);
            make.left.equalTo(title.mas_left);
        }];
    }else if (indexPath.section == 1 && indexPath.row == 2) {
        cell.userInteractionEnabled = YES;
        NSArray <NSDictionary *>*arr = @[@{@"title":@"  查看路线", @"img":@"订单_地址"},
                                         @{@"title":@"  联系商家", @"img":@"订单_联系"}];
        __weak __typeof(self)weakSelf = self;
        [arr enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            QMUIButton *sender = [[QMUIButton alloc] init];
            sender.tag = idx+100;
            [sender addTarget:weakSelf action:@selector(senderDidClick:) forControlEvents:UIControlEventTouchUpInside];
            [sender setImage:UIImageMake(obj[@"img"]) forState:UIControlStateNormal];
            [sender setTitle:obj[@"title"] forState:UIControlStateNormal];
            [sender setTitleColor:BASECOLOR forState:UIControlStateNormal];
            sender.titleLabel.font = UIFontMake(16);
            [weak_cell.contentView addSubview:sender];
            [sender mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(weak_cell.contentView);
                make.width.mas_offset(SCREEN_WIDTH/arr.count);
                make.left.equalTo(weak_cell.contentView.mas_left).offset(idx*(SCREEN_WIDTH/arr.count));
            }];
        }];
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = UIColorHex(#e7e7e7);
        [cell.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(cell.contentView);
            make.width.mas_offset(1);
            make.height.equalTo(cell.contentView.mas_height).offset(-15);
        }];
    }else {
        NSArray <NSDictionary *>*arr;
        if (indexPath.section == 2) {
            arr = @[@{@"title":@"入住人", @"msg":self.hotelModel.order_name},
                    @{@"title":@"联系电话", @"msg":self.hotelModel.order_tel},
                    @{@"title":@"预计到店", @"msg":self.hotelModel.order_arrtime}
                    ];
        }else {
            arr = @[@{@"title":@"订单号码", @"msg":self.hotelModel.order_number},
                    @{@"title":@"下单时间", @"msg":self.hotelModel.order_time}
                    ];
        }
        QMUILabel *title = [[QMUILabel alloc] init];
        title.font = UIFontMake(14);
        title.text = arr[indexPath.row][@"title"];
        title.textColor = UIColorGray;
        [cell.contentView addSubview:title];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(cell.contentView.mas_centerY);
            make.left.equalTo(cell.contentView.mas_left).offset(15);
            make.width.mas_offset(80);
        }];
        
        QMUILabel *msg = [[QMUILabel alloc] init];
        msg.textColor = BASEBLACK;
        msg.font = UIFontMake(14);
        msg.text = arr[indexPath.row][@"msg"];
        [cell.contentView addSubview:msg];
        [msg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(title.mas_centerY);
            make.left.equalTo(title.mas_right);
        }];
    }
    return cell;
}

- (void)senderDidClick:(QMUIButton *)sender {
    if (sender.tag == 100) {
        HEBMapViewController *map = [[HEBMapViewController alloc] init];
        map.shopName = self.hotelModel.h_name;
        map.lat = self.hotelModel.lat.doubleValue;
        map.lon = self.hotelModel.lng.doubleValue;
        map.address = self.hotelModel.h_address;
        [self.viewControl.navigationController pushViewController:map animated:YES];
    }else {
        self.hotelModel.h_tel.callPhone = YES;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView qmui_clearsSelection];
    HEBHotelDetailViewController *detail = [[HEBHotelDetailViewController alloc] init];
    detail.hotelid = self.hotelModel.h_id;
    [self.viewControl.navigationController pushViewController:detail animated:YES];
}

@end
