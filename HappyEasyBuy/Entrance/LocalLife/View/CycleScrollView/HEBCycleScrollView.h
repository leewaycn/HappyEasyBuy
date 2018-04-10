//
//  HEBCycleScrollView.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/14.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "QMUIView.h"
#import "HEBCycleModel.h"

@interface HEBCycleScrollView : QMUIView

/**
 创建轮播视图

 @param type 轮播图类型
 */
- (void)startLocationCycleScrollViewType:(NSString *)type;

/**
 不使用定位,直接使用自定义城市ID

 @param cityid 城市ID
 @param type 轮播图类型
 */
- (void)loadCycle:(NSString *)cityid type:(NSString *)type;

/** 获取当前城市信息 */
@property(nonatomic, copy) void (^getCityName)(NSString *cityName);

/** 获取当前轮播图点击事件 */
@property(nonatomic, copy) void (^getCycleScrollDidClick)(HEBCycleModel *cycleModel);

@end
