//
//  HEBPackageDetailsHeaderView.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/28.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "QMUIView.h"
#import <SDCycleScrollView.h>

@interface HEBPackageDetailsHeaderView : QMUIView

/** 顶部轮播图 */
@property(nonatomic, strong) SDCycleScrollView *cycleScrollView;

/** 商铺名称 */
@property(nonatomic, strong) QMUILabel *namelab;

/** 套餐简介 */
@property(nonatomic, strong) QMUILabel *deslab;

/** 现价 */
@property(nonatomic, strong) QMUILabel *pricelab;

/** 套餐相关 */
@property(nonatomic, strong) QMUILabel *infolab;

/** 立即抢购 */
@property(nonatomic, strong) QMUIButton *snapUp;

@end
