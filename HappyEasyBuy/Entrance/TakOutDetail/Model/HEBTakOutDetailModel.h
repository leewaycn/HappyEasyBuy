//
//  HEBTakOutDetailModel.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/8.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HEBTakOutShopINFOModel;
@class HEBTakOutShopModel;
@class HEBTakOutSKUModel;

@interface HEBTakOutDetailModel : NSObject

/** 店铺信息 */
@property(nonatomic, strong) HEBTakOutShopINFOModel *shop;

/** 商铺活动 */
@property(nonatomic, strong) NSArray<NSDictionary *> *activity;

/** 店铺商品信息 */
@property(nonatomic, strong) NSArray<HEBTakOutShopModel *> *goodslist;

@end

@interface HEBTakOutShopINFOModel : NSObject

/** 店铺名称 */
@property(nonatomic, copy) NSString *name;

/** 店铺logo */
@property(nonatomic, copy) NSString *logo;

/** 配送费 */
@property(nonatomic, copy) NSString *delivery;

/** 起送价 */
@property(nonatomic, copy) NSString *uptosend;

@end

@interface HEBTakOutShopModel : NSObject

/** 商品id */
@property(nonatomic, copy) NSString *food_id;

/** 商品名称 */
@property(nonatomic, copy) NSString *name;

/** 商品分类名称 */
@property(nonatomic, copy) NSString *cname;

/** 商品月销量 */
@property(nonatomic, copy) NSString *dissells;

/** 商品图片 */
@property(nonatomic, copy) NSString *pic;

/** 商品价格 */
@property(nonatomic, copy) NSString *price;

/** 商品原价 */
@property(nonatomic, copy) NSString *oprice;

/** 商品规格,没有规格返回空 */
@property(nonatomic, strong) NSMutableArray<HEBTakOutSKUModel *> *sku;

/** 商品按分类排序 */
@property(nonatomic, assign) int sorts;

/** 数量默认为0 */
@property(nonatomic, assign) int num;


/** *******************************记录购物车数据修改及展示*********************************** */

/** 用于记录修改的下标 */
@property(nonatomic, copy) NSString *subscript;

/** 用于记录可修改的id */
@property(nonatomic, copy) NSString *sku_id;

/** 用于记录购物车展示的sku */
@property(nonatomic, copy) NSString *skuName;

/** 用于记录购物车展示的数量 */
@property(nonatomic, assign) int skuNum;

/** 用于记录购物车展示的价格 */
@property(nonatomic, copy) NSString *skuPrice;

/** 用于记录购物车sku */
@property(nonatomic, copy) NSString *sku_sku;

@end

@interface HEBTakOutSKUModel : NSObject

/** 规格id */
@property(nonatomic, copy) NSString *sku_id;

/** 数量 */
@property(nonatomic, assign) int num;

/** 价格 */
@property(nonatomic, copy) NSString *price;

/** 规格 */
@property(nonatomic, copy) NSString *sku;

/** 规格名称 */
@property(nonatomic, copy) NSString *skuattr;

@end
