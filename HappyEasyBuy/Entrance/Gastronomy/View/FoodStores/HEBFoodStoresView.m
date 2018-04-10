//
//  HEBFoodStoresView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/23.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBFoodStoresView.h"
#import "RatingBar.h"

@implementation HEBFoodStoresView

- (void)setCellWithModel:(HEBFoodStoresModel *)model {
    UIImageView *img = [[UIImageView alloc] init];
    [img yy_setImageWithURL:[NSURL URLWithString:model.imgurl] options:(YYWebImageOptionProgressive)];
    [self addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(15);
        make.top.equalTo(self.mas_top).offset(10);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
        make.width.equalTo(self.mas_height).offset(-20);
    }];
    
    QMUILabel *shopName = [[QMUILabel alloc] init];
    shopName.text = model.name;
    shopName.font = UIFontMake(14);
    [self addSubview:shopName];
    [shopName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(img.mas_top).offset(5);
        make.left.equalTo(img.mas_right).offset(8);
    }];
    
    RatingBar *start = [[RatingBar alloc] init];
    start.isIndicator = YES;
    [start setImageDeselected:@"星评_未选中" halfSelected:nil fullSelected:@"星评_选中" andDelegate:nil];
    [start displayRating:model.score];
    [self addSubview:start];
    [start mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(shopName.mas_left);
        make.top.equalTo(shopName.mas_bottom).offset(5);
        make.size.mas_offset(CGSizeMake(70, 15));
    }];
    
    QMUILabel *address = [[QMUILabel alloc] init];
    address.text = model.address;
    address.font = UIFontMake(11);
    address.textColor = BASEBLACK;
    [self addSubview:address];
    [address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(shopName.mas_left);
        make.top.equalTo(start.mas_bottom).offset(5);
    }];
    
    QMUILabel *averaging = [[QMUILabel alloc] init];
    averaging.font = UIFontMake(11);
    averaging.attributedText = [Tools toolsEditColorString:[NSString stringWithFormat:@"人均 ¥%@", model.avgprice] searchString:[NSString stringWithFormat:@"¥%@", model.avgprice] firstColor:BASEBLACK secondColor:BASECOLOR];
    [self addSubview:averaging];
    [averaging mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(start.mas_bottom);
        make.left.equalTo(start.mas_right).offset(15);
    }];
    
    QMUILabel *distance = [[QMUILabel alloc] init];
    distance.textColor = BASEBLACK;
    distance.font = UIFontMake(14);
    distance.text = [NSString stringWithFormat:@"%@", model.distance];
    [self addSubview:distance];
    [distance mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(start.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-15);
    }];
    
}

@end
