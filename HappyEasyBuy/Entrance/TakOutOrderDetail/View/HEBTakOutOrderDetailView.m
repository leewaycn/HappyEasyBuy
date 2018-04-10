//
//  HEBTakOutOrderDetailView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/15.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBTakOutOrderDetailView.h"
#import "HEBTakOutOrderUSEINFOView.h"
#import "HEBTakOutSendTimeView.h"
#import "HEBTakOutOrderGoodsView.h"
#import "HEBChooseCouponsViewController.h"
#import "HEBFeedbackViewController.h"
#import "HEBLocationViewController.h"
#import "HEBLocationModel.h"

@interface HEBTakOutOrderDetailView ()<QMUITableViewDataSource, QMUITableViewDelegate>

@property(nonatomic, strong) HEBTakOutOrderUSEINFOView *useINFOView;

@end

@implementation HEBTakOutOrderDetailView

- (void)loadView {
    self.delegate = self;
    self.dataSource = self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section==0&&self.useINFOModel.mobile?2:section==0&&!self.useINFOModel.mobile?1:section==1&&self.foodlistArr.count?self.foodlistArr.count+1:section==2?2:section==2?self.couponsArr.count:section==3?2:0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section==0&&indexPath.row==0&&self.useINFOModel.mobile?60:indexPath.section==1&&indexPath.row!=self.foodlistArr.count?60:44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section==1&&self.shopINFOModel?44:10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return section==0?10:CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1 && self.shopINFOModel) {
        UIView *header = [[UIView alloc] init];
        header.backgroundColor = UIColorWhite;
        UIImageView *icon = [[UIImageView alloc] init];
        [icon yy_setImageWithURL:[NSURL URLWithString:self.shopINFOModel.pic] options:YYWebImageOptionProgressive];
        [header addSubview:icon];
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(header.mas_centerY);
            make.left.equalTo(header.mas_left).offset(15);
            make.width.height.equalTo(header.mas_height).offset(-15);
        }];
        icon.layer.cornerRadius = (44-15)/2;
        icon.layer.masksToBounds = YES;
        
        QMUILabel *deliveryType = [[QMUILabel alloc] init];
        deliveryType.text = self.shopINFOModel.send_status;
        deliveryType.textAlignment = NSTextAlignmentCenter;
        deliveryType.font = UIFontMake(14);
        deliveryType.textColor = BASEBLACK;
        CGSize textSize = [self.shopINFOModel.send_status sizeWithAttributes:@{NSFontAttributeName:deliveryType.font}];
        [header addSubview:deliveryType];
        [deliveryType mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(header.mas_centerY);
            make.right.equalTo(header.mas_right).offset(-15);
            make.width.mas_offset(textSize.width+10);
        }];
        
        QMUILabel *name = [[QMUILabel alloc] init];
        name.text = self.shopINFOModel.name;
        name.font = UIFontMake(14);
        name.textColor = BASEBLACK;
        [header addSubview:name];
        [name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(header.mas_centerY);
            make.left.equalTo(icon.mas_right).offset(15);
            make.right.equalTo(deliveryType.mas_left).offset(-15);
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
    cell.dividingLine = YES;
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.detailTextLabel.text = nil;
    cell.textLabel.text = nil;
    cell.textLabel.textColor = BASEBLACK;
    cell.detailTextLabel.textColor = BASEBLACK;
    cell.userInteractionEnabled = NO;
    switch (indexPath.section) {
        case 0:{
            if (self.useINFOModel.mobile) {
                if (indexPath.row == 0) {
                    cell.userInteractionEnabled = YES;
                    cell.accessoryType = QMUIStaticTableViewCellAccessoryTypeDisclosureIndicator;
                        HEBTakOutOrderUSEINFOView *useINFOView = [[HEBTakOutOrderUSEINFOView alloc] init];
                    selfClass(useINFOView);
                        useINFOView.address.text = [NSString stringWithFormat:@"地址: %@", self.useINFOModel.address];
                        useINFOView.userName.text = [NSString stringWithFormat:@"姓名: %@", self.useINFOModel.name];
                        useINFOView.mobNumber.text = [NSString stringWithFormat:@"电话: %@", self.useINFOModel.mobile];
                        [cell.contentView addSubview:useINFOView];
                        [useINFOView mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.edges.equalTo(cell.contentView);
                        }];
                }else {
                    NSString *sendTime = [NSString stringWithFormat:@"立即送出 (大约%@送达)", self.useINFOModel.serve];
                    HEBTakOutSendTimeView *sendTimeView = [[HEBTakOutSendTimeView alloc] init];
                    sendTimeView.sendTime.attributedText = [Tools toolsEditColorString:sendTime searchString:[NSString stringWithFormat:@"(大约%@送达)", self.useINFOModel.serve] firstColor:BASEBLACK secondColor:BASECOLOR];
                    [cell.contentView addSubview:sendTimeView];
                    [sendTimeView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.edges.equalTo(cell.contentView);
                    }];
                }
            }else {
                cell.userInteractionEnabled = YES;
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.textLabel.text = @"请选择收货地址";
                cell.textLabel.textColor = BASECOLOR;
            }
        }
            break;
        case 1:{
            if (indexPath.row != self.foodlistArr.count) {
                HEBTakOutBuyCarModel *model = self.foodlistArr[indexPath.row];
                HEBTakOutOrderGoodsView *goodsView = [[HEBTakOutOrderGoodsView alloc] init];
                [goodsView.icon yy_setImageWithURL:[NSURL URLWithString:model.pic] options:YYWebImageOptionProgressive];
                goodsView.name.text = model.name;
                goodsView.money.text = [NSString stringWithFormat:@"¥ %@", model.price];
                goodsView.count.text = [NSString stringWithFormat:@"x %d", model.quantity];
                [cell.contentView addSubview:goodsView];
                [goodsView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.edges.equalTo(cell.contentView);
                }];
            }else {
                cell.textLabel.text = @"配送费";
                cell.detailTextLabel.text = [NSString stringWithFormat:@"¥ %@", self.shopINFOModel.delivery];
            }
        }break;
        case 2:{
            cell.textLabel.text = indexPath.row==0?@"商家优惠券":@"通用优惠券";
            cell.accessoryType = self.couponsArr[indexPath.row].count?UITableViewCellAccessoryDisclosureIndicator:UITableViewCellAccessoryNone;
            cell.userInteractionEnabled = self.couponsArr[indexPath.row].count;
            cell.detailTextLabel.text = !self.couponsArr[indexPath.row].count?@"暂无可用优惠券":[NSString stringWithFormat:@"当前有%ld张可用优惠券", self.couponsArr[indexPath.row].count];
        }break;
        case 3:{
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.userInteractionEnabled = YES;
            NSArray <NSDictionary *>*cellModel = @[@{@"name":@"支付方式", @"des":@"在线支付"},
                                                   @{@"name":@"备注", @"des":@"口味偏好的要求"}];
            cell.textLabel.text = cellModel[indexPath.row][@"name"];
            cell.detailTextLabel.text = cellModel[indexPath.row][@"des"];
        }
        default:
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView qmui_clearsSelection];
    __weak __typeof(self)weakSelf = self;
    if (indexPath.section == 0) {
        HEBLocationViewController *location = [[HEBLocationViewController alloc] init];
        location.getConsignee = YES;
        location.getConsigneeINFO = ^(HEBLocationModel *model) {
            weakSelf.useINFOView.address.text = [NSString stringWithFormat:@"地址: %@%@", model.location, model.address];
            weakSelf.useINFOView.mobNumber.text = [NSString stringWithFormat:@"电话: %@", model.mobile];
            weakSelf.useINFOView.userName.text = [NSString stringWithFormat:@"姓名: %@", model.name];
            if (weakSelf.getAddressid) {
                weakSelf.getAddressid(model.locationid);
            }
        };
        [self.viewControl.navigationController pushViewController:location animated:YES];
    }else if (indexPath.section == 2) {
        if (self.getReduceMoney) {
            self.getReduceMoney(0, nil, nil);
        }
        HEBChooseCouponsViewController *choose = [[HEBChooseCouponsViewController alloc] init];
        if (indexPath.row == 0) {
            choose.title = @"商家优惠券";
            choose.shopReduceArr = self.couponsArr[0];
        }else {
            choose.title = @"通用优惠券";
            choose.redArr = self.couponsArr[1];
        }
        choose.money = self.money.floatValue;
        choose.getMoney = ^(NSString *money, NSString *key, NSString *value) {
            if (weakSelf.getReduceMoney) {
                weakSelf.getReduceMoney(weakSelf.money.floatValue - money.removeSpace.removeMoneySymbol.floatValue, key, value);
            }
        };
        [self.viewController.navigationController pushViewController:choose animated:YES];
    }else if (indexPath.section == 3) {
        if (indexPath.row == 0) {
            QMUIAlertController *alert = [QMUIAlertController alertControllerWithTitle:@"支付方式" message:@"请选择支付方式" preferredStyle:QMUIAlertControllerStyleActionSheet];
            [alert addAction:[QMUIAlertAction actionWithTitle:@"在线支付" style:QMUIAlertActionStyleDefault handler:^(QMUIAlertAction *action) {
                [alert hideWithAnimated:YES];
            }]];
            [alert addAction:[QMUIAlertAction actionWithTitle:@"取消" style:QMUIAlertActionStyleCancel handler:^(QMUIAlertAction *action) {}]];
            [alert showWithAnimated:YES];
        }else {
            HEBFeedbackViewController *msg = [[HEBFeedbackViewController alloc] init];
            msg.title = @"订单详情";
            msg.getConnect = ^(NSString *msg) {
                if (weakSelf.getMsg) {
                    weakSelf.getMsg(msg);
                }
            };
            [self.viewController.navigationController pushViewController:msg animated:YES];
        }
    }
}

- (NSArray<HEBTakOutBuyCarModel *> *)foodlistArr {
    if (!_foodlistArr) {
        _foodlistArr = [NSArray array];
    }
    return _foodlistArr;
}

@end
