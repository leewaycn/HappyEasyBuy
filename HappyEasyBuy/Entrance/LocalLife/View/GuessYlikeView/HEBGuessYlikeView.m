//
//  HEBGuessYlikeCell.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/16.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBGuessYlikeView.h"
#import "RatingBar.h"
#import <YYLabel.h>

@implementation HEBGuessYlikeView

- (void)cellforGuessYlikeModel:(HEBGuessYlikeModel *)model {
    if (self.subviews.lastObject) {
        [self.subviews.lastObject removeAllSubviews];
        [self.subviews.lastObject removeFromSuperview];
    }
    UIImageView *img = [[UIImageView alloc] init];
    [img yy_setImageWithURL:[NSURL URLWithString:model.logo] options:YYWebImageOptionProgressive];
    [self addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).offset(25);
        make.size.mas_offset(CGSizeMake(63, 55));
    }];
    
    QMUILabel *shopName = [[QMUILabel alloc] init];
    shopName.text = model.name;
    shopName.font = UIFontMake(12);
    [self addSubview:shopName];
    [shopName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(img.mas_top).offset(model.yh_description.length?-6:0);
        make.left.equalTo(img.mas_right).offset(18);
    }];
    
    RatingBar *start;
    QMUILabel *rest;
    if (model.is_status) {
        start = [[RatingBar alloc] init];
        start.isIndicator = YES;
        [start setImageDeselected:@"星评_未选中" halfSelected:nil fullSelected:@"星评_选中" andDelegate:nil];
        [start displayRating:model.score];
        [self addSubview:start];
        [start mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(shopName.mas_left);
            make.top.equalTo(shopName.mas_bottom).offset(5);
            make.size.mas_offset(CGSizeMake(70, 15));
        }];
    }else {
        rest = [[QMUILabel alloc] init];
        rest.text = @"休息中";
        rest.textColor = UIColorHex(#878787);
        rest.font = UIFontMake(12);
        [self addSubview:rest];
        [rest mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(shopName.mas_left);
            make.top.equalTo(shopName.mas_bottom).offset(5);
            make.size.mas_offset(CGSizeMake(65, 15));
        }];
    }
    
    QMUILabel *monthsPin = [[QMUILabel alloc] init];
    monthsPin.hidden = !model.sales;
    monthsPin.text = [NSString stringWithFormat:@"月售%@", model.sales];
    monthsPin.textColor = UIColorHex(#878787);
    monthsPin.font = UIFontMake(9);
    [self addSubview:monthsPin];
    [monthsPin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo((start?start:rest).mas_centerY);
        make.left.equalTo((start?start:rest).mas_right).offset(15);
    }];
    
    QMUILabel *infoMsg = [[QMUILabel alloc] init];
    infoMsg.attributedText = [Tools toolsEditColorString:[NSString stringWithFormat:@"起送¥%@ | 配送¥%@ | 人均 ¥%@", model.uptosend, model.delivery, model.avgprice] searchString:[NSString stringWithFormat:@" ¥%@", model.avgprice] firstColor:UIColorHex(#878787) secondColor:BASECOLOR];
    infoMsg.font = UIFontMake(9);
    [self addSubview:infoMsg];
    [infoMsg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo((start?start:rest).mas_left);
        make.top.equalTo((start?start:rest).mas_bottom).offset(4);
    }];
    
    QMUILabel *distance = [[QMUILabel alloc] init];
    distance.text = [NSString stringWithFormat:@"%@分钟 | %@KM", model.del_time, model.distance];
    distance.textColor = UIColorHex(#878787);
    distance.font = UIFontMake(14);
    [self addSubview:distance];
    [distance mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-25);
        make.top.equalTo(img.mas_top);
    }];
    
    if (model.yh_description.length) {
        YYTextSimpleEmoticonParser *parser = [[YYTextSimpleEmoticonParser alloc] init];
        parser.emoticonMapper = @{@"preferential":UIImageMake(@"优惠券")};
        YYLabel *preferential = [[YYLabel alloc] init];
        preferential.text = [NSString stringWithFormat:@"preferential %@", model.yh_description];
        preferential.font = UIFontMake(10);
        preferential.textColor = UIColorHex(#878787);
        preferential.textParser = parser;
        [self addSubview:preferential];
        [preferential mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(shopName.mas_left);
            make.top.equalTo(infoMsg.mas_bottom).offset(4);
        }];
    }
    
}

@end
