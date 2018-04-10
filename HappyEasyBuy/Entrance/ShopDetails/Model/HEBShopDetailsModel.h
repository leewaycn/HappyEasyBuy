//
//  HEBShopDetailsModel.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/25.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HEBShopSetMealModel;

@interface HEBShopDetailsModel : NSObject

/** 店铺ID */
@property(nonatomic, copy) NSString *shop_id;

/** 店铺名称 */
@property(nonatomic, copy) NSString *name;

/** 店铺地址 */
@property(nonatomic, copy) NSString *address;

/** /店铺电话 */
@property(nonatomic, copy) NSString *phone;

/** 营业开始时间 */
@property(nonatomic, copy) NSString *dotime;

/** 营业结束时间 */
@property(nonatomic, copy) NSString *totime;

/** 店铺经度 */
@property(nonatomic, assign) double lng;

/** 店铺纬度 */
@property(nonatomic, assign) double lat;

/** 评分 */
@property(nonatomic, assign) float score;

/** 人均价 */
@property(nonatomic, copy) NSString *avgprice;

/** 距离 */
@property(nonatomic, copy) NSString *distance;

/** 店铺宣传图片 */
@property(nonatomic, strong) NSArray<NSString *> *imgurl;

/** 套餐 */
@property(nonatomic, strong) NSArray<HEBShopSetMealModel *> *package;

@end

@interface HEBShopSetMealModel : NSObject

/** 套餐ID */
@property(nonatomic, copy) NSString *f_id;

/** 套餐名称 */
@property(nonatomic, copy) NSString *f_name;

/** 现价 */
@property(nonatomic, copy) NSString *f_price;

/** 门店价 */
@property(nonatomic, copy) NSString *f_oprice;

/** 封面图片 */
@property(nonatomic, copy) NSString *imgurl;

@end
