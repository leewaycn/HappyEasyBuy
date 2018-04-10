//
//  HEBShopDetailsHeaderView.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/25.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "QMUIView.h"
#import <SDCycleScrollView.h>
#import "RatingBar.h"

@interface HEBShopDetailsHeaderView : QMUIView

/** 顶部轮播图 */
@property(nonatomic, strong) SDCycleScrollView *cycleScrollView;

/** 商铺名称 */
@property(nonatomic, strong) QMUILabel *shopName;

/** 评分 */
@property(nonatomic, strong) RatingBar *start;

/** 营业时间 */
@property(nonatomic, strong) QMUILabel *businessHours;

/** 人均价格 */
@property(nonatomic, strong) QMUILabel *averaging;

/** 买单 */
@property(nonatomic, strong) QMUIButton *buy;

/** 拨打电话 */
@property(nonatomic, strong) QMUIButton *callPhone;

/** 地址 */
@property(nonatomic, strong) QMUIButton *address;

@end
