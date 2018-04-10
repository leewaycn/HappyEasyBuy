//
//  HEBMessageCell.m
//  HappyEasyBuy
//
//  Created by Dwang on 2018/1/8.
//  Copyright © 2018年 happyEsayBuy. All rights reserved.
//

#import "HEBMessageCell.h"

@implementation HEBMessageCell

- (void)setCellINFO {
    QMUILabel *title = [[QMUILabel alloc] init];
    selfClass(title);
    title.font = UIFontMake(16);
    [self.contentView addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
    }];
    
    QMUILabel *content = [[QMUILabel alloc] init];
    selfClass(content);
    content.numberOfLines = 0;
    content.textColor = BASEBLACK;
    content.font = UIFontMake(16);
    [self.contentView addSubview:content];
    [content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(title);
        make.top.equalTo(title.mas_bottom).offset(5);
    }];
    
    QMUILabel *time = [[QMUILabel alloc] init];
    selfClass(time);
    time.font = UIFontMake(14);
    time.textColor = BASEBLACK;
    [self.contentView addSubview:time];
    [time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(content.mas_right);
        make.top.equalTo(content.mas_bottom).offset(5);
    }];
    
}

@end
