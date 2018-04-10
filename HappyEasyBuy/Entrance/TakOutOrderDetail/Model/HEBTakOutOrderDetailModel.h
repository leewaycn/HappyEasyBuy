//
//  HEBTakOutOrderDetailModel.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/15.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HEBTakOutBuyCarModel.h"
#import "HEBFoodSnatchOrderPaymentModel.h"
@class HEBTakOutOrderUseINFOModel;
@class HEBTakOutOrderShopINFOModel;

@interface HEBTakOutOrderDetailModel : NSObject

/** 送达时间 */
@property(nonatomic, copy) NSString *serve;

/** 商品信息 */
@property(nonatomic, strong) NSArray<HEBTakOutBuyCarModel *> *goods_list;

/** 收货人信息 */
@property(nonatomic, strong) HEBTakOutOrderUseINFOModel *address;

/** 商家信息 */
@property(nonatomic, strong) HEBTakOutOrderShopINFOModel *shop_info;

/** 店铺优惠券 */
@property(nonatomic, strong) NSArray<HEBFoodSnatchOrderPaymentCouponDetailModel *> *shop_coupon;

/** 乐享红包 */
@property(nonatomic, strong) NSArray<HEBFoodSnatchOrderPaymentRedDetailModel *> *coupon;

@end

@interface HEBTakOutOrderUseINFOModel : NSObject

/** 地址id */
@property(nonatomic, copy) NSString *objid;

/** 用户名 */
@property(nonatomic, copy) NSString *name;

/** 手机号 */
@property(nonatomic, copy) NSString *mobile;

/** 地址 */
@property(nonatomic, copy) NSString *address;

/** 暂存送达时间 */
@property(nonatomic, copy) NSString *serve;

@end

@interface HEBTakOutOrderShopINFOModel :  NSObject

/** 商铺名称 */
@property(nonatomic, copy) NSString *name;

/** 商铺图片 */
@property(nonatomic, copy) NSString *pic;

/** 配送方式 */
@property(nonatomic, copy) NSString *send_status;

/** 配送费 */
@property(nonatomic, copy) NSString *delivery;

@end
