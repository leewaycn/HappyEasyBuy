//
//  HEBBuyCarCargoCell.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/13.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBBuyCarCargoCell.h"

@implementation HEBBuyCarCargoCell

- (void)setCellINFO {
    UIImageView *icon = [[UIImageView alloc] init];
    selfClass(icon);
    [self.contentView addSubview:icon];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(5);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.size.equalTo(self.contentView.mas_height).offset(-20);
    }];
    
    QMUILabel *name = [[QMUILabel alloc] init];
    selfClass(name);
    [self.contentView addSubview:name];
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(icon.mas_top);
        make.left.equalTo(icon.mas_right).offset(10);
    }];
    
    QMUILabel *sku = [[QMUILabel alloc] init];
    selfClass(sku);
    sku.textColor = BASECOLOR;
    sku.font = UIFontMake(14);
    [self.contentView addSubview:sku];
    [sku mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(name.mas_bottom).offset(5);
        make.left.equalTo(name.mas_left);
    }];
    
    QMUILabel *price = [[QMUILabel alloc] init];
    selfClass(price);
    price.textColor = BASECOLOR;
    price.font = UIFontMake(14);
    [self.contentView addSubview:price];
    [price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(name.mas_left);
        make.top.equalTo(sku.mas_bottom).offset(5);
    }];
    
    QMUILabel *oprice = [[QMUILabel alloc] init];
    selfClass(oprice);
    oprice.font = UIFontMake(12);
    oprice.textColor = BASEBLACK;
    [self.contentView addSubview:oprice];
    [oprice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(price.mas_centerY);
        make.left.equalTo(price.mas_right).offset(5);
    }];
    
    QMUIButton *add = [[QMUIButton alloc] init];
    selfClass(add);
    [add setBackgroundImage:UIImageMake(@"外卖_加号") forState:UIControlStateNormal];
    [add addTarget:self action:@selector(addDidClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:add];
    [add mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.centerY.equalTo(sku.mas_centerY);
        make.size.mas_offset(add.currentBackgroundImage.size);
    }];
    QMUILabel *count = [[QMUILabel alloc] init];
    selfClass(count);
    count.font = UIFontMake(14);
    [self.contentView addSubview:count];
    [count mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(add.mas_centerY);
        make.right.equalTo(add.mas_left).offset(-5);
    }];
    QMUIButton *subtraction = [[QMUIButton alloc] init];
    selfClass(subtraction);
    [subtraction addTarget:self action:@selector(subtractionDidClick) forControlEvents:UIControlEventTouchUpInside];
    [subtraction setBackgroundImage:UIImageMake(@"外卖_减号") forState:UIControlStateNormal];
    [self.contentView addSubview:subtraction];
    [subtraction mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(add.mas_centerY);
        make.right.equalTo(count.mas_left).offset(-5);
        make.size.mas_offset(subtraction.currentBackgroundImage.size);
    }];
    
    
    
}

- (void)addDidClick {
    self.count.text = [NSString stringWithFormat:@"%d", self.count.text.intValue+1];
    if (self.getShopCountChange) {
        self.getShopCountChange(self.count.text.intValue);
    }
}

- (void)subtractionDidClick {
    self.count.text = [NSString stringWithFormat:@"%d", self.count.text.intValue-1];
    if (self.getShopCountChange) {
        self.getShopCountChange(self.count.text.intValue);
    }
}

@end
