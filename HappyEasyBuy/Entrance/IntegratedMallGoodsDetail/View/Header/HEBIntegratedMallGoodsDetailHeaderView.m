//
//  HEBIntegratedMallGoodsDetailHeaderView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/16.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBIntegratedMallGoodsDetailHeaderView.h"

@implementation HEBIntegratedMallGoodsDetailHeaderView

- (void)loadView {
    self.backgroundColor = UIColorWhite;
    UIImageView *icon = [[UIImageView alloc] init];
    selfClass(icon);
    [self addSubview:icon];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(10);
        make.bottom.equalTo(self.mas_bottom).offset(-40);
        make.height.equalTo(icon.mas_height);
        make.width.equalTo(icon.mas_height).offset(20);
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    QMUILabel *name = [[QMUILabel alloc] init];
    name.dividingLine = YES;
    selfClass(name);
    name.font = UIFontMake(16);
    name.textColor = BASEBLACK;
    [self addSubview:name];
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom);
        make.height.mas_offset(30);
        make.left.right.equalTo(self);
    }];
    
}

@end
