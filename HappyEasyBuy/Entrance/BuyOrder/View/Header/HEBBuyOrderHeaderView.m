//
//  HEBBuyOrderHeaderView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/5.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBBuyOrderHeaderView.h"

@interface HEBBuyOrderHeaderView ()

@end

@implementation HEBBuyOrderHeaderView

- (void)loadView {
    self.dividingLine = YES;
    self.backgroundColor = UIColorWhite;
    QMUILabel *title = [[QMUILabel alloc] init];
    title.text = @"消费总额:";
    title.font = UIFontMake(18);
    [self addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(15);
        make.centerY.equalTo(self.mas_centerY);
        make.width.mas_offset(100);
    }];
    QMUITextField *moneyField = [[QMUITextField alloc] init];
    selfClass(moneyField);
    moneyField.tail = YES;
    moneyField.clearButtonMode = UITextFieldViewModeWhileEditing;
    moneyField.placeholder = @"询问服务员后输入";
    moneyField.font = UIFontMake(18);
    moneyField.textAlignment = NSTextAlignmentRight;
    [self addSubview:moneyField];
    [moneyField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.right.equalTo(self.mas_right).offset(-15);
        make.left.equalTo(title.mas_right).offset(15);
    }];
}

@end
