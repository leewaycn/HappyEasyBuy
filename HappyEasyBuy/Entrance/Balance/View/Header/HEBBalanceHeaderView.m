//
//  HEBBalanceHeaderView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/28.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBBalanceHeaderView.h"

@implementation HEBBalanceHeaderView

- (void)loadView {
    self.backgroundColor = BASECOLOR;
    QMUILabel *lab = [[QMUILabel alloc] init];
    selfClass(lab);
    lab.textColor = UIColorWhite;
    lab.font = UIFontMake(18);
    [self addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(15);
        make.top.equalTo(self.mas_top).offset(25);
    }];
    
    QMUILabel *content = [[QMUILabel alloc] init];
    selfClass(content);
    content.font = UIFontMake(16);
    content.textColor = UIColorWhite;
    [self addSubview:content];
    [content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lab.mas_bottom).offset(10);
        make.left.equalTo(lab.mas_left);
    }];
    
}

@end
