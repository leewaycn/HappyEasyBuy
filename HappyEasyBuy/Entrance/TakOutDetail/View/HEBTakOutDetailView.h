//
//  HEBTakOutDetailView.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/8.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "QMUIView.h"
#import "HEBTakOutShopINFOView.h"
#import "HEBFilterTypeView.h"
#import "HEBTakOutFoodListView.h"
#import "HEBTakOutDetailModel.h"
#import "HEBBuyCarView.h"
#import "HEBAllCommentsView.h"
#import "HEBShopActiveView.h"
#import "HEBBuyCarCargoView.h"
#import "HEBTakOutOrderDetailViewController.h"

@interface HEBTakOutDetailView : QMUIView

/** 店铺id */
@property(nonatomic, copy) NSString *shop_id;

/** 店铺信息 */
@property(nonatomic, strong) HEBTakOutShopINFOView *shopINFOView;

/** 左侧筛选信息 */
@property(nonatomic, strong) HEBFilterTypeView *filterTypeView;

/** 外卖食品列表 */
@property(nonatomic, strong) HEBTakOutFoodListView *footListView;

/** 食品列表 */
@property(nonatomic, strong) NSMutableArray<NSMutableArray<HEBTakOutShopModel *> *> *foodListArr;

/** 购物车🛒 */
@property(nonatomic, strong) HEBBuyCarView *buyCarView;

/** 店铺评论 */
@property(nonatomic, strong) HEBAllCommentsView *allCommentsView;

/** 店铺活动及地址 */
@property(nonatomic, strong) HEBShopActiveView *shopActiveView;

/** 临时存储 */
@property(nonatomic, strong) HEBBuyCarCargoView *buyCarCargoView;

@end
