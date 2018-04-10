//
//  HEBOrderListCell.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/19.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBOrderListCell.h"

@implementation HEBOrderListCell

- (void)setCellINFO {
    
    UIView *bgView = [[UIView alloc] init];
    bgView.userInteractionEnabled = NO;
    bgView.backgroundColor = UIColorWhite;
    [self.contentView addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.left.equalTo(self.contentView.mas_left).offset(5);
        make.right.equalTo(self.contentView.mas_right).offset(-5);
    }];
    bgView.layer.cornerRadius = 10;
    bgView.layer.masksToBounds = YES;
    bgView.layer.borderColor = UIColorHex(#e7e7e7).CGColor;
    bgView.layer.borderWidth = 1;
    
    UIImageView *icon = [[UIImageView alloc] init];
    selfClass(icon);
    [bgView addSubview:icon];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView.mas_left).offset(15);
        make.top.equalTo(bgView.mas_top).offset(10);
        make.bottom.equalTo(bgView.mas_bottom).offset(-10);
        make.width.equalTo(bgView.mas_height);
    }];
    
    QMUILabel *name = [[QMUILabel alloc] init];
    selfClass(name);
    name.font = UIFontMake(16);
    name.textColor = BASEBLACK;
    [bgView addSubview:name];
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(icon.mas_right).offset(15);
        make.top.equalTo(icon.mas_top);
    }];
    
    QMUILabel *time = [[QMUILabel alloc] init];
    selfClass(time);
    time.font = UIFontMake(12);
    time.textColor = BASEBLACK;
    [bgView addSubview:time];
    [time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bgView.mas_centerY);
        make.left.equalTo(name.mas_left);
    }];
    
    QMUILabel *money = [[QMUILabel alloc] init];
    money.font = UIFontMake(12);
    money.textColor = BASEBLACK;
    selfClass(money);
    [bgView addSubview:money];
    [money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(time.mas_left);
        make.bottom.equalTo(icon.mas_bottom);
    }];
    
    QMUIButton *status = [[QMUIButton alloc] init];
    [status setTitleColor:BASECOLOR forState:UIControlStateNormal];
    status.titleLabel.font = UIFontMake(14);
    selfClass(status);
    [self.contentView addSubview:status];
    [status mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bgView.mas_right).offset(-10);
        make.centerY.equalTo(bgView.mas_centerY);
        make.size.mas_offset(CGSizeMake(60, 33));
    }];
    status.layer.cornerRadius = 5;
    status.layer.masksToBounds = YES;
    status.layer.borderColor = BASECOLOR.CGColor;
    status.layer.borderWidth = 1;
    
}

@end
