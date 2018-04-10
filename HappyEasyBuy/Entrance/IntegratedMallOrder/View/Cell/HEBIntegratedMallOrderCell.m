//
//  HEBIntegratedMallOrderCell.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/18.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBIntegratedMallOrderCell.h"

@implementation HEBIntegratedMallOrderCell

- (void)setCellINFO {
    QMUILabel *title = [[QMUILabel alloc] init];
    selfClass(title);
    title.font = UIFontMake(16);
    [self.contentView addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.width.mas_offset(80);
    }];
    
    QMUIButton *selectINFO = [[QMUIButton alloc] init];
    selfClass(selectINFO);
    [selectINFO setTitle:@"选择信息" forState:UIControlStateNormal];
    [selectINFO setTitleColor:BASEBLACK forState:UIControlStateNormal];
    selectINFO.titleLabel.font = UIFontMake(16);
    [self.contentView addSubview:selectINFO];
    [selectINFO mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-5);
        make.width.mas_offset(80);
        make.height.equalTo(self.contentView.mas_height).offset(-15);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    selectINFO.layer.cornerRadius = 5;
    selectINFO.layer.masksToBounds = YES;
    selectINFO.layer.borderWidth = 1;
    self.layer.borderColor = UIColorHex(#e7e7e7).CGColor;
    
    QMUITextField *infoField = [[QMUITextField alloc] init];
    selfClass(infoField);
    infoField.textColor = BASEBLACK;
    [self.contentView addSubview:infoField];
    [infoField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.left.equalTo(title.mas_right).offset(5);
        make.right.equalTo(self.contentView.mas_right).offset(-5);
    }];
    
}

@end
