//
//  HEBBuyOrderView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/5.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBBuyOrderView.h"
#import "HEBBuyOrderHeaderView.h"
#import "HEBChooseCouponsViewController.h"
#import "HEBOrderPayViewController.h"

@interface HEBBuyOrderView ()<QMUITableViewDelegate, QMUITableViewDataSource>

@property(nonatomic, strong) NSArray<NSDictionary *> *cellModelArr;

@property(nonatomic, strong) QMUIButton *buyOrder;

@property(nonatomic, strong) HEBBuyOrderHeaderView *headerView;

@property(nonatomic, assign) int count;

@property(nonatomic, copy) NSString *key;

@property(nonatomic, copy) NSString *value;

@end

@implementation HEBBuyOrderView

- (void)loadView {
    HEBBuyOrderHeaderView *headerView = [[HEBBuyOrderHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    selfClass(headerView);
    [headerView.moneyField addTarget:self action:@selector(moneyFieldChange:) forControlEvents:UIControlEventEditingChanged];
    self.tableHeaderView = headerView;
    self.dataSource = self;
    self.delegate = self;
    UIView *foot = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    self.tableFooterView = foot;
    QMUIButton *buyOrder = [[QMUIButton alloc] init];
    selfClass(buyOrder);
    buyOrder.enabled = NO;
    buyOrder.backgroundColor = BASECOLOR;
    [self.buyOrder setTitle:@"0元 确认买单" forState:UIControlStateNormal];
    [self.buyOrder addTarget:self action:@selector(buyOrderDidClick) forControlEvents:UIControlEventTouchUpInside];
    [buyOrder setTitleColor:UIColorWhite forState:UIControlStateNormal];
    [foot addSubview:buyOrder];
    [buyOrder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(foot.mas_top).offset(15);
        make.left.equalTo(foot.mas_left).offset(25);
        make.right.equalTo(foot.mas_right).offset(-25);
        make.height.mas_offset(45);
    }];
    buyOrder.layer.cornerRadius = 5;
    buyOrder.layer.masksToBounds = YES;
    QMUILabel *msg = [[QMUILabel alloc] init];
    msg.text = @"买单仅限于到店支付，请确认金额后提交";
    msg.textColor = UIColorGray;
    msg.font = UIFontMake(16);
    [foot addSubview:msg];
    [msg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(foot);
        make.top.equalTo(buyOrder.mas_bottom).offset(5);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return [self.cellModelArr[1][@"select"] length]?3:1;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
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
    cell.detailTextLabel.text = nil;
    if (indexPath.section == 0 || (indexPath.section == 1 && indexPath.row == 0)) {
        NSString *imgName = [self.cellModelArr[indexPath.section][@"select"] length]?@"支付方式选中":@"支付方式未选中";
        UIImageView *img = [[UIImageView alloc] initWithImage:UIImageMake(imgName)];
        [cell.contentView addSubview:img];
        [img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(cell.contentView.mas_centerY);
            make.left.equalTo(cell.contentView.mas_left).offset(15);
            make.size.mas_offset(img.image.size);
        }];
        if (indexPath.section == 0) {
            QMUILabel *fullReduction = [[QMUILabel alloc] init];
            selfClass(fullReduction);
            fullReduction.text = [NSString stringWithFormat:@"满%.2f减%.2f", self.full, self.reduction];
            fullReduction.font = UIFontMake(16);
            fullReduction.textColor = BASEBLACK;
            [cell.contentView addSubview:fullReduction];
            [fullReduction mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(cell.contentView.mas_centerY);
                make.left.equalTo(img.mas_right).offset(5);
            }];
        }else {
            QMUILabel *title = [[QMUILabel alloc] init];
            title.text = @"选择优惠券";
            title.font = UIFontMake(16);
            title.textColor = BASEBLACK;
            [cell.contentView addSubview:title];
            [title mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(cell.contentView.mas_centerY);
                make.left.equalTo(img.mas_right).offset(5);
            }];
        }
    }else if (indexPath.section == 1 && indexPath.row != 0) {
        NSArray *arr = @[@"商家优惠券", @"通用优惠券"];
        cell.dividingLine = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        QMUILabel *title = [[QMUILabel alloc] init];
        title.text = arr[indexPath.row-1];
        title.font = UIFontMake(16);
        title.textColor = BASEBLACK;
        [cell.contentView addSubview:title];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(cell.contentView.mas_centerY);
            make.left.equalTo(cell.contentView.mas_left).offset(15);
        }];
        __weak __typeof(self)weakSelf = self;
        if (indexPath.row == 1) {
            self.count = 0;
            [self.shopCoupon enumerateObjectsUsingBlock:^(HEBFoodSnatchOrderPaymentCouponDetailModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (weakSelf.headerView.moneyField.text.floatValue >= obj.usemoney.floatValue) {
                   weakSelf.count = weakSelf.count+1;
                }
                if (weakSelf.count) {
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d张可用优惠券", weakSelf.count];
                    cell.userInteractionEnabled = YES;
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    cell.detailTextLabel.textColor = BASECOLOR;
                }else {
                    cell.userInteractionEnabled = NO;
                    cell.detailTextLabel.text = @"暂无可用优惠券";
                    cell.detailTextLabel.textColor = UIColorGray;
                    cell.accessoryType = UITableViewCellAccessoryNone;
                }
            }];
        }else {
            self.count = 0;
            [self.Coupon enumerateObjectsUsingBlock:^(HEBFoodSnatchOrderPaymentRedDetailModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (weakSelf.headerView.moneyField.text.floatValue >= obj.reducemoney.floatValue) {
                    weakSelf.count = weakSelf.count+1;
                }
                if (weakSelf.count) {
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d张可用优惠券", weakSelf.count];
                    cell.userInteractionEnabled = YES;
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    cell.detailTextLabel.textColor = BASECOLOR;
                }else {
                    cell.userInteractionEnabled = NO;
                    cell.detailTextLabel.text = @"暂无可用优惠券";
                    cell.detailTextLabel.textColor = UIColorGray;
                    cell.accessoryType = UITableViewCellAccessoryNone;
                }
            }];
        }
    }else {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryNone;
        QMUILabel *title = [[QMUILabel alloc] init];
        title.text = @"实付金额";
        title.font = UIFontMake(16);
        title.textColor = BASEBLACK;
        [cell.contentView addSubview:title];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(cell.contentView.mas_centerY);
            make.left.equalTo(cell.contentView.mas_left).offset(15);
        }];
        cell.detailTextLabel.textColor = BASECOLOR;
        if ([self.cellModelArr[0][@"select"] length]) {
            if (self.headerView.moneyField.hasText) {
                self.buyOrder.enabled = YES;
                if (self.headerView.moneyField.text.floatValue >= self.full) {
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"¥ %.2f", self.headerView.moneyField.text.floatValue-self.reduction];
                }else {
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"¥ %@", self.headerView.moneyField.text];
                }
            }else {
                cell.detailTextLabel.text = @"¥ 0.00";
                self.buyOrder.enabled = NO;
            }
        }else if ([self.cellModelArr[1][@"select"] length]) {
            if (self.headerView.moneyField.hasText) {
                cell.detailTextLabel.text = [NSString stringWithFormat:@"¥ %@", self.headerView.moneyField.text];
                self.buyOrder.enabled = YES;
            }else {
                cell.detailTextLabel.text = @"¥ 0.00";
                self.buyOrder.enabled = NO;
            }
        }
    }
    return cell;
}

- (void)tableView:(QMUITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView qmui_clearsSelection];
    if (indexPath.section == 0 || (indexPath.section == 1 && indexPath.row == 0)) {
        NSMutableArray *arr = [NSMutableArray array];
        [self.cellModelArr enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            if (idx == indexPath.section) {
                [dict setObject:@"Y" forKey:@"select"];
            }else {
                [dict setObject:@"" forKey:@"select"];
            }
            [arr addObject:dict];
        }];
        self.cellModelArr = arr;
        [tableView reloadData];
    }else if (indexPath.section == 1 && indexPath.row != 0) {
        __weak __typeof(self)weakSelf = self;
        QMUITableViewCell *cell = [tableView cellForRow:0 inSection:2];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"¥ %.2f", self.headerView.moneyField.text.floatValue];
        [weakSelf.buyOrder setTitle:[NSString stringWithFormat:@"%@元 确认买单", cell.detailTextLabel.text] forState:UIControlStateNormal];
        self.value = @"";
        self.key = @"";
        HEBChooseCouponsViewController *choose = [[HEBChooseCouponsViewController alloc] init];
        choose.money = cell.detailTextLabel.text.removeSpace.removeMoneySymbol.floatValue;
        
        if (indexPath.row == 1) {
            choose.shopReduceArr = self.shopCoupon;
            choose.title = @"商家优惠券";
            choose.getMoney = ^(NSString *money, NSString *key, NSString *value) {
                cell.detailTextLabel.text = money;
                weakSelf.key = key;
                weakSelf.value = value;
                [weakSelf.buyOrder setTitle:[NSString stringWithFormat:@"%@元 确认买单", cell.detailTextLabel.text] forState:UIControlStateNormal];
            };
        }else if (indexPath.row == 2) {
            choose.redArr = self.Coupon;
            choose.title = @"通用优惠券";
            choose.getMoney = ^(NSString *money, NSString *key, NSString *value) {
                cell.detailTextLabel.text = money;
                weakSelf.key = key;
                weakSelf.value = value;
                [weakSelf.buyOrder setTitle:[NSString stringWithFormat:@"%@元 确认买单", cell.detailTextLabel.text] forState:UIControlStateNormal];
            };
        }
        [self.viewController.navigationController pushViewController:choose animated:YES];
    }
}

- (void)moneyFieldChange:(QMUITextField *)sender {
    QMUITableViewCell *cell = [self cellForRow:0 inSection:2];
    if ([self.cellModelArr[0][@"select"] length]) {
        if (sender.hasText) {
            self.buyOrder.enabled = YES;
            if (sender.text.floatValue >= self.full) {
                cell.detailTextLabel.text = [NSString stringWithFormat:@"¥ %.2f", sender.text.floatValue-self.reduction];
            }else {
                cell.detailTextLabel.text = [NSString stringWithFormat:@"¥ %@", sender.text];
            }
        }else {
            cell.detailTextLabel.text = @"¥ 0";
            self.buyOrder.enabled = NO;
        }
    }else if ([self.cellModelArr[1][@"select"] length]) {
        QMUITableViewCell *shopCell = [self cellForRow:1 inSection:1];
        QMUITableViewCell *redCell = [self cellForRow:2 inSection:1];
        __weak __typeof(self)weakSelf = self;
        self.count = 0;
        [self.shopCoupon enumerateObjectsUsingBlock:^(HEBFoodSnatchOrderPaymentCouponDetailModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (weakSelf.headerView.moneyField.text.floatValue >= obj.usemoney.floatValue) {
                weakSelf.count = weakSelf.count+1;
            }
            if (self.count) {
                shopCell.detailTextLabel.text = [NSString stringWithFormat:@"%d张可用优惠券", self.count];
                shopCell.userInteractionEnabled = YES;
                shopCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                shopCell.detailTextLabel.textColor = BASECOLOR;
            }else {
                shopCell.userInteractionEnabled = NO;
                shopCell.detailTextLabel.text = @"暂无可用优惠券";
                shopCell.detailTextLabel.textColor = UIColorGray;
                shopCell.accessoryType = UITableViewCellAccessoryNone;
            }
        }];
        self.count = 0;
        [self.Coupon enumerateObjectsUsingBlock:^(HEBFoodSnatchOrderPaymentRedDetailModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (weakSelf.headerView.moneyField.text.floatValue >= obj.reducemoney.floatValue) {
                weakSelf.count = weakSelf.count+1;
            }
            if (weakSelf.count) {
                redCell.detailTextLabel.text = [NSString stringWithFormat:@"%d张可用优惠券", weakSelf.count];
                redCell.userInteractionEnabled = YES;
                redCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                redCell.detailTextLabel.textColor = BASECOLOR;
            }else {
                redCell.userInteractionEnabled = NO;
                redCell.detailTextLabel.text = @"暂无可用优惠券";
                redCell.detailTextLabel.textColor = UIColorGray;
                redCell.accessoryType = UITableViewCellAccessoryNone;
            }
        }];
        if (sender.hasText) {
            cell.detailTextLabel.text = [NSString stringWithFormat:@"¥ %@", sender.text];
            self.buyOrder.enabled = YES;
        }else {
            cell.detailTextLabel.text = @"¥ 0.00";
            self.buyOrder.enabled = NO;
        }
    }
    [self.buyOrder setTitle:[NSString stringWithFormat:@"%@元 确认买单", cell.detailTextLabel.text] forState:UIControlStateNormal];
}

- (void)buyOrderDidClick {
    QMUITableViewCell *cell = [self cellForRow:0 inSection:2];
    HEBOrderPayViewController *orderPay = [[HEBOrderPayViewController alloc] init];
    orderPay.isHiddenHeader = YES;
    orderPay.type = @"1";
    orderPay.weChatPayHost = BayOrerWeChatPay;
    orderPay.shopid = self.shopid;
    orderPay.total_price = self.headerView.moneyField.text;
    orderPay.pay_price = cell.detailTextLabel.text.removeSpace.removeMoneySymbol;
    orderPay.re_money = [NSString stringWithFormat:@"%.2f", orderPay.pay_price.doubleValue-orderPay.pay_price.doubleValue];
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    [parmas setObject:getUser_id forKey:@"user_id"];
    [parmas setObject:self.shopid forKey:@"shop_id"];
    [parmas setObject:@"1" forKey:@"type"];
    [parmas setObject:orderPay.total_price forKey:@"total_price"];
    [parmas setObject:orderPay.pay_price forKey:@"pay_price"];
    [parmas setObject:orderPay.re_money forKey:@"re_money"];
    if (self.key.length) {
        [parmas setObject:self.value forKey:self.key];
    }
    orderPay.balanceParams = parmas;
    orderPay.money = orderPay.pay_price;
    orderPay.balancePayHost = BayOrerBalancePay;
    orderPay.payMsg = @"美食买单";
    orderPay.shopName = self.shopName;
    orderPay.paySuccessMsg = @"温馨提示: 请与商家核对后再关闭此页面";
    orderPay.happyMoneyPayHost = BuyOrderHappyMoneyPay;
    orderPay.happyMoneyParmas = parmas;
    @weakify(orderPay);
    orderPay.paySuccess = ^{
        [weak_orderPay.navigationController.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[NSClassFromString(@"HEBShopDetailsViewController") class]]) {
                [weak_orderPay.navigationController popToViewController:obj animated:YES];
            }
        }];
    };
    [self.viewController.navigationController pushViewController:orderPay animated:YES];
}

- (NSArray<NSDictionary *> *)cellModelArr {
    if (!_cellModelArr) {
        _cellModelArr = @[@{@"select":@"Y"}, @{@"select":@""}];
    }
    return _cellModelArr;
}

@end
