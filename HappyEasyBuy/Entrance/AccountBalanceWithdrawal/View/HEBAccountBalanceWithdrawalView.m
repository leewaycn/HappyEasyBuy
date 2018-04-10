//
//  HEBAccountBalanceWithdrawalView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/28.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBAccountBalanceWithdrawalView.h"
#import "HEBPCAModel.h"

@interface HEBAccountBalanceWithdrawalView ()<QMUITableViewDataSource, QMUITableViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource>

@property(nonatomic, strong) NSMutableArray<NSDictionary *> *importantINFO;

@property(nonatomic, strong) NSArray<HEBPCAModel *> *pcaModelArr;

/** 暂存省 */
@property(nonatomic, assign) NSInteger province;

/** 暂存市 */
@property(nonatomic, assign) NSInteger city;

/** 暂存区 */
@property(nonatomic, assign) NSInteger area;



@end

@implementation HEBAccountBalanceWithdrawalView

- (void)loadView {
    self.delegate = self;
    self.dataSource = self;
    self.province = 0;
    self.city = 0;
    self.area = 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.withdrawalINFO.count?3:0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section==0?self.withdrawalINFO.count:section==1?7:1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section==0?25:44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section==0?30:10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        UIView *header = [[UIView alloc] init];
        header.backgroundColor = UIColorWhite;
        QMUILabel *lab = [[QMUILabel alloc] init];
        lab.text = @"申请提现";
        lab.font = UIFontMake(16);
        lab.textColor = BASEBLACK;
        [header addSubview:lab];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
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
        cell = [[QMUITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }else {
        while (cell.contentView.subviews.lastObject) {
            [cell.contentView.subviews.lastObject removeFromSuperview];
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        QMUILabel *msg = [[QMUILabel alloc] init];
        msg.font = UIFontMake(14);
        msg.textColor = BASECOLOR;
        msg.attributedText = [Tools toolsEditColorString:self.withdrawalINFO[indexPath.row][@"title"] searchString:[NSString stringWithFormat:@"%@", self.withdrawalINFO[indexPath.row][@"search"]] firstColor:BASEBLACK secondColor:BASECOLOR];
        [cell.contentView addSubview:msg];
        [msg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(cell.mas_centerY);
            make.left.equalTo(cell.contentView.mas_left).offset(15);
        }];
    }else if (indexPath.section == 1) {
        cell.bottomLine = YES;
        QMUILabel *title = [[QMUILabel alloc] init];
        title.tag = indexPath.row+200;
        title.textColor = BASEBLACK;
        title.text = self.importantINFO[indexPath.row][@"title"];
        title.font = UIFontMake(16);
        [cell.contentView addSubview:title];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(cell.contentView.mas_centerY);
            make.left.equalTo(cell.contentView.mas_left).offset(15);
            make.width.mas_offset(120);
        }];
        QMUITextField *content = [[QMUITextField alloc] init];
        content.clearButtonMode = UITextFieldViewModeWhileEditing;
        content.placeholder = self.importantINFO[indexPath.row][@"placeholder"];
        content.text = self.importantINFO[indexPath.row][@"content"];
        content.font = UIFontMake(16);
        content.tag = indexPath.row+100;
        [cell.contentView addSubview:content];
        [content mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(cell.contentView);
            make.left.equalTo(title.mas_right);
            make.right.equalTo(cell.contentView.mas_right).offset(-15);
        }];
        __weak __typeof(self)weakSelf = self;
        [content addBlockForControlEvents:UIControlEventEditingChanged block:^(id  _Nonnull sender) {
            QMUITextField *field = sender;
            if (field.tag == 100) {
                NSArray<NSString *> *strArr = [field.text componentsSeparatedByString:@"."];
                if (strArr.count == 2) {
                    if (strArr.lastObject.length > 2) {
                        field.text = field.text.qmui_stringByRemoveLastCharacter;
                        return;
                    }
                }else if(strArr.count > 2) {
                    field.text = field.text.qmui_stringByRemoveLastCharacter;
                    return;
                }
            }
            NSDictionary *dict = weakSelf.importantINFO[indexPath.row];
            [weakSelf.importantINFO replaceObjectAtIndex:indexPath.row withObject:@{@"title":dict[@"title"], @"placeholder":dict[@"placeholder"], @"content":field.text}];
        }];
        if ([self.importantINFO[indexPath.row][@"title"] isEqualToString:@"提现金额"]) {
            content.tail = YES;
        }
        if ([self.importantINFO[indexPath.row][@"title"] isEqualToString:@"电话"]) {
            content.keyboardType = UIKeyboardTypeNumberPad;
            content.maximumTextLength = 11;
        }
        if ([self.importantINFO[indexPath.row][@"title"] isEqualToString:@"银行卡号"]) {
            content.keyboardType = UIKeyboardTypeNumberPad;
        }
        if ([self.importantINFO[indexPath.row][@"title"] isEqualToString:@"开户银行所在地"]) {
           __weak __typeof(self)weakSelf = self;
            [content addBlockForControlEvents:UIControlEventEditingDidBegin block:^(QMUITextField  * sender) {
                 sender.text = [NSString stringWithFormat:@"%@%@%@", weakSelf.pcaModelArr[weakSelf.province].name, weakSelf.pcaModelArr[weakSelf.province].city[weakSelf.city].name, weakSelf.pcaModelArr[weakSelf.province].city[weakSelf.city].area[weakSelf.area]];
            }];
            UIPickerView *pick = [[UIPickerView alloc] init];
            pick.tag = indexPath.row;
            pick.dataSource = self;
            pick.delegate = self;
            content.inputView = pick;
        }
    }else {
        cell.backgroundColor = self.backgroundColor;
        QMUIButton *pay = [[QMUIButton alloc] init];
        pay.backgroundColor = BASECOLOR;
        [pay addTarget:self action:@selector(payDidClick) forControlEvents:UIControlEventTouchUpInside];
        [pay setTitle:@"确认申请提现" forState:UIControlStateNormal];
        [pay setTitleColor:UIColorWhite forState:UIControlStateNormal];
        pay.titleLabel.font = UIFontMake(16);
        [cell.contentView addSubview:pay];
        [pay mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cell.contentView.mas_left).offset(15);
            make.right.equalTo(cell.contentView.mas_right).offset(-15);
            make.centerY.equalTo(cell.contentView.mas_centerY);
            make.height.mas_offset(44);
        }];
        pay.layer.cornerRadius = 10;
        pay.layer.masksToBounds = YES;
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView qmui_clearsSelection];
    
}

- (void)payDidClick {
    NSArray<NSString *> *arr = @[
                     @"txprice",
                     @"txname",
                     @"txmobile",
                     @"txyh",
                     @"txfh",
                     @"txszd",
                     @"txcard"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:getUser_id forKey:@"vipid"];
    __weak __typeof(self)weakSelf = self;
    [arr enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        QMUITextField *field = [weakSelf viewWithTag:idx+100];
        if (!field.hasText) {
            QMUILabel *lab = [self viewWithTag:idx+200];
            [ISMessages showCardAlertWithTitle:@"申请失败" message:[NSString stringWithFormat:@"请检查%@是否正确", lab.text] duration:1.25 hideOnSwipe:NO hideOnTap:NO alertType:ISAlertTypeError alertPosition:ISAlertPositionTop didHide:nil];
            *stop = YES;
        }else if (idx+100 == 100 &&
                  (field.text.floatValue < weakSelf.model.least.floatValue ||
                  field.text.floatValue > weakSelf.model.most.floatValue)) {
            [ISMessages showCardAlertWithTitle:@"申请失败" message:@"请检查提现金额是否在允许范围内" duration:1.25 hideOnSwipe:NO hideOnTap:NO alertType:ISAlertTypeError alertPosition:ISAlertPositionTop didHide:nil];
            *stop = YES;
        }else if (idx+100 == 102 && !field.text.isMobNumber) {
            [ISMessages showCardAlertWithTitle:@"申请失败" message:@"请检查手机号是否正确" duration:1.25 hideOnSwipe:NO hideOnTap:NO alertType:ISAlertTypeError alertPosition:ISAlertPositionTop didHide:nil];
           *stop = YES;
        }else {
            [params setObject:field.text forKey:obj];
        }
    }];
    if (params.count == arr.count+1) {
        [self.viewControl.progressHUD showAnimated:YES];
        [Networking postUrl:WithdrawalRequest params:params callBack:^(id response, MainModel *mainModel, NSError *errorData) {
            [weakSelf.viewControl dismissProgressHUD];
            if (mainModel.status) {
                if (weakSelf.withdrawalSuccess) {
                    weakSelf.withdrawalSuccess([NSString stringWithFormat:@"%.2f", weakSelf.model.balance.doubleValue-[params[@"txprice"] doubleValue]]);
                }
            }else {
                [ISMessages showCardAlertWithTitle:@"申请失败" message:mainModel.msg duration:2.25 hideOnSwipe:NO hideOnTap:NO alertType:ISAlertTypeError alertPosition:ISAlertPositionTop didHide:nil];
            }
        }];
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return self.pcaModelArr.count;
    }else if (component == 1) {
        return self.pcaModelArr[self.province].city.count;
    }
    return self.pcaModelArr[self.province].city[self.city].area.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        return self.pcaModelArr[row].name;
    }else if (component == 1) {
        return self.pcaModelArr[self.province].city[row].name;
    }
    return self.pcaModelArr[self.province].city[self.city].area[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0 && self.province != row) {
        self.province = row;
        self.city = 0;
        self.area = 0;
        self.province = [pickerView selectedRowInComponent:0];
        [pickerView reloadComponent:1];
        [pickerView reloadComponent:2];
    }else if (component == 1 && self.city != row) {
        self.city = row;
        self.area = 0;
        [pickerView reloadComponent:2];
    }else {
        self.area = row;
    }
    QMUITextField *sender = [self viewWithTag:pickerView.tag+100];
    sender.text = [NSString stringWithFormat:@"%@%@%@", self.pcaModelArr[self.province].name, self.pcaModelArr[self.province].city[self.city].name, self.pcaModelArr[self.province].city[self.city].area[self.area]];
}

- (NSArray<HEBPCAModel *> *)pcaModelArr {
    if (!_pcaModelArr) {
        NSString *cityINFO = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"city" ofType:@"json"] encoding:NSUTF8StringEncoding error:nil];
        _pcaModelArr = [NSArray yy_modelArrayWithClass:[HEBPCAModel class] json:cityINFO];
    }
    return _pcaModelArr;
}

- (NSMutableArray<NSDictionary *> *)importantINFO {
    if (!_importantINFO) {
        _importantINFO = [NSMutableArray arrayWithArray:@[@{@"title":@"提现金额", @"placeholder":@"请输入提现金额", @"content":@""},
                                                          @{@"title":@"姓名", @"placeholder":@"请输入姓名", @"content":@""},
                                                          @{@"title":@"电话", @"placeholder":@"请输入电话", @"content":@""},
                                                          @{@"title":@"开户银行", @"placeholder":@"如：中国工商银行", @"content":@""},
                                                          @{@"title":@"所属分行", @"placeholder":@"如：南京白下支行", @"content":@""},
                                                          @{@"title":@"开户银行所在地", @"placeholder":@"如：江苏省南京市", @"content":@""},
                                                          @{@"title":@"银行卡号", @"placeholder":@"请输入银行卡号", @"content":@""}]];
    }
    return _importantINFO;
}

- (NSMutableArray<NSDictionary *> *)withdrawalINFO {
    if (!_withdrawalINFO) {
        _withdrawalINFO = [NSMutableArray array];
    }
    return _withdrawalINFO;
}

@end
