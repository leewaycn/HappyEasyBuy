//
//  HEBTakOutOrderGoodsView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/16.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBTakOutOrderGoodsView.h"

@implementation HEBTakOutOrderGoodsView

- (void)loadView {
    UIImageView *icon = [[UIImageView alloc] init];
    selfClass(icon);
    [self addSubview:icon];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).offset(15);
        make.size.equalTo(self.mas_height).offset(-20);
    }];
    icon.layer.cornerRadius = icon.width/2;
    icon.layer.masksToBounds = YES;
    
    QMUILabel *money = [[QMUILabel alloc] init];
    money.textAlignment = NSTextAlignmentRight;
    selfClass(money);
    money.font = UIFontMake(14);
    money.textColor = BASEBLACK;
    [self addSubview:money];
    [money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(icon.mas_top);
        make.right.equalTo(self.mas_right).offset(-15);
        make.width.mas_offset(100);
    }];
    
    QMUILabel *name = [[QMUILabel alloc] init];
    selfClass(name);
    name.font = UIFontMake(14);
    name.textColor = BASEBLACK;
    [self addSubview:name];
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(icon.mas_centerY).offset(-3);
        make.left.equalTo(icon.mas_right).offset(15);
        make.right.equalTo(money.mas_left).offset(-15);
    }];
    
    QMUILabel *count = [[QMUILabel alloc] init];
    count.font = UIFontMake(14);
    count.textColor = BASEBLACK;
    selfClass(count);
    [self addSubview:count];
    [count mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(icon.mas_centerY).offset(5);
        make.left.equalTo(name.mas_left);
    }];
    
}

@end
