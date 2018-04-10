//
//  HEBTakOutDetailHeaderView.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/9.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "QMUIView.h"
#import <SDCycleScrollView.h>

@interface HEBTakOutShopINFOView : QMUIView

/** 商铺图标 */
@property(nonatomic, strong) UIImageView *icon;

/** 文字轮播 */
@property(nonatomic, strong) SDCycleScrollView *cycleScroller;

/** 活动数量 */
@property(nonatomic, strong) QMUILabel *activeMsg;

/** 商铺名称 */
@property(nonatomic, strong) QMUILabel *shopName;

@end
