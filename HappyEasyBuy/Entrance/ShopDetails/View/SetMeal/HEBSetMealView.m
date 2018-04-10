//
//  HEBSetMealView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/28.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBSetMealView.h"

@implementation HEBSetMealView

- (void)setMealViewWithModel:(HEBShopSetMealModel *)model {
    UIImageView *img = [[UIImageView alloc] init];
    [img yy_setImageWithURL:[NSURL URLWithString:model.imgurl] options:(YYWebImageOptionProgressive)];
    [self addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(25);
        make.top.equalTo(self.mas_top).offset(10);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
        make.width.equalTo(img.mas_height);
    }];    
    QMUILabel *name = [[QMUILabel alloc] init];
    name.text = model.f_name;
    name.font = UIFontMake(16);
    [self addSubview:name];
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(img.mas_top).offset(5);
        make.left.equalTo(img.mas_right).offset(15);
    }];
 
    QMUILabel *price = [[QMUILabel alloc] init];
    price.font = UIFontMake(12);
    price.attributedText = [Tools toolsEditColorString:[NSString stringWithFormat:@"¥ %@    市场价：%@", model.f_price, model.f_oprice] searchString:[NSString stringWithFormat:@"市场价：%@", model.f_oprice] firstColor:BASECOLOR secondColor:UIColorGray];
    [self addSubview:price];
    [price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(name.mas_left);
        make.bottom.equalTo(img.mas_bottom).offset(-10);
    }];
    
    
}

@end
