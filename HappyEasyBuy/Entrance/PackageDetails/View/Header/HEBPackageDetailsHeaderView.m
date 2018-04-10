//
//  HEBPackageDetailsHeaderView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/28.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBPackageDetailsHeaderView.h"

@implementation HEBPackageDetailsHeaderView

- (void)loadView {
    self.backgroundColor = UIColorWhite;
    
    //轮播图
    [self loadCycleScrollView];
    
    //商品信息
    [self loadCargoINFO];
    
}

- (void)loadCycleScrollView {
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, (IS_58INCH_SCREEN?180:170)) delegate:nil placeholderImage:nil];
    selfClass(cycleScrollView);
    cycleScrollView.showPageControl = NO;
    cycleScrollView.showPageControl = YES;
    cycleScrollView.backgroundColor = UIColorClear;
    cycleScrollView.currentPageDotColor = [UIColor orangeColor];
    cycleScrollView.pageDotColor = UIColorWhite;
    [self addSubview:cycleScrollView];
    
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = UIColorMakeWithRGBA(1, 1, 1, 0.5);
    [cycleScrollView addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.left.equalTo(cycleScrollView);
        make.height.mas_offset(44);
    }];
    
    QMUILabel *namelab = [[QMUILabel alloc] init];
    selfClass(namelab);
    namelab.textColor = UIColorWhite;
    namelab.font = UIFontMake(14);
    [bgView addSubview:namelab];
    [namelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView.mas_left).offset(15);
        make.top.equalTo(bgView.mas_top).offset(3);
    }];
    
    QMUILabel *deslab = [[QMUILabel alloc] init];
    selfClass(deslab);
    deslab.font = UIFontMake(12);
    deslab.textColor = UIColorWhite;
    [bgView addSubview:deslab];
    [deslab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(namelab.mas_left);
        make.top.equalTo(namelab.mas_bottom).offset(3);
    }];
    
}

- (void)loadCargoINFO {
    QMUILabel *pricelab = [[QMUILabel alloc] init];
    selfClass(pricelab);
    pricelab.textColor = BASECOLOR;
    pricelab.font = UIFontMake(18);
    [self addSubview:pricelab];
    [pricelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(15);
        make.top.equalTo(self.cycleScrollView.mas_bottom).offset(5);
    }];
    
    QMUILabel *infolab = [[QMUILabel alloc] init];
    selfClass(infolab);
    infolab.textColor = BASEBLACK;
    infolab.font = UIFontMake(12);
    [self addSubview:infolab];
    [infolab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(pricelab.mas_left);
        make.top.equalTo(pricelab.mas_bottom).offset(2);
    }];
    
    QMUIButton *snapUp = [[QMUIButton alloc] init];
    selfClass(snapUp);
    snapUp.backgroundColor = BASECOLOR;
    [snapUp setTitle:@"立即抢购" forState:(UIControlStateNormal)];
    [snapUp setTitleColor:UIColorWhite forState:UIControlStateNormal];
    snapUp.titleLabel.font = UIFontMake(14);
    [self addSubview:snapUp];
    [snapUp mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(pricelab.mas_top);
        make.right.equalTo(self.mas_right).offset(-15);
        make.size.mas_offset(CGSizeMake(100, 36));
    }];
    snapUp.layer.cornerRadius = 5;
    snapUp.layer.masksToBounds = YES;
    
}

@end
