//
//  HEBMyCenterCell.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/27.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBMyCenterCell.h"

@implementation HEBMyCenterCell

- (void)setCellINFO {
    UIImageView *img = [[UIImageView alloc] init];
    selfClass(img);
    [self.contentView addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.contentView.mas_left).offset(15);
    }];
    
    QMUILabel *title = [[QMUILabel alloc] init];
    selfClass(title);
    title.font = UIFontMake(16);
    [self.contentView addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(img.mas_centerY);
        make.left.equalTo(img.mas_right).offset(10);
    }];
    
}

@end
