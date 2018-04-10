//
//  HEBAccountBalanceTransferHeaderView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2018/1/11.
//  Copyright © 2018年 happyEsayBuy. All rights reserved.
//

#import "HEBAccountBalanceTransferHeaderView.h"

@implementation HEBAccountBalanceTransferHeaderView

- (void)loadView {
    self.dividingLine = YES;
    self.backgroundColor = UIColorWhite;
    QMUIButton *validation = [[QMUIButton alloc] init];
    selfClass(validation);
    [validation setTitle:@"下一步" forState:UIControlStateNormal];
    [validation setTitleColor:BASECOLOR forState:UIControlStateNormal];
    validation.titleLabel.font = UIFontMake(16);
    [self addSubview:validation];
    [validation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right);
        make.top.bottom.equalTo(self);
        make.width.mas_offset(80);
    }];
    
    QMUITextField *mobNumber = [[QMUITextField alloc] init];
    selfClass(mobNumber);
    mobNumber.maximumTextLength = 11;
    mobNumber.clearButtonMode = UITextFieldViewModeWhileEditing;
    mobNumber.keyboardType = UIKeyboardTypeNumberPad;
    mobNumber.placeholder = @"请输入要转入的账号";
    mobNumber.font = UIFontMake(16);
    [self addSubview:mobNumber];
    [mobNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(self);
        make.right.equalTo(validation.mas_left);
    }];
}

@end
