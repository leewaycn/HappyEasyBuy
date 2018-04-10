//
//  HEBTakOutDetailHeaderView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/9.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBTakOutShopINFOView.h"

@interface HEBTakOutShopINFOView ()

@end

@implementation HEBTakOutShopINFOView

- (void)loadView {
    UIImageView *img = [[UIImageView alloc] initWithImage:UIImageMake(@"外卖背景")];
    [self addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self);
    }];
    
    UIImageView *fold = [[UIImageView alloc] initWithImage:UIImageMake(@"外卖_折")];
    [self addSubview:fold];
    [fold mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-10);
        make.left.equalTo(self.mas_left).offset(25);
        make.size.mas_offset(fold.image.size);
    }];
    
    SDCycleScrollView *cycleScroller = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(45, (IS_58INCH_SCREEN?200:160)-35, SCREEN_WIDTH-130, 33) delegate:nil placeholderImage:nil];
    cycleScroller.backgroundColor = UIColorClear;
    cycleScroller.titleLabelBackgroundColor = UIColorClear;
    selfClass(cycleScroller);
    cycleScroller.scrollDirection = UICollectionViewScrollDirectionVertical;
    cycleScroller.onlyDisplayText = YES;
    [cycleScroller disableScrollGesture];
    [self addSubview:cycleScroller];
    
    QMUILabel *activeMsg = [[QMUILabel alloc] init];
    selfClass(activeMsg);
    activeMsg.textColor = UIColorWhite;
    activeMsg.font = UIFontMake(14);
    [self addSubview:activeMsg];
    [activeMsg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(fold.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-5);
        make.left.equalTo(cycleScroller.mas_right);
    }];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = UIColorWhite;
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(cycleScroller.mas_top);
        make.left.equalTo(self.mas_left).offset(15);
        make.right.equalTo(self.mas_right).offset(-15);
        make.height.mas_offset(1);
    }];
    
    UIImageView *icon = [[UIImageView alloc] init];
    selfClass(icon);
    [self addSubview:icon];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(line.mas_bottom).offset(-8);
        make.left.equalTo(self.mas_left).offset(25);
        make.size.mas_offset(60);
    }];
    
    QMUILabel *shopName = [[QMUILabel alloc] init];
    selfClass(shopName);
    shopName.textColor = UIColorWhite;
    shopName.font = UIFontMake(18);
    [self addSubview:shopName];
    [shopName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(icon.mas_top).offset(5);
        make.left.equalTo(icon.mas_right).offset(20);
    }];
}


@end
