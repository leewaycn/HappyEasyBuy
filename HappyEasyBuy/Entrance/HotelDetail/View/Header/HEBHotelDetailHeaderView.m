//
//  HEBHotelDetailHeaderView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/23.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBHotelDetailHeaderView.h"

@implementation HEBHotelDetailHeaderView

- (void)loadView {
   
    [self loadCycleScrollView];
    
    [self loadShopAddress];
    
}

- (void)loadCycleScrollView {
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, (IS_58INCH_SCREEN?170:160)) delegate:nil placeholderImage:nil];
    cycleScrollView.backgroundColor = UIColorClear;
    selfClass(cycleScrollView);
    cycleScrollView.showPageControl = YES;
    cycleScrollView.currentPageDotColor = [UIColor orangeColor];
    cycleScrollView.pageDotColor = UIColorWhite;
    [self addSubview:cycleScrollView];
    QMUILabel *msg = [[QMUILabel alloc] init];
    selfClass(msg);
    msg.textColor = UIColorWhite;
    msg.backgroundColor = UIColorMakeWithRGBA(1, 1, 1, 0.4);
    msg.font = UIFontMake(14);
    [self addSubview:msg];
    [msg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(cycleScrollView);
        make.height.mas_offset(30);
    }];
}

- (void)loadShopAddress {
    QMUIButton *callPhone = [[QMUIButton alloc] init];
    selfClass(callPhone);
    [callPhone setImage:UIImageMake(@"联系") forState:UIControlStateNormal];
    [callPhone addTarget:self action:@selector(callPhoneClik:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:callPhone];
    [callPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cycleScrollView.mas_bottom);
        make.right.bottom.equalTo(self);
        make.width.mas_offset(60);
    }];
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = UIColorHex(#e7e7e7);
    [callPhone addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(callPhone.mas_left);
        make.centerY.equalTo(callPhone.mas_centerY);
        make.height.equalTo(callPhone.mas_height).offset(-15);
        make.width.mas_offset(1);
    }];
    
    QMUIButton *map = [[QMUIButton alloc] init];
    selfClass(map);
    [self addSubview:map];
    [map mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(callPhone.mas_top);
        make.left.bottom.equalTo(self);
        make.right.equalTo(callPhone.mas_left);
    }];
    
    QMUILabel *msg = [[QMUILabel alloc] init];
    msg.text = @"地图/导航 >";
    msg.textColor = BASECOLOR;
    msg.font = UIFontMake(16);
    [map addSubview:msg];
    [msg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(map.mas_centerY);
        make.right.equalTo(map.mas_right).offset(-5);
        make.width.mas_offset(90);
    }];
    
    QMUILabel *address = [[QMUILabel alloc] init];
    selfClass(address);
    address.numberOfLines = 2;
    address.textColor = BASEBLACK;
    address.font = UIFontMake(14);
    [map addSubview:address];
    [address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(map.mas_left).offset(15);
        make.right.equalTo(msg.mas_left).offset(-2);
        make.bottom.equalTo(map.mas_centerY).offset(-2);
    }];
    
    QMUILabel *distance = [[QMUILabel alloc] init];
    selfClass(distance);
    distance.textColor = UIColorGray;
    distance.font = UIFontMake(14);
    [map addSubview:distance];
    [distance mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(address.mas_left);
        make.top.equalTo(map.mas_centerY).offset(2);
    }];
}

-(void)callPhoneClik:(QMUIButton *)callPhoneBtn{
    NSLog(@"拨打电话");
    
}

@end
