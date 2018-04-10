//
//  HEBTakOutOrderUSEINFOView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/15.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBTakOutOrderUSEINFOView.h"

@implementation HEBTakOutOrderUSEINFOView

- (void)loadView {
    
    UIImageView *img = [[UIImageView alloc] initWithImage:UIImageMake(@"定位")];
    [self addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).offset(15);
        make.size.mas_offset(img.image.size);
    }];
    
    QMUILabel *address = [[QMUILabel alloc] init];
    selfClass(address);
    address.textColor = BASEBLACK;
    address.font = UIFontMake(14);
    [self addSubview:address];
    [address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(img.mas_top).offset(5);
        make.left.equalTo(img.mas_right).offset(15);
        make.right.equalTo(self.mas_right).offset(-15);
    }];
    
    QMUILabel *userName = [[QMUILabel alloc] init];
    selfClass(userName);
    userName.font = UIFontMake(14);
    userName.textColor = BASEBLACK;
    [self addSubview:userName];
    [userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(address.mas_left);
        make.top.equalTo(img.mas_bottom).offset(-3);
        make.right.equalTo(self.mas_centerX).offset(-25);
    }];
    
    QMUILabel *mobNumber = [[QMUILabel alloc] init];
    selfClass(mobNumber);
    mobNumber.font = UIFontMake(14);
    mobNumber.textColor = BASEBLACK;
    [self addSubview:mobNumber];
    [mobNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(userName.mas_centerY);
        make.left.equalTo(userName.mas_right).offset(15);
    }];
    
}

@end
