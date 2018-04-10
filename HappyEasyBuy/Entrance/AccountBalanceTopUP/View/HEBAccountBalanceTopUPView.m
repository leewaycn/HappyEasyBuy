//
//  HEBAccountBalanceTopUPView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/28.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBAccountBalanceTopUPView.h"
#import <WXApi.h>
#import <AlipaySDK/AlipaySDK.h>
#import "HEBWeChatModel.h"

@interface HEBAccountBalanceTopUPView ()<QMUITableViewDataSource, QMUITableViewDelegate>

@property(nonatomic, strong) NSMutableArray<NSDictionary *> *cellModel;

@property(nonatomic, strong) QMUITextField *moneyField;

@end

@implementation HEBAccountBalanceTopUPView

- (void)loadView {
    self.dataSource = self;
    self.delegate = self;
    UIView *foot = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    QMUIButton *pay = [[QMUIButton alloc] init];
    pay.backgroundColor = BASECOLOR;
    [pay addTarget:self action:@selector(payDidClick) forControlEvents:UIControlEventTouchUpInside];
    [pay setTitle:@"确认支付" forState:UIControlStateNormal];
    [pay setTitleColor:UIColorWhite forState:UIControlStateNormal];
    pay.titleLabel.font = UIFontMake(16);
    [foot addSubview:pay];
    [pay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(foot.mas_left).offset(15);
        make.right.equalTo(foot.mas_right).offset(-15);
        make.centerY.equalTo(foot.mas_centerY);
        make.height.mas_offset(44);
    }];
    pay.layer.cornerRadius = 10;
    pay.layer.masksToBounds = YES;
    self.tableFooterView = foot;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cellModel.count+1;
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
    cell.dividingLine = YES;
    if (indexPath.row == self.cellModel.count) {
        QMUILabel *title = [[QMUILabel alloc] init];
        title.text = @"金额";
        title.font = UIFontMake(16);
        title.textColor = BASEBLACK;
        [cell.contentView addSubview:title];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(cell.contentView.mas_centerY);
            make.left.equalTo(cell.contentView.mas_left).offset(15);
            make.width.mas_offset(40);
        }];
        QMUITextField *moneyField = [[QMUITextField alloc] init];
        selfClass(moneyField);
        moneyField.clearButtonMode = UITextFieldViewModeWhileEditing;
        moneyField.placeholder = @"请输入充值金额";
        moneyField.tail = YES;
        moneyField.font = UIFontMake(16);
        [cell.contentView addSubview:moneyField];
        [moneyField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(title.mas_right);
            make.right.equalTo(cell.contentView.mas_right).offset(-10);
            make.top.bottom.equalTo(cell.contentView);
        }];
        return cell;
    }
    NSString *imgName = [self.cellModel[indexPath.row][@"select"] length]?@"支付方式选中":@"支付方式未选中";
    UIImageView *select = [[UIImageView alloc] initWithImage:UIImageMake(imgName)];
    [cell.contentView addSubview:select];
    [select mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(cell.contentView.mas_centerY);
        make.right.equalTo(cell.contentView.mas_right).offset(-15);
    }];
    UIImageView *img = [[UIImageView alloc] initWithImage:UIImageMake(self.cellModel[indexPath.row][@"title"])];
    [cell.contentView addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(cell.contentView.mas_centerY);
        make.left.equalTo(cell.contentView.mas_left).offset(15);
    }];
    QMUILabel *title = [[QMUILabel alloc] init];
    title.text = self.cellModel[indexPath.row][@"title"];
    title.font = UIFontMake(16);
    title.textColor = BASEBLACK;
    [cell.contentView addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(img.mas_centerY);
        make.left.equalTo(img.mas_right).offset(5);
    }];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView qmui_clearsSelection];
    __weak __typeof(self)weakSelf = self;
    [self.cellModel enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == indexPath.row) {
            [weakSelf.cellModel replaceObjectAtIndex:idx withObject:@{@"title":obj[@"title"], @"select":@"Y"}];
        }else {
            [weakSelf.cellModel replaceObjectAtIndex:idx withObject:@{@"title":obj[@"title"], @"select":@""}];
        }
    }];
    [tableView reloadData];
}

- (void)payDidClick {
    self.money = self.moneyField.text;
    if (self.moneyField.hasText) {
        if ([self.cellModel.firstObject[@"select"] length]) {
            __weak __typeof(self)weakSelf = self;
            [self.viewControl.progressHUD showAnimated:YES];
            [Networking postUrl:BalanceWeChatTopup params:@{@"user_id":getUser_id, @"price":self.moneyField.text} callBack:^(id response, MainModel *mainModel, NSError *errorData) {
                [weakSelf.viewControl dismissProgressHUD];
                PayReq *payReq = [[PayReq alloc] init];
                HEBWeChatModel *model = [HEBWeChatModel yy_modelWithJSON:mainModel.data];
                payReq.sign = model.sign;
                payReq.nonceStr = model.noncestr;
                payReq.timeStamp = model.timestamp;
                payReq.package = model.package;
                payReq.prepayId = model.prepayid;
                payReq.partnerId = model.partnerid;
                [WXApi sendReq:payReq];
            }];
        }else {
            [Networking postUrl:BalanceAliTopup params:@{@"vipid":getUser_id, @"price":self.moneyField.text} callBack:^(id response, MainModel *mainModel, NSError *errorData) {
                NSLog(@"%@", response);
                [[AlipaySDK defaultService] payOrder:mainModel.data fromScheme:AliAppScheme callback:^(NSDictionary *resultDic) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"balanceAliPay" object:resultDic];
                }];
            }];
        }
    }
}

- (NSMutableArray<NSDictionary *> *)cellModel {
    if (!_cellModel) {
        _cellModel = [NSMutableArray array];
        [_cellModel addObject:@{@"title":@"微信支付", @"select":@"Y"}];
        [_cellModel addObject:@{@"title":@"支付宝支付", @"select":@""}];
    }
    return _cellModel;
}

@end
