//
//  HEBOrderIntegratedDetailHeaderView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/22.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBOrderIntegratedDetailHeaderView.h"

@implementation HEBOrderIntegratedDetailHeaderView

- (void)loadView {
    QMUILabel *status = [[QMUILabel alloc] init];
    selfClass(status);
    status.font = UIFontMake(18);
    status.textColor = UIColorWhite;
    [self addSubview:status];
    [status mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(15);
        make.top.equalTo(self.mas_top).offset(5);
    }];
    
    QMUILabel *time = [[QMUILabel alloc] init];
    selfClass(time);
    time.font = UIFontMake(16);
    time.textColor = UIColorWhite;
    [self addSubview:time];
    [time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(status.mas_left);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    QMUILabel *orderNum = [[QMUILabel alloc] init];
    selfClass(orderNum);
    orderNum.textColor = UIColorWhite;
    orderNum.font = UIFontMake(16);
    [self addSubview:orderNum];
    [orderNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-5);
        make.left.equalTo(time.mas_left);
    }];
    
    UIImageView *icon = [[UIImageView alloc] init];
    selfClass(icon);
    [self addSubview:icon];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-15);
        make.centerY.equalTo(self.mas_centerY);
        make.size.mas_offset(60);
    }];
    icon.layer.cornerRadius = 30;
    icon.layer.masksToBounds = YES;
    
}

@end
