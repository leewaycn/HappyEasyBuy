//
//  HEBHotelDetailHeaderView.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/23.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "QMUIView.h"
#import <SDCycleScrollView.h>

@interface HEBHotelDetailHeaderView : QMUIView

/** 轮播图 */
@property(nonatomic, strong) SDCycleScrollView *cycleScrollView;

/** 酒店名称 */
@property(nonatomic, strong) QMUILabel *msg;

/** 拨打电话 */
@property(nonatomic, strong) QMUIButton *callPhone;

/** 地图 */
@property(nonatomic, strong) QMUIButton *map;

/** 地址 */
@property(nonatomic, strong) QMUILabel *address;

/** 距离 */
@property(nonatomic, strong) QMUILabel *distance;

@end
