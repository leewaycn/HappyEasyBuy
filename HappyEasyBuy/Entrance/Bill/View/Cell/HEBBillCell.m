//
//  HEBBillCell.m
//  HappyEasyBuy
//
//  Created by Dwang on 2018/1/8.
//  Copyright © 2018年 happyEsayBuy. All rights reserved.
//

#import "HEBBillCell.h"

@implementation HEBBillCell

- (void)setCellINFO {
    QMUILabel *title = [[QMUILabel alloc] init];
    selfClass(title);
    title.font = UIFontMake(16);
    title.textColor = BASEBLACK;
    [self.contentView addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.top.equalTo(self.contentView.mas_top).offset(10);
    }];
}

@end
