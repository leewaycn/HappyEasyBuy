//
//  HEBHEBHappyMoneyTopupRecordCell.m
//  HappyEasyBuy
//
//  Created by Dwang on 2018/1/10.
//  Copyright © 2018年 happyEsayBuy. All rights reserved.
//

#import "HEBHappyMoneyTopupRecordCell.h"

@implementation HEBHappyMoneyTopupRecordCell

- (void)setCellINFO {
    QMUILabel *order = [[QMUILabel alloc] init];
    selfClass(order);
    order.textColor = BASEBLACK;
    order.font = UIFontMake(14);
    [self.contentView addSubview:order];
    [order mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.top.equalTo(self.contentView.mas_top).offset(10);
    }];
    
    QMUILabel *type = [[QMUILabel alloc] init];
    selfClass(type);
    type.font = UIFontMake(16);
    type.textColor = BASEBLACK;
    [self.contentView addSubview:type];
    [type mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(order.mas_left);
    }];
    
    QMUILabel *money = [[QMUILabel alloc] init];
    selfClass(money);
    money.textColor = BASEBLACK;
    money.font = UIFontMake(14);
    [self.contentView addSubview:money];
    [money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(type.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
    }];
    
    QMUILabel *time = [[QMUILabel alloc] init];
    selfClass(time);
    time.textColor = BASEBLACK;
    time.font = UIFontMake(14);
    [self.contentView addSubview:time];
    [time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        make.left.equalTo(type.mas_left);
    }];
    
    QMUILabel *payMoney = [[QMUILabel alloc] init];
    selfClass(payMoney);
    payMoney.textColor = BASEBLACK;
    payMoney.font = UIFontMake(14);
    [self.contentView addSubview:payMoney];
    [payMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(time.mas_centerY);
        make.right.equalTo(money.mas_right);
    }];
    
}

@end
