//
//  HEBTakOutShopActiveCell.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/14.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBTakOutShopActiveCell.h"

@implementation HEBTakOutShopActiveCell

- (void)setCellINFO {
    UIImageView *icon = [[UIImageView alloc] init];
    selfClass(icon);
    [self.contentView addSubview:icon];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.contentView.mas_left).offset(15);
    }];
    
    QMUILabel *name = [[QMUILabel alloc] init];
    selfClass(name);
    name.font = UIFontMake(16);
    [self.contentView addSubview:name];
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(icon.mas_centerY);
        make.left.equalTo(icon.mas_right).offset(8);
    }];
    
}

@end
