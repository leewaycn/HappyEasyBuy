//
//  HEBFoodSnatchOrderPaymentView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/30.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBFoodSnatchOrderPaymentView.h"

@interface HEBFoodSnatchOrderPaymentView ()<QMUITableViewDelegate, QMUITableViewDataSource>

/** cell标题 */
@property(nonatomic, strong) NSArray<NSArray<NSString *> *> *cellModelArr;

@property(nonatomic, assign) int count;

@end

@implementation HEBFoodSnatchOrderPaymentView

- (void)loadView {
    self.dataSource = self;
    self.delegate = self;
    HEBFoodSnatchOrderPaymentHeaderView *header = [[HEBFoodSnatchOrderPaymentHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 160)];
    selfClass(header);
    header.dividingLine = YES;
    self.tableHeaderView = header;
    __weak __typeof(self)weakSelf = self;
    header.getMoney = ^(CGFloat money) {
        QMUITableViewCell *moneyCell = [weakSelf cellForRow:0 inSection:1];
        moneyCell.detailTextLabel.text = [NSString stringWithFormat:@"¥ %.2f", money];
        if (weakSelf.shopReduceArr.count) {
            QMUITableViewCell *cell = [self cellForRow:0 inSection:0];
            cell.userInteractionEnabled = NO;
            cell.accessoryType = UITableViewCellAccessoryNone;
            weakSelf.count = 0;
            [weakSelf.shopReduceArr enumerateObjectsUsingBlock:^(HEBFoodSnatchOrderPaymentCouponDetailModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (money >= obj.usemoney.floatValue) {
                    weakSelf.count = weakSelf.count+1;
                }
            }];
            if (weakSelf.count > 0) {
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%d张可用优惠券", weakSelf.count];
                cell.userInteractionEnabled = YES;
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }else {
                cell.detailTextLabel.text = @"暂无可用优惠券";
            }
        }
        if (weakSelf.redArr.count) {
            QMUITableViewCell *cell = [self cellForRow:1 inSection:0];
            cell.userInteractionEnabled = NO;
            cell.accessoryType = UITableViewCellAccessoryNone;
            weakSelf.count = 0;
            [weakSelf.redArr enumerateObjectsUsingBlock:^(HEBFoodSnatchOrderPaymentRedDetailModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (money >= obj.reducemoney.floatValue) {
                    weakSelf.count = weakSelf.count+1;
                }
            }];
            if (weakSelf.count > 0) {
                cell.userInteractionEnabled = YES;
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%d张可用优惠券", weakSelf.count];
            }else {
                cell.detailTextLabel.text = @"暂无可用优惠券";
            }
        }
    };
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.cellModelArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cellModelArr[section].count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
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
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.bottomLine = YES;
    if (indexPath.section == 0) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.detailTextLabel.textColor = BASECOLOR;
    }
    if (indexPath.section == 2) {
        QMUITextField *phoneNum = [[QMUITextField alloc] init];
        phoneNum.maximumTextLength = 11;
        selfClass(phoneNum);
        phoneNum.textAlignment = NSTextAlignmentRight;
        phoneNum.text = getUser_phone;
        phoneNum.keyboardType = UIKeyboardTypeNumberPad;
        [cell.contentView addSubview:phoneNum];
        [phoneNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(cell.contentView.mas_right).offset(-15);
            make.top.bottom.equalTo(cell.contentView);
            make.left.equalTo(cell.textLabel.mas_right);
        }];
    }
    cell.textLabel.text = self.cellModelArr[indexPath.section][indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView qmui_clearsSelection];
    if (self.getCellDidClick) {
        QMUITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        self.getCellDidClick(cell.textLabel.text);
    }
}

- (NSArray<NSArray<NSString *> *> *)cellModelArr {
    if (!_cellModelArr) {
        _cellModelArr = @[@[@"商家优惠券", @"通用优惠券"], @[@"实付金额"], @[@"手机号"]];
    }
    return _cellModelArr;
}

- (NSArray<HEBFoodSnatchOrderPaymentCouponDetailModel *> *)shopReduceArr {
    if (!_shopReduceArr) {
        _shopReduceArr = [NSArray array];
    }
    return _shopReduceArr;
}

- (NSArray<HEBFoodSnatchOrderPaymentRedDetailModel *> *)redArr {
    if (!_redArr) {
        _redArr = [NSArray array];
    }
    return _redArr;
}

@end
