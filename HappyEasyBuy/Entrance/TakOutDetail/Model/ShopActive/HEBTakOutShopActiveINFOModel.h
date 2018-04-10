//
//  HEBTakOutShopINFOModel.h
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/14.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HEBTakOutShopActiveINFOModel : NSObject

/** 商家店铺ID */
@property(nonatomic, copy) NSString *shop_id;

/** 店铺名 */
@property(nonatomic, copy) NSString *name;

/** 店铺简介 */
@property(nonatomic, copy) NSString *summary;

/** 店铺地址 */
@property(nonatomic, copy) NSString *address;

/** 纬度 */
@property(nonatomic, copy) NSString *lat;

/** 经度 */
@property(nonatomic, copy) NSString *lng;

/** 电话 */
@property(nonatomic, copy) NSString *phone;

/** 关于我们 */
@property(nonatomic, copy) NSString *content;

/** 用户ID */
@property(nonatomic, copy) NSString *m_uid;

/** 1营业0不营业 */
@property(nonatomic, assign) BOOL is_status;

/** 配送开始时间 */
@property(nonatomic, copy) NSString *dctime1;

/** 配送结束时间 */
@property(nonatomic, copy) NSString *dctime2;

/** 营业开始时间 */
@property(nonatomic, copy) NSString *dotime1;

/** 营业结束时间 */
@property(nonatomic, copy) NSString *dotime2;

/** 起送价 */
@property(nonatomic, copy) NSString *uptosend;

/** 配送费 */
@property(nonatomic, copy) NSString *delivery;

/** 配送方式1:商家自送，2：达达快递 */
@property(nonatomic, copy) NSString *send_status;

/** 店铺背景图 */
@property(nonatomic, strong) NSArray<NSString *> *shoppic;

/** 店铺logo图 */
@property(nonatomic, strong) NSArray<NSString *> *shoplogo;

/** 优惠券 */
@property(nonatomic, strong) NSArray *shopCoupon;

@end
