//
//  HEBOrderPayHeaderView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/30.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBOrderPayHeaderView.h"

@implementation HEBOrderPayHeaderView

- (void)loadView {
    self.backgroundColor = UIColorWhite;
    UIImageView *icon = [[UIImageView alloc] init];
    selfClass(icon);
    [self addSubview:icon];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(25);
        make.centerY.equalTo(self.mas_centerY);
        make.size.mas_offset(50);
    }];
    icon.layer.cornerRadius = 25;
    icon.layer.masksToBounds = YES;
    
    QMUILabel *name = [[QMUILabel alloc] init];
    name.font = UIFontMake(16);
    name.textColor = BASEBLACK;
    selfClass(name);
    [self addSubview:name];
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(icon.mas_right).offset(15);
        make.top.equalTo(icon.mas_top).offset(5);
    }];
    
    QMUILabel *money = [[QMUILabel alloc] init];
    money.font = UIFontMake(12);
    money.textColor = BASEBLACK;
    selfClass(money);
    [self addSubview:money];
    [money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(name.mas_left);
        make.top.equalTo(icon.mas_centerY).offset(3);
    }];
    
}

@end
