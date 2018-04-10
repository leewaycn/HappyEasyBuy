//
//  HEBLocationCell.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/26.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBLocationCell.h"

@implementation HEBLocationCell

- (void)setCellINFO {
    QMUILabel *address = [[QMUILabel alloc] init];
    selfClass(address);
    address.font = UIFontMake(16);
    [self.contentView addSubview:address];
    [address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.top.equalTo(self.contentView.mas_top).offset(5);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
    }];
    
    QMUILabel *userINFO = [[QMUILabel alloc] init];
    selfClass(userINFO);
    userINFO.font = UIFontMake(16);
    userINFO.textColor = BASEBLACK;
    [self.contentView addSubview:userINFO];
    [userINFO mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(address);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-3);
    }];
    
}

@end
