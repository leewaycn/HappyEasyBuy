//
//  HEBFinanceHeaderView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/29.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBFinanceHeaderView.h"

@implementation HEBFinanceHeaderView

- (void)loadView {
    UIView *bg = [[UIView alloc] init];
    bg.backgroundColor = BASECOLOR;
    [self addSubview:bg];
    [bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.mas_offset(80);
    }];
    QMUILabel *earningsYD = [[QMUILabel alloc] init];
    selfClass(earningsYD);
    earningsYD.font = UIFontMake(18);
    earningsYD.textColor = UIColorWhite;
    [bg addSubview:earningsYD];
    [earningsYD mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bg.mas_centerX);
        make.top.equalTo(bg.mas_top).offset(5);
    }];
    
    QMUILabel *allMoney = [[QMUILabel alloc] init];
    selfClass(allMoney);
    allMoney.textColor = UIColorWhite;
    allMoney.font = UIFontMake(18);
    [bg addSubview:allMoney];
    [allMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bg.mas_centerX);
        make.bottom.equalTo(bg.mas_bottom).offset(-20);
    }];
    for (int i = 0; i < 2; i ++) {
        QMUIButton *sender = [[QMUIButton alloc] init];
        sender.backgroundColor = UIColorWhite;
        [self addSubview:sender];
        [sender mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(bg.mas_bottom);
            make.bottom.equalTo(self.mas_bottom);
            make.width.mas_offset(SCREEN_WIDTH/2);
            make.left.equalTo(self.mas_left).offset(i*(SCREEN_WIDTH/2));
        }];
        QMUILabel *msg = [[QMUILabel alloc] init];
        msg.text = i?@"即时收益（元）":@"固定收益（元）";
        msg.font = UIFontMake(16);
        msg.textColor = BASEBLACK;
        msg.textAlignment = NSTextAlignmentCenter;
        [sender addSubview:msg];
        [msg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(sender);
            make.top.equalTo(sender.mas_centerY).offset(5);
        }];
        
        QMUILabel *content = [[QMUILabel alloc] init];
        content.font = UIFontMake(16);
        content.textColor = BASECOLOR;
        content.textAlignment = NSTextAlignmentCenter;
        [sender addSubview:content];
        [content mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(sender);
            make.bottom.equalTo(sender.mas_centerY).offset(-3);
        }];
        [self.earnings addObject:content];
    }
}

- (NSMutableArray<QMUILabel *> *)earnings {
    if (!_earnings) {
        _earnings = [NSMutableArray array];
    }
    return _earnings;
}

@end
