//
//  HEBPaySuccessView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2018/1/4.
//  Copyright © 2018年 happyEsayBuy. All rights reserved.
//

#import "HEBPaySuccessHeaderView.h"

@implementation HEBPaySuccessHeaderView

- (void)loadView {
    self.backgroundColor = UIColorWhite;
    UIImageView *successImg = [[UIImageView alloc] init];
    selfClass(successImg);
    [self addSubview:successImg];
    [successImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top).offset(15);
    }];
    
    QMUILabel *msg = [[QMUILabel alloc] init];
    selfClass(msg);
    msg.textColor = BASECOLOR;
    msg.font = UIFontMake(16);
    [self addSubview:msg];
    [msg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(successImg);
    }];
    
    QMUILabel *money = [[QMUILabel alloc] init];
    selfClass(money);
    money.textColor = BASECOLOR;
    money.font = UIFontMake(16);
    [self addSubview:money];
    [money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(successImg.mas_bottom).offset(10);
    }];
    
    QMUILabel *successMsg = [[QMUILabel alloc] init];
    selfClass(successMsg);
    successMsg.textColor = BASEBLACK;
    successMsg.font = UIFontMake(16);
    [self addSubview:successMsg];
    [successMsg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(money.mas_bottom).offset(10);
    }];
    
}

@end
