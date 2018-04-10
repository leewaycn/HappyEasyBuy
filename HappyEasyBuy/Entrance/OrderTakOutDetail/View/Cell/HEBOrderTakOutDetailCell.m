//
//  HEBOrderTakOutDetailCell.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/22.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBOrderTakOutDetailCell.h"

@implementation HEBOrderTakOutDetailCell

- (void)loadView {
    self.backgroundColor = UIColorHex(#f1f1f1);
    UIImageView *icon = [[UIImageView alloc] init];
    selfClass(icon);
    [self addSubview:icon];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).offset(15);
        make.size.equalTo(self.mas_height).offset(-15);
    }];
    
    QMUILabel *count = [[QMUILabel alloc] init];
    selfClass(count);
    count.textColor = BASEBLACK;
    count.font = UIFontMake(16);
    [self addSubview:count];
    [count mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
    
    QMUILabel *money = [[QMUILabel alloc] init];
    selfClass(money);
    money.font = UIFontMake(16);
    money.textColor = BASEBLACK;
    [self addSubview:money];
    [money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(count.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-10);
    }];
    
}

@end
