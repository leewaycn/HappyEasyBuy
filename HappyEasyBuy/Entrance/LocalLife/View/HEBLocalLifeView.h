//
//  HEBLocalLifeView.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/14.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>
#import "HEBHotSellView.h"
#import "HEBOptimizationView.h"
#import "HEBGuessYlikeView.h"
#import "HEBSequencingView.h"
#import "HEBScreeningView.h"
#import "ClassificationsView.h"
#import "HEBCycleScrollView.h"

@interface HEBLocalLifeView : QMUITableView

/** 获取城市ID */
@property(nonatomic, copy) void (^getCityName)(NSString *cityName);

/** 获取筛选框点击内容 */
@property(nonatomic, copy) void (^getguessYlikeDidClick)(QMUIButton *sender);

/** 获取筛选内容 */
@property(nonatomic, copy) void (^getScreeningDidClick)(NSInteger idx);

/** 获取筛选内容 */
@property(nonatomic, copy) void (^getSelectScreeningINFO)(NSDictionary *selectINFO);

/** 分类导航数据源 */
@property(nonatomic, strong) NSArray<HEBClassificationModel *> *classificationModelArr;

/** 热销商品数据源 */
@property(nonatomic, strong) NSArray<HEBHotSellModel *> *hotSellModelArr;

/** 优选商品数据源 */
@property(nonatomic, strong) NSArray<HEBOptimizationModel *> *optimizationModelArr;

/** 猜你喜欢数据源 */
@property(nonatomic, strong) NSMutableArray <HEBGuessYlikeModel *> *guessYlikeModelArrM;

/** 排序选项model */
@property(nonatomic, strong) NSArray *sequencingCellModelArr;

/** 商家特色数据源 */
@property(nonatomic, strong) NSArray *shopCellModelArr;

/** 人均价数据源 */
@property(nonatomic, strong) NSArray *moneyCellModelArr;

/** 临时存储，防止多次创建 */
@property(nonatomic, strong) HEBSequencingView *sequencingView;
@property(nonatomic, strong) HEBScreeningView *screeningView;
@property(nonatomic, strong) HEBCycleScrollView *cycleScrollView;

/** 临时存储选中信息 */
@property(nonatomic, copy) NSString *sequencingMsg;

@end
