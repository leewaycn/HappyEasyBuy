//
//  HEBOrderFoodDetailHeaderView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/20.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBOrderFoodDetailHeaderView.h"

@implementation HEBOrderFoodDetailHeaderView

- (void)loadView {
    self.dividingLine = YES;
    UIImageView *icon = [[UIImageView alloc] init];
    selfClass(icon);
    [self addSubview:icon];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(15);
        make.top.equalTo(self.mas_top).offset(10);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
        make.width.equalTo(icon.mas_height);
    }];
    
    QMUILabel *name = [[QMUILabel alloc] init];
    selfClass(name);
    name.font = UIFontMake(16);
    name.textColor = BASEBLACK;
    [self addSubview:name];
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(icon.mas_right).offset(15);
        make.top.equalTo(icon.mas_top).offset(5);
    }];
    
    QMUILabel *des = [[QMUILabel alloc] init];
    selfClass(des);
    des.font = UIFontMake(12);
    [self addSubview:des];
    [des mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(name.mas_left);
        make.top.equalTo(name.mas_bottom).offset(2);
    }];
    
    QMUILabel *money = [[QMUILabel alloc] init];
    selfClass(money);
    money.font = UIFontMake(12);
    [self addSubview:money];
    [money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(name.mas_left);
        make.top.equalTo(des.mas_bottom).offset(5);
    }];
    
}

@end
