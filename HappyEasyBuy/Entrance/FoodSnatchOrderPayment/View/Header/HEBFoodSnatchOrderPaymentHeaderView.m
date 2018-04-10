
//
//  HEBFoodSnatchOrderPaymentHeaderView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/30.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBFoodSnatchOrderPaymentHeaderView.h"

@interface HEBFoodSnatchOrderPaymentHeaderView ()

/** 数量加 */
@property(nonatomic, strong) QMUIButton *countAdd;

/** 数量减 */
@property(nonatomic, strong) QMUIButton *countDel;

@end

@implementation HEBFoodSnatchOrderPaymentHeaderView

- (void)loadView {
    self.hidden = YES;
    UIImageView *icon = [[UIImageView alloc] init];
    selfClass(icon);
    [self addSubview:icon];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(15);
        make.top.equalTo(self.mas_top).offset(15);
        make.size.mas_offset(50);
    }];
    
    QMUILabel *name = [[QMUILabel alloc] init];
    name.font = UIFontMake(14);
    selfClass(name);
    [self addSubview:name];
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(icon.mas_right).offset(15);
        make.top.equalTo(icon.mas_top).offset(5);
    }];
    
    QMUILabel *des = [[QMUILabel alloc] init];
    des.font = UIFontMake(14);
    selfClass(des);
    [self addSubview:des];
    [des mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(name.mas_left);
        make.top.equalTo(name.mas_bottom).offset(5);
    }];
    
    QMUILabel *unitPrice = [[QMUILabel alloc] init];
    unitPrice.textColor = BASEBLACK;
    selfClass(unitPrice);
    unitPrice.font = UIFontMake(14);
    [self addSubview:unitPrice];
    [unitPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-15);
        make.top.equalTo(name.mas_top);
    }];
    
    QMUILabel *countlab = [[QMUILabel alloc] init];
    countlab.text = @"数量";
    countlab.textColor = BASEBLACK;
    countlab.font = UIFontMake(18);
    [self addSubview:countlab];
    [countlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(icon.mas_left);
        make.top.equalTo(icon.mas_bottom).offset(20);
    }];
    
    QMUIButton *countAdd = [[QMUIButton alloc] init];
    selfClass(countAdd);
    [countAdd setBackgroundImage:UIImageMake(@"数量加") forState:UIControlStateNormal];
    [self addSubview:countAdd];
    [countAdd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-15);
        make.centerY.equalTo(countlab.mas_centerY);
        make.size.mas_offset(countAdd.currentBackgroundImage.size);
    }];
    [countAdd addTarget:self action:@selector(countAddDidClick) forControlEvents:UIControlEventTouchUpInside];
    
    QMUITextField *count = [[QMUITextField alloc] init];
    selfClass(count);
    count.userInteractionEnabled = NO;
    count.text = @"1";
    count.textColor = BASEBLACK;
    count.font = UIFontMake(16);
    count.textAlignment = NSTextAlignmentCenter;
    count.borderStyle = UITextBorderStyleRoundedRect;
    [self addSubview:count];
    [count mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(countAdd.mas_left).offset(-10);
        make.width.mas_offset(60);
        make.height.mas_offset(33);
        make.centerY.equalTo(countAdd.mas_centerY);
    }];
    
    QMUIButton *countDel = [[QMUIButton alloc] init];
    countDel.enabled = NO;
    selfClass(countDel);
    [countDel setBackgroundImage:UIImageMake(@"数量减") forState:UIControlStateNormal];
    [self addSubview:countDel];
    [countDel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(countAdd.mas_centerY);
        make.right.equalTo(count.mas_left).offset(-10);
        make.size.mas_offset(countDel.currentBackgroundImage.size);
    }];
    [countDel addTarget:self action:@selector(countDelDidClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = UIColorHex(#e7e7e7);
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(countlab.mas_left);
        make.right.equalTo(countAdd.mas_right);
        make.top.equalTo(count.mas_bottom).offset(5);
        make.height.mas_offset(1);
    }];
    
    QMUILabel *moneylab = [[QMUILabel alloc] init];
    moneylab.text = @"小计";
    moneylab.font = UIFontMake(18);
    moneylab.textColor = BASEBLACK;
    [self addSubview:moneylab];
    [moneylab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(countlab.mas_left);
        make.top.equalTo(line.mas_bottom).offset(10);
    }];
    
    QMUILabel *money = [[QMUILabel alloc] init];
    selfClass(money);
    money.textColor = BASECOLOR;
    money.font = UIFontMake(16);
    [self addSubview:money];
    [money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(line.mas_right);
        make.centerY.equalTo(moneylab.mas_centerY);
    }];
    
}

- (void)countAddDidClick {
    self.countDel.enabled = YES;
    self.count.text = [NSString stringWithFormat:@"%d", self.count.text.intValue+1];
    self.money.text = [NSString stringWithFormat:@"¥ %.2f", self.unitPrice.text.removeSpace.removeMoneySymbol.floatValue*self.count.text.intValue];
    if (self.getMoney) {
        self.getMoney(self.money.text.removeSpace.removeMoneySymbol.floatValue);
    }
}

- (void)countDelDidClick {
    self.count.text = [NSString stringWithFormat:@"%d", self.count.text.intValue-1];
    self.money.text = [NSString stringWithFormat:@"¥ %.2f", self.unitPrice.text.removeSpace.removeMoneySymbol.floatValue*self.count.text.intValue];
    if (self.getMoney) {
        self.getMoney(self.money.text.removeSpace.removeMoneySymbol.floatValue);
    }
    if (self.count.text.intValue == 1) {
        self.countDel.enabled = NO;
    }
}

@end
