//
//  HEBIntegratedMallOrderHeaderView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/18.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBIntegratedMallOrderHeaderView.h"

@implementation HEBIntegratedMallOrderHeaderView

- (void)loadView {
    self.backgroundColor = UIColorWhite;
    self.dividingLine = YES;
    UIImageView *icon = [[UIImageView alloc] init];
    selfClass(icon);
    [self addSubview:icon];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(10);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
        make.height.equalTo(icon.mas_height);
        make.width.equalTo(icon.mas_height).offset(20);
        make.left.equalTo(self.mas_left).offset(15);
    }];
    
    QMUILabel *count = [[QMUILabel alloc] init];
    selfClass(count);
    count.textColor = BASEBLACK;
    count.font = UIFontMake(14);
    [self addSubview:count];
    [count mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(icon.mas_right).offset(15);
        make.centerY.equalTo(icon.mas_centerY);
    }];
    
    QMUILabel *name = [[QMUILabel alloc] init];
    selfClass(name);
    name.font = UIFontMake(14);
    name.textColor = BASEBLACK;
    [self addSubview:name];
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(count.mas_top).offset(-3);
        make.left.equalTo(count.mas_left);
    }];
    
    QMUILabel *integral = [[QMUILabel alloc] init];
    selfClass(integral);
    integral.font = UIFontMake(14);
    integral.textColor = BASEBLACK;
    [self addSubview:integral];
    [integral mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(count.mas_left);
        make.top.equalTo(count.mas_bottom).offset(3);
    }];
    
}

@end
