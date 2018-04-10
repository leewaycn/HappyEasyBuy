//
//  HEBFoodSnatchOrderPaymentModel.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/30.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HEBFoodSnatchOrderPaymentCouponModel;
@class HEBFoodSnatchOrderPaymentCouponDetailModel;
@class HEBFoodSnatchOrderPaymentRedDetailModel;

@interface HEBFoodSnatchOrderPaymentModel : NSObject

/** 套餐id */
@property(nonatomic, copy) NSString *f_id;

/** 套餐名 */
@property(nonatomic, copy) NSString *f_name;

/** 套餐封面图片 */
@property(nonatomic, copy) NSString *f_pic;

/** 套餐描述 */
@property(nonatomic, copy) NSString *f_name_account;

/** 价格 */
@property(nonatomic, copy) NSString *f_price;

@end

@interface HEBFoodSnatchOrderPaymentCouponModel : NSObject

/** 店铺优惠券 */
@property(nonatomic, strong) NSArray<HEBFoodSnatchOrderPaymentCouponDetailModel *> *shopCoupon;

/** 乐享红包 */
@property(nonatomic, strong) NSArray<HEBFoodSnatchOrderPaymentRedDetailModel *> *Coupon;

@end

@interface HEBFoodSnatchOrderPaymentCouponDetailModel : NSObject

/** 优惠券领取id */
@property(nonatomic, copy) NSString *objid;

/** 优惠状态 */
@property(nonatomic, assign) BOOL yh_status;

/** 店铺id */
@property(nonatomic, copy) NSString *shop_id;

/** 优惠券id */
@property(nonatomic, copy) NSString *lid;

/** 满金额可用 */
@property(nonatomic, copy) NSString *usemoney;

/** 可减金额 */
@property(nonatomic, copy) NSString *money;

/** 优惠券描述 */
@property(nonatomic, copy) NSString *yh_des;

/** 领取时间 */
@property(nonatomic, copy) NSString *stime;

/** 结束时间 */
@property(nonatomic, copy) NSString *etime;

@end

@interface HEBFoodSnatchOrderPaymentRedDetailModel : NSObject

/** 乐享红包id */
@property(nonatomic, copy) NSString *objid;

/** 结束时间 */
@property(nonatomic, copy) NSString *endtime;

/** 红包描述 */
@property(nonatomic, copy) NSString *goods_description;

/** 满减金额 */
@property(nonatomic, copy) NSString *reducemoney;

/** 满减最低金额 */
@property(nonatomic, copy) NSString *fullmoney;

@end
