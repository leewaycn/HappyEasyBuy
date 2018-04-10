//
//  HEBShopINFOView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/29.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBPackageDetailsShopINFOView.h"

@implementation HEBPackageDetailsShopINFOView

- (void)loadView {
    QMUIButton *callPhone = [[QMUIButton alloc] init];
    selfClass(callPhone);
    [callPhone setImage:UIImageMake(@"联系") forState:UIControlStateNormal];
    [self addSubview:callPhone];
    [callPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(self);
        make.width.equalTo(callPhone.mas_height);
    }];
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = UIColorHex(#e7e7e7);
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(callPhone.mas_left);
        make.width.mas_offset(1);
        make.height.equalTo(callPhone.mas_height).offset(-35);
    }];
    
    QMUILabel *shopName = [[QMUILabel alloc] init];
    selfClass(shopName);
    shopName.font = UIFontMake(14);
    [self addSubview:shopName];
    [shopName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(5);
        make.left.equalTo(self.mas_left).offset(15);
        make.right.equalTo(callPhone.mas_left);
    }];
    
    QMUILabel *address = [[QMUILabel alloc] init];
    selfClass(address);
    address.font = UIFontMake(12);
    address.textColor = UIColorGray;
    [self addSubview:address];
    [address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(shopName.mas_left);
        make.top.equalTo(shopName.mas_bottom).offset(3);
        make.right.equalTo(callPhone.mas_left);
    }];
    
    UIImageView *img = [[UIImageView alloc] initWithImage:UIImageMake(@"定位")];
    [self addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(address.mas_left);
        make.top.equalTo(address.mas_bottom).offset(5);
        make.size.mas_offset(CGSizeMake(10, 13));
    }];
    
    QMUILabel *distance = [[QMUILabel alloc] init];
    selfClass(distance);
    distance.textColor = UIColorGray;
    distance.font = UIFontMake(12);
    [self addSubview:distance];
    [distance mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(img.mas_centerY);
        make.left.equalTo(img.mas_right).offset(5);
        make.right.equalTo(callPhone.mas_left);
    }];
    
}

@end
