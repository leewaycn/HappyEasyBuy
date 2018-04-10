//
//  HEBOrderFoodDetailShopINFOView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/21.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBOrderFoodDetailShopINFOView.h"

@implementation HEBOrderFoodDetailShopINFOView

- (void)loadView {
    
    QMUIButton *callPhone = [[QMUIButton alloc] init];
    selfClass(callPhone);
    [callPhone setImage:UIImageMake(@"联系") forState:UIControlStateNormal];
    [self addSubview:callPhone];
    [callPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.top.equalTo(self);
        make.width.mas_offset(60);
    }];
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = UIColorHex(#e7e7e7);
    [callPhone addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(callPhone.mas_left);
        make.centerY.equalTo(callPhone.mas_centerY);
        make.height.equalTo(callPhone.mas_height).offset(-15);
        make.width.mas_offset(1);
    }];
    
    QMUIButton *map = [[QMUIButton alloc] init];
    selfClass(map);
    [self addSubview:map];
    [map mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(self);
        make.right.equalTo(callPhone.mas_left);
    }];
    
    QMUILabel *shopName = [[QMUILabel alloc] init];
    selfClass(shopName);
    shopName.textColor = BASEBLACK;
    shopName.font = UIFontMake(16);
    [map addSubview:shopName];
    [shopName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(map.mas_left).offset(20);
        make.top.equalTo(map.mas_top).offset(5);
    }];
    
    QMUILabel *msg = [[QMUILabel alloc] init];
    msg.text = @"导航 >";
    msg.textColor = BASEBLACK;
    msg.font = UIFontMake(16);
    [map addSubview:msg];
    [msg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(map.mas_centerY);
        make.right.equalTo(map.mas_right).offset(-5);
        make.width.mas_offset(50);
    }];
    
    QMUILabel *address = [[QMUILabel alloc] init];
    selfClass(address);
    address.numberOfLines = 2;
    address.textColor = UIColorGray;
    address.font = UIFontMake(14);
    [map addSubview:address];
    [address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(shopName.mas_left);
        make.right.equalTo(msg.mas_left).offset(-2);
        make.top.equalTo(msg.mas_centerY).offset(-2);
    }];
    
}

@end
