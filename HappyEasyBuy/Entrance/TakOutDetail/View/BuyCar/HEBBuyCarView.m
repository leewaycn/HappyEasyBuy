//
//  HEBBuyCarView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/9.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBBuyCarView.h"
#import <DWTransform.h>

@implementation HEBBuyCarView

- (void)loadView {
    UIView *buyCarBGView = [[UIView alloc] init];
    selfClass(buyCarBGView);
    buyCarBGView.backgroundColor = UIColorHex(#545454);
    [self addSubview:buyCarBGView];
    [buyCarBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(15);
        make.left.right.bottom.equalTo(self);
    }];
    
    QMUIButton *buyCar = [[QMUIButton alloc] init];
    selfClass(buyCar);
    buyCar.userInteractionEnabled = NO;
    [buyCar setBackgroundImage:UIImageMake(@"外卖_购物车") forState:UIControlStateNormal];
    [self addSubview:buyCar];
    [buyCar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(15);
        make.top.equalTo(self.mas_top);
        make.size.mas_offset(buyCar.currentBackgroundImage.size);
    }];
    
    QMUILabel *freight = [[QMUILabel alloc] init];
    selfClass(freight);
    freight.textColor = UIColorHex(#a8a8a8);
    freight.font = UIFontMake(14);
    [self addSubview:freight];
    [freight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(buyCar.mas_bottom);
        make.left.equalTo(buyCar.mas_right).offset(5);
    }];
    
    QMUILabel *lowestPrice = [[QMUILabel alloc] init];
    selfClass(lowestPrice);
    lowestPrice.textColor = UIColorHex(#a8a8a8);
    [self addSubview:lowestPrice];
    [lowestPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(buyCarBGView.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-15);
    }];
    
    QMUILabel *money = [[QMUILabel alloc] init];
    selfClass(money);
    money.text = @"总价¥0.00";
    money.font = UIFontMake(16);
    money.textColor = UIColorWhite;
    [self addSubview:money];
    [money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(freight.mas_left);
        make.bottom.equalTo(freight.mas_top).offset(-3);
    }];
    
    QMUILabel *num = [[QMUILabel alloc] init];
    num.hidden = YES;
    selfClass(num);
    num.textAlignment = NSTextAlignmentCenter;
    num.textColor = UIColorWhite;
    num.font = UIFontMake(12);
    num.backgroundColor = UIColorRed;
    [self addSubview:num];
    [num mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(buyCar.mas_top);
        make.right.equalTo(buyCar.mas_right);
        make.size.mas_offset(CGSizeMake(25, 25));
    }];
    num.layer.cornerRadius = 12.5;
    num.layer.masksToBounds = YES;
    
    QMUIButton *pay = [[QMUIButton alloc] init];
    pay.hidden = YES;
    selfClass(pay);
    pay.backgroundColor = BASECOLOR;
    pay.titleLabel.font = UIFontMake(18);
    [pay setTitleColor:UIColorWhite forState:UIControlStateNormal];
    [pay setTitle:@"去结算" forState:UIControlStateNormal];
    [self addSubview:pay];
    [pay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.buyCarBGView);
        make.right.equalTo(self.buyCarBGView.mas_right);
        make.width.mas_offset(110);
    }];
    
}

- (void)show {
    self.lowestPrice.hidden = YES;
    self.pay.hidden = NO;
}

- (void)hidden {
    self.lowestPrice.hidden = NO;
    self.pay.hidden = YES;
}

@end
