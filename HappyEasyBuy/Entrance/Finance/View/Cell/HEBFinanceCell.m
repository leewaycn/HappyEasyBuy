//
//  HEBFinanceCell.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/30.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBFinanceCell.h"

@implementation HEBFinanceCell

- (void)setCellINFO {
    QMUILabel *percentage = [[QMUILabel alloc] init];
    selfClass(percentage);
    percentage.font = UIFontMake(16);
    percentage.textColor = BASECOLOR;
    [self.contentView addSubview:percentage];
    [percentage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.bottom.equalTo(self.contentView.mas_centerY);
        make.right.equalTo(self.contentView.mas_centerX);
    }];
    
    QMUILabel *SPercentage = [[QMUILabel alloc] init];
    selfClass(SPercentage);
    SPercentage.font = UIFontMake(14);
    SPercentage.textColor = BASEBLACK;
    [self.contentView addSubview:SPercentage];
    [SPercentage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(percentage);
        make.top.equalTo(percentage.mas_bottom);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    
    QMUILabel *describe = [[QMUILabel alloc] init];
    selfClass(describe);
    describe.textAlignment = NSTextAlignmentCenter;
    describe.textColor = BASEBLACK;
    describe.font = UIFontMake(16);
    [self.contentView addSubview:describe];
    [describe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_centerX);
        make.right.equalTo(self.contentView.mas_right);
        make.top.bottom.equalTo(percentage);
    }];
    
    QMUILabel *SDescribe = [[QMUILabel alloc] init];
    selfClass(SDescribe);
    SDescribe.textAlignment = NSTextAlignmentCenter;
    SDescribe.textColor = BASEBLACK;
    SDescribe.font = UIFontMake(14);
    [self.contentView addSubview:SDescribe];
    [SDescribe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(describe);
        make.top.equalTo(describe.mas_bottom);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    
}

@end
