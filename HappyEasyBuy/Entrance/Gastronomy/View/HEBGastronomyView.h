//
//  HEBGastronomyView.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/22.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>
#import "HEBOptimizationView.h"
#import "ClassificationsView.h"
#import "HEBFoodStoresView.h"
#import "HEBFilteringRulesView.h"

@interface HEBGastronomyView : QMUITableView

/** 分类导航数据源 */
@property(nonatomic, strong) NSArray<HEBClassificationModel *> *classificationModelArr;

/** 优选商品数据源 */
@property(nonatomic, strong) NSArray<HEBOptimizationModel *> *optimizationModelArr;

/** 美食店铺数据源 */
@property(nonatomic, strong) NSMutableArray<HEBFoodStoresModel *> *foodStoresModelArrM;

/** 网络筛选信息 */
@property(nonatomic, strong) NSArray<NSDictionary *> *screeningModelArr;

/** 临时存储本地筛选信息 */
@property(nonatomic, strong) NSArray<NSDictionary *> *loaclModelArr;

/** 获取本地筛选点击类目 */
@property(nonatomic, copy) void (^getLoaclScreeningDidClick)(NSString *idx);

/** 获取网络筛选点击类目 */
@property(nonatomic, copy) void (^getNetworkingScreeningDidClick)(NSString *objid);

/** 筛选视图 */
@property(nonatomic, strong) HEBFilteringRulesView *localScreeningView;
@property(nonatomic, strong) HEBFilteringRulesView *networkingScreeningView;

/** 临时存储筛选名称 */
@property(nonatomic, copy) NSString *localName;
@property(nonatomic, copy) NSString *networkingName;

@end
