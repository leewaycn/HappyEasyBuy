//
//  HEBOrderTakOutDetailView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/22.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBOrderTakOutDetailView.h"
#import "HEBOrderTakOutDetailCell.h"

@interface HEBOrderTakOutDetailView ()<QMUITableViewDelegate, QMUITableViewDataSource>

@end

@implementation HEBOrderTakOutDetailView

- (void)loadView {
    HEBOrderHotelDetailHeaderView *headerView = [[HEBOrderHotelDetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
    selfClass(headerView);
    self.tableHeaderView = headerView;
    self.dataSource = self;
    self.delegate = self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.takeoutmodel?2:0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section==0?self.takeoutmodel.items.count+3:5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section==0&&indexPath.row<self.takeoutmodel.items.count?60:44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section==0?40:10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        UIView *header = [[UIView alloc] init];
        UIView *bg = [[UIView alloc] init];
        bg.backgroundColor = UIColorWhite;
        [header addSubview:bg];
        [bg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(header);
            make.top.equalTo(header.mas_top).offset(10);
        }];
        UIImageView *icon = [[UIImageView alloc] init];
        [icon yy_setImageWithURL:[NSURL URLWithString:self.takeoutmodel.pic] options:YYWebImageOptionProgressive];
        [bg addSubview:icon];
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(bg.mas_centerY);
            make.left.equalTo(bg.mas_left).offset(15);
            make.size.mas_offset(25);
        }];
        icon.layer.cornerRadius = 25/2;
        icon.layer.masksToBounds = YES;
        
        QMUILabel *name = [[QMUILabel alloc] init];
        name.text = self.takeoutmodel.name;
        name.font = UIFontMake(18);
        name.textColor = BASEBLACK;
        [bg addSubview:name];
        [name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(icon.mas_centerY);
            make.left.equalTo(icon.mas_right).offset(10);
        }];
        return header;
    }
    return nil;
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
    cell.bottomLine = YES;
    cell.userInteractionEnabled = NO;
    if (indexPath.section == 0) {
        if (indexPath.row < self.takeoutmodel.items.count) {
            HEBTakOutBuyCarModel *model = [HEBTakOutBuyCarModel yy_modelWithJSON:self.takeoutmodel.items[indexPath.row]];
            HEBOrderTakOutDetailCell *detail = [[HEBOrderTakOutDetailCell alloc] init];
            [detail.icon yy_setImageWithURL:[NSURL URLWithString:model.pic] options:YYWebImageOptionProgressive];
            [cell.contentView addSubview:detail];
            detail.count.text = [NSString stringWithFormat:@"x %d", model.quantity];
            detail.money.text = [NSString stringWithFormat:@"¥ %@", model.price];
            [detail mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(cell.contentView);
                make.left.equalTo(cell.contentView.mas_left).offset(15);
                make.right.equalTo(cell.contentView.mas_right).offset(-10);
            }];
        }else {
            if (indexPath.row != self.takeoutmodel.items.count+2 && self.takeoutmodel) {
                NSArray <NSDictionary *>*arr = @[@{@"title":@"配送费", @"msg":[NSString stringWithFormat:@"¥ %@", self.takeoutmodel.psprice]},
                                                 @{@"title":@"总价", @"msg":[NSString stringWithFormat:@"¥ %@", self.takeoutmodel.totalprice]}];
                QMUILabel *name = [[QMUILabel alloc] init];
                name.text = arr[indexPath.row-self.takeoutmodel.items.count][@"title"];
                name.font = UIFontMake(14);
                name.textColor = BASEBLACK;
                [cell.contentView addSubview:name];
                [name mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(cell.contentView.mas_centerY);
                    make.left.equalTo(cell.contentView.mas_left).offset(30);
                }];
                QMUILabel *msg = [[QMUILabel alloc] init];
                msg.textColor = (indexPath.row-self.takeoutmodel.items.count)==0?BASEBLACK:BASECOLOR;
                msg.font = UIFontMake(14);
                msg.text = arr[indexPath.row-self.takeoutmodel.items.count][@"msg"];
                [cell.contentView addSubview:msg];
                [msg mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(name.mas_centerY);
                    make.right.equalTo(cell.contentView.mas_right).offset(-20);
                }];
            }else if (self.takeoutmodel) {
                __weak __typeof(self)weakSelf = self;
                cell.userInteractionEnabled = YES;
                QMUIButton *callPhone = [[QMUIButton alloc] init];
                [callPhone setTitle:@"  联系商家" forState:UIControlStateNormal];
                [callPhone setTitleColor:BASEBLACK forState:UIControlStateNormal];
                callPhone.titleLabel.font = UIFontMake(16);
                [callPhone setImage:UIImageMake(@"订单_联系店铺") forState:UIControlStateNormal];
                [cell.contentView addSubview:callPhone];
                [callPhone mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.edges.equalTo(cell.contentView);
                }];
                [callPhone addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
                    weakSelf.takeoutmodel.sphone.callPhone = YES;
                }];
            }
        }
    }else if (indexPath.section == 1 && self.takeoutmodel){
        NSArray <NSDictionary *>*arr = @[
  @{@"title":@"配送地址:", @"msg":self.takeoutmodel.vipaddress},
  @{@"title":@"配送服务:", @"msg":self.takeoutmodel.psway},
  @{@"title":@"订单号码:", @"msg":self.takeoutmodel.oid},
  @{@"title":@"订单时间:", @"msg":self.takeoutmodel.ctime},
  @{@"title":@"订单备注:", @"msg":self.takeoutmodel.msg?self.takeoutmodel.msg:@""}];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView qmui_clearsSelection];
    
}

@end
