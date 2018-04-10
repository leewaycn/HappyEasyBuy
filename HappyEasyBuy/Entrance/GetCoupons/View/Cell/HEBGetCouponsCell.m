//
//  HEBGetCouponsCell.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/28.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBGetCouponsCell.h"

@implementation HEBGetCouponsCell

- (void)setCell {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = UIColorClear;
        UIView *bgView = [[UIView alloc] init];
        selfClass(bgView);
        bgView.backgroundColor = BASECOLOR;
        bgView.layer.cornerRadius = 4;
        bgView.layer.masksToBounds = YES;
        [self.contentView addSubview:bgView];
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.contentView);
            make.left.equalTo(self.contentView.mas_left).offset(15);
            make.right.equalTo(self.contentView.mas_right).offset(-15);
        }];
        
        QMUIButton *pickUp = [[QMUIButton alloc] init];
        pickUp.qmui_outsideEdge = UIEdgeInsetsMake(-35, -35, -35, -35);
        selfClass(pickUp);
        [pickUp setTitle:@"立即领取" forState:(UIControlStateNormal)];
        [pickUp setTitleColor:UIColorWhite forState:UIControlStateNormal];
        pickUp.titleLabel.font = UIFontMake(18);
        [self.contentView addSubview:pickUp];
        [pickUp mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.equalTo(bgView);
            make.width.equalTo(bgView.mas_height);
        }];
        
        QMUILabel *reduce = [[QMUILabel alloc] init];
        selfClass(reduce);
        reduce.textColor = UIColorWhite;
        reduce.font = UIFontMake(25);
        [self.contentView addSubview:reduce];
        [reduce mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(bgView.mas_top).offset(15);
            make.left.equalTo(bgView.mas_left).offset(10);
            make.right.equalTo(pickUp.mas_left);
        }];
        
        QMUILabel *conditions = [[QMUILabel alloc] init];
        selfClass(conditions);
        conditions.textColor = UIColorWhite;
        conditions.font = UIFontMake(16);
        [self.contentView addSubview:conditions];
        [conditions mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(reduce.mas_left);
            make.top.equalTo(reduce.mas_bottom).offset(5);
            make.right.equalTo(pickUp.mas_left);
        }];
        
        QMUILabel *aging = [[QMUILabel alloc] init];
        selfClass(aging);
        aging.textColor = UIColorWhite;
        aging.font = UIFontMake(16);
        [self.contentView addSubview:aging];
        [aging mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(conditions.mas_left);
            make.top.equalTo(conditions.mas_bottom).offset(5);
            make.right.equalTo(pickUp.mas_left);
        }];
        
        UIImageView *line = [[UIImageView alloc] initWithImage:UIImageMake(@"列分割")];
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(bgView);
            make.left.equalTo(pickUp.mas_left);
            make.width.mas_offset(1);
        }];
}



@end
