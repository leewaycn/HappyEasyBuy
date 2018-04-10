//
//  HEBEntertainmentDetailsTableViewCell.m
//  HappyEasyBuy
//
//  Created by 侯天龙 on 2017/12/26.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBEntertainmentDetailsTableViewCell.h"

@implementation HEBEntertainmentDetailsTableViewCell

-(void)setCellINFO {
    UIImageView *iconImage = [UIImageView new];
    selfClass(iconImage);
    [self.contentView addSubview:iconImage];
    [iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.width.height.mas_offset(60);
        
    }];
    
    QMUILabel *nameLabel = [QMUILabel new];
    nameLabel.textColor = BASEBLACK;
    selfClass(nameLabel);
    nameLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconImage.mas_right).offset(10);
        make.top.equalTo(self.contentView).offset(10);
        
    }];
    
    /** 价格 */
    QMUILabel *pricLabel = [QMUILabel new];
    selfClass(pricLabel);
    pricLabel.textColor = BASECOLOR;
    pricLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:pricLabel];
    [pricLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameLabel.mas_bottom).offset(10);
        make.left.equalTo(nameLabel);
    }];
    
    /** 售出 */
    QMUILabel *sellLabe = [QMUILabel new];
    sellLabe.textColor = BASEBLACK;
    selfClass(sellLabe);
    sellLabe.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:sellLabe];
    [sellLabe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-10);
    }];
    
}


@end
