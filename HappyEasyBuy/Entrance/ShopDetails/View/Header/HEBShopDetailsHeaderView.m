//
//  HEBShopDetailsHeaderView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/25.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBShopDetailsHeaderView.h"

@interface HEBShopDetailsHeaderView ()

/** 商铺基本信息视图 */
@property(nonatomic, strong) UIView *infoView;

@end

@implementation HEBShopDetailsHeaderView

- (void)loadView {
    
    self.backgroundColor = UIColorWhite;
    
    //轮播图
    [self loadCycleScrollView];
    
    //商家信息
    [self loadShopINFO];
    
    //联系方式
    [self loadContactView];
    
}

- (void)loadCycleScrollView {
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, (IS_58INCH_SCREEN?170:160)) delegate:nil placeholderImage:nil];
    cycleScrollView.backgroundColor = UIColorClear;
    selfClass(cycleScrollView);
    cycleScrollView.showPageControl = YES;
    cycleScrollView.currentPageDotColor = [UIColor orangeColor];
    cycleScrollView.pageDotColor = UIColorWhite;
    [self addSubview:cycleScrollView];
}

- (void)loadShopINFO {
    UIView *infoView = [[UIView alloc] init];
    selfClass(infoView);
    infoView.qmui_borderWidth = 1.f;
    infoView.qmui_borderColor = UIColorHex(#e7e7e7);
    infoView.qmui_borderPosition = QMUIBorderViewPositionBottom;
    [self addSubview:infoView];
    [infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cycleScrollView.mas_bottom);
        make.left.right.equalTo(self);
        make.height.mas_offset(70);
    }];
    
    QMUILabel *shopName = [[QMUILabel alloc] init];
    selfClass(shopName);
    shopName.font = UIFontMake(16);
    [infoView addSubview:shopName];
    [shopName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(infoView.mas_top).offset(10);
        make.left.equalTo(infoView.mas_left).offset(20);
    }];
    
    RatingBar *start = [[RatingBar alloc] init];
    selfClass(start);
    start.isIndicator = YES;
    [start setImageDeselected:@"星评_未选中" halfSelected:nil fullSelected:@"星评_选中" andDelegate:nil];
    [infoView addSubview:start];
    [start mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(shopName.mas_left);
        make.top.equalTo(shopName.mas_bottom).offset(5);
        make.size.mas_offset(CGSizeMake(70, 15));
    }];
    
    QMUILabel *businessHoursLab = [[QMUILabel alloc] init];
    businessHoursLab.textColor = BASEBLACK;
    businessHoursLab.font = UIFontMake(12);
    businessHoursLab.text = @"营业时间";
    [infoView addSubview:businessHoursLab];
    [businessHoursLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(shopName.mas_centerY);
        make.left.equalTo(infoView.mas_centerX).offset(10);
    }];
    
    QMUILabel *businessHours = [[QMUILabel alloc] init];
    selfClass(businessHours);
    businessHours.textColor = BASEBLACK;
    businessHours.font= UIFontMake(12);
    [infoView addSubview:businessHours];
    [businessHours mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(start.mas_top);
        make.centerX.equalTo(businessHoursLab.mas_centerX);
    }];
    
    QMUILabel *averaging = [[QMUILabel alloc] init];
    averaging.textColor = BASEBLACK;
    selfClass(averaging);
    averaging.font = UIFontMake(12);
    [infoView addSubview:averaging];
    [averaging mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(shopName.mas_left);
        make.top.equalTo(start.mas_bottom).offset(2);
    }];
    
    QMUIButton *buy = [[QMUIButton alloc] init];
    selfClass(buy);
    [buy setTitle:@"买单" forState:(UIControlStateNormal)];
    [buy setTitleColor:UIColorWhite forState:UIControlStateNormal];
    buy.backgroundColor = BASECOLOR;
    buy.titleLabel.font = UIFontMake(16);
    [infoView addSubview:buy];
    [buy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(shopName.mas_centerY);
        make.right.equalTo(infoView.mas_right).offset(-20);
        make.size.mas_offset(CGSizeMake(60, 30));
    }];
    buy.layer.cornerRadius = 2;
    buy.layer.masksToBounds = YES;
    
}

- (void)loadContactView {
    UIView *contactView = [[UIView alloc] init];
    [self addSubview:contactView];
    [contactView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.infoView.mas_bottom);
        make.left.right.bottom.equalTo(self);
    }];
    
    QMUIButton *callPhone = [[QMUIButton alloc] init];
    selfClass(callPhone);
    [callPhone setImage:UIImageMake(@"联系") forState:UIControlStateNormal];
    [contactView addSubview:callPhone];
    [callPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(contactView);
        make.width.mas_offset(80);
    }];
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = UIColorHex(#e7e7e7);
    [contactView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(contactView.mas_centerY);
        make.right.equalTo(callPhone.mas_left);
        make.width.mas_offset(1);
        make.height.equalTo(callPhone.mas_height).offset(-15);
    }];
    
    QMUIButton *address = [[QMUIButton alloc] init];
    selfClass(address);
    [address setImage:UIImageMake(@"定位") forState:UIControlStateNormal];
    [address setTitle:@"--" forState:UIControlStateNormal];
    [address setTitleColor:BASEBLACK forState:UIControlStateNormal];
    [contactView addSubview:address];
    [address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(contactView);
        make.left.equalTo(self.shopName.mas_left);
        make.right.equalTo(line.mas_left);
    }];
    address.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    address.spacingBetweenImageAndTitle = 5;
    address.titleLabel.font = UIFontMake(14);
    address.titleLabel.numberOfLines = 2;
    
}

@end
